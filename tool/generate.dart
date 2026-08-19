// Generates the typed Render API surface from the vendored OpenAPI spec.
//
//   dart run tool/generate.dart
//
// Emits lib/src/generated/models.dart and lib/src/generated/api/*.dart.
// Nothing here is hand-edited; the hand-written facade lives above it in
// lib/src/api/ and is free to ignore or wrap any of this.
//
// A custom generator rather than an off-the-shelf one because the output has
// to sit on the existing RenderApiClient and depend on nothing beyond
// package:http, which keeps the package usable on Flutter Web. The spec makes
// that cheap: 164 schemas, one auth scheme, no discriminators, and only a
// handful of oneOf.
import 'dart:convert';
import 'dart:io';

const _header = '''
// GENERATED — do not edit. Run `dart run tool/generate.dart`.
//
// Source: tool/render-openapi.json
''';

late Map<String, dynamic> spec;
final emittedModels = <String, String>{};

void main() {
  final file = File('tool/render-openapi.json');
  if (!file.existsSync()) {
    stderr.writeln('tool/render-openapi.json not found. Run from the package root.');
    exit(1);
  }
  spec = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;

  final schemas =
      (spec['components']?['schemas'] as Map<String, dynamic>?) ?? const {};

  // ---- models -----------------------------------------------------------
  final models = StringBuffer()
    ..writeln(_header)
    ..writeln("import 'dart:core';")
    ..writeln()
    ..writeln('// ignore_for_file: unnecessary_this, prefer_single_quotes')
    ..writeln();

  final names = schemas.keys.toList()..sort();
  for (final name in names) {
    final schema = schemas[name] as Map<String, dynamic>;
    models.writeln(_emitType(_className(name), schema));
  }
  models.writeln(_helpers());

  Directory('lib/src/generated/api').createSync(recursive: true);
  File('lib/src/generated/models.dart').writeAsStringSync(models.toString());

  // ---- APIs, grouped by the first path segment --------------------------
  final groups = <String, List<_Op>>{};
  final paths = (spec['paths'] as Map<String, dynamic>);
  for (final entry in paths.entries) {
    final path = entry.key;
    final item = entry.value as Map<String, dynamic>;
    for (final method in const ['get', 'post', 'put', 'patch', 'delete']) {
      final op = item[method];
      if (op is! Map<String, dynamic>) continue;
      final group = path.split('/').where((s) => s.isNotEmpty).first;
      final shared = (item['parameters'] as List?) ?? const [];
      groups
          .putIfAbsent(group, () => [])
          .add(_Op(path, method, op, shared));
    }
  }

  final exports = <String>[];
  for (final group in groups.keys.toList()..sort()) {
    final fileName = '${_snake(group)}_api.dart';
    File('lib/src/generated/api/$fileName')
        .writeAsStringSync(_emitApi(group, groups[group]!));
    exports.add(fileName);
  }

  final barrel = StringBuffer()..writeln(_header);
  for (final e in exports..sort()) {
    barrel.writeln("export 'api/$e';");
  }
  barrel.writeln("export 'models.dart';");
  File('lib/src/generated/generated.dart').writeAsStringSync(barrel.toString());

  // A container holding every generated group, so RenderApi exposes the whole
  // API through a single field.
  final sortedGroups = groups.keys.toList()..sort();
  final endpoints = StringBuffer()
    ..writeln(_header)
    ..writeln("import '../client.dart';");
  for (final g in sortedGroups) {
    endpoints.writeln("import 'api/${_snake(g)}_api.dart';");
  }
  endpoints
    ..writeln()
    ..writeln('/// Every endpoint in the Render API, generated from the spec.')
    ..writeln('///')
    ..writeln('/// Complete but literal. Where this package offers a')
    ..writeln('/// hand-written facade — `RenderApi.workflows` and friends —')
    ..writeln('/// prefer it: those add pagination as a Stream, local')
    ..writeln('/// validation, and errors that explain themselves.')
    ..writeln('class RenderEndpoints {')
    ..writeln('  RenderEndpoints(RenderApiClient client)');
  for (var i = 0; i < sortedGroups.length; i++) {
    final g = sortedGroups[i];
    final field = _fieldName(g);
    final cls = '${_className(g)}Endpoints';
    final sep = i == 0 ? '      : ' : '        ';
    final end = i == sortedGroups.length - 1 ? ';' : ',';
    endpoints.writeln('$sep$field = $cls(client)$end');
  }
  endpoints.writeln();
  for (final g in sortedGroups) {
    endpoints.writeln('  /// `/$g` endpoints.');
    endpoints.writeln('  final ${_className(g)}Endpoints ${_fieldName(g)};');
    endpoints.writeln();
  }
  endpoints.writeln('}');
  File('lib/src/generated/endpoints.dart').writeAsStringSync(endpoints.toString());

  final ops = groups.values.fold<int>(0, (n, l) => n + l.length);
  stdout.writeln('generated ${names.length} models and $ops operations '
      'across ${groups.length} groups');
}

// ---------------------------------------------------------------------------
// Schema resolution
// ---------------------------------------------------------------------------

Map<String, dynamic> _resolve(Map<String, dynamic> node) {
  var current = node;
  var guard = 0;
  while (current[r'$ref'] is String && guard++ < 20) {
    final ref = current[r'$ref'] as String;
    dynamic target = spec;
    for (final rawPart in ref.replaceFirst('#/', '').split('/')) {
      final part = rawPart.replaceAll('~1', '/').replaceAll('~0', '~');
      target = target is List ? target[int.parse(part)] : target[part];
    }
    current = target as Map<String, dynamic>;
  }
  return current;
}

/// The class name a `$ref` points at, so nested references reuse types rather
/// than re-emitting them.
String? _refName(Map<String, dynamic> node) {
  final ref = node[r'$ref'];
  if (ref is! String) return null;
  // Only `#/components/schemas/<name>` names a reusable type. Refs that point
  // *into* a schema (…/properties/state/items) have a meaningless last
  // segment and must be treated as inline.
  const prefix = r'#/components/schemas/';
  if (!ref.startsWith(prefix)) return null;
  final rest = ref.substring(prefix.length);
  if (rest.contains('/')) return null;
  return _className(rest.replaceAll('~1', '/').replaceAll('~0', '~'));
}

// ---------------------------------------------------------------------------
// Type emission
// ---------------------------------------------------------------------------

/// Emits a class or enum for [schema], plus any nested types it needs.
String _emitType(String name, Map<String, dynamic> schema) {
  if (emittedModels.containsKey(name)) return '';
  emittedModels[name] = '';

  final resolved = _resolve(schema);

  if (resolved['enum'] is List) {
    return _emitEnum(name, resolved);
  }
  if (resolved['properties'] is Map || resolved['type'] == 'object') {
    return _emitClass(name, resolved);
  }
  // A bare alias (string, array, oneOf). Callers use the underlying type
  // directly; nothing to emit.
  return '';
}

String _emitEnum(String name, Map<String, dynamic> schema) {
  final values = (schema['enum'] as List).cast<String>();
  final buf = StringBuffer();
  final doc = schema['description'] as String?;
  if (doc != null) buf.writeln(_doc(doc));
  buf.writeln('/// Decodes unrecognised values to [unknown] rather than');
  buf.writeln('/// throwing: Render ships new values without warning.');
  buf.writeln('enum $name {');
  final seen = <String>{};
  for (final v in values) {
    final id = _enumId(v, seen);
    buf.writeln("  $id('$v'),");
  }
  // The spec occasionally has a literal "unknown" value, so the sentinel takes
  // whatever name is still free.
  final sentinel = _enumId('unknown', seen);
  buf.writeln("  /// A value this package does not know about.");
  buf.writeln("  $sentinel('');");
  buf.writeln();
  buf.writeln('  const $name(this.wireValue);');
  buf.writeln();
  buf.writeln('  /// The value exactly as Render sends it.');
  buf.writeln('  final String wireValue;');
  buf.writeln();
  buf.writeln('  static $name fromWire(Object? value) => values.firstWhere(');
  buf.writeln('        (e) => e.wireValue == value,');
  buf.writeln('        orElse: () => $sentinel,');
  buf.writeln('      );');
  buf.writeln('}');
  buf.writeln();
  return buf.toString();
}

String _emitClass(String name, Map<String, dynamic> schema) {
  final props = (schema['properties'] as Map<String, dynamic>?) ?? const {};
  final required = ((schema['required'] as List?) ?? const []).cast<String>();

  final nested = StringBuffer();
  final fields = <_Field>[];

  for (final entry in props.entries) {
    final field = _field(name, entry.key, entry.value as Map<String, dynamic>,
        required.contains(entry.key), nested);
    fields.add(field);
  }

  final buf = StringBuffer();
  final doc = schema['description'] as String?;
  if (doc != null) buf.writeln(_doc(doc));

  // A schema with no declared properties -- a oneOf, or a free-form object
  // with only additionalProperties. An empty class would be valid Dart but
  // would silently drop the payload, so carry the raw JSON instead.
  if (fields.isEmpty) {
    buf.writeln('class $name {');
    buf.writeln('  const $name(this.json);');
    buf.writeln();
    buf.writeln('  factory $name.fromJson(Map<String, Object?> json) =>');
    buf.writeln('      $name(json);');
    buf.writeln();
    buf.writeln('  /// The spec declares no fixed properties for this type, so');
    buf.writeln('  /// the payload is preserved verbatim.');
    buf.writeln('  final Map<String, Object?> json;');
    buf.writeln();
    buf.writeln('  Map<String, Object?> toJson() => json;');
    buf.writeln('}');
    buf.writeln();
    return nested.toString() + buf.toString();
  }

  buf.writeln('class $name {');
  buf.writeln('  const $name({');
  for (final f in fields) {
    buf.writeln('    ${f.nullable ? '' : 'required '}this.${f.dartName},');
  }
  buf.writeln('  });');
  buf.writeln();

  // fromJson
  buf.writeln('  factory $name.fromJson(Map<String, Object?> json) => $name(');
  for (final f in fields) {
    buf.writeln('        ${f.dartName}: ${f.decode},');
  }
  buf.writeln('      );');
  buf.writeln();

  for (final f in fields) {
    if (f.doc != null) buf.writeln(_doc(f.doc!, indent: '  '));
    // Some types (raw JSON from oneOf) are already nullable; don't double the ?.
    final q = f.dartType.endsWith('?') ? '' : (f.nullable ? '?' : '');
    buf.writeln('  final ${f.dartType}$q ${f.dartName};');
  }
  buf.writeln();

  // toJson — omits nulls so PATCH bodies only carry what was set.
  buf.writeln('  Map<String, Object?> toJson() => {');
  for (final f in fields) {
    if (f.nullable) {
      buf.writeln("        if (${f.dartName} != null) '${f.wireName}': ${f.encode},");
    } else {
      buf.writeln("        '${f.wireName}': ${f.encode},");
    }
  }
  buf.writeln('      };');
  buf.writeln('}');
  buf.writeln();

  return nested.toString() + buf.toString();
}

class _Field {
  _Field({
    required this.wireName,
    required this.dartName,
    required this.dartType,
    required this.nullable,
    required this.decode,
    required this.encode,
    this.doc,
  });

  final String wireName;
  final String dartName;
  final String dartType;
  final bool nullable;
  final String decode;
  final String encode;
  final String? doc;
}

_Field _field(String owner, String wireName, Map<String, dynamic> schema,
    bool isRequired, StringBuffer nested) {
  final dartName = _fieldName(wireName);
  final t = _dartType(owner, wireName, schema, nested);
  final access = "json['$wireName']";
  final nullable = !isRequired;

  return _Field(
    wireName: wireName,
    dartName: dartName,
    dartType: t.name,
    nullable: nullable,
    decode: t.decode(access, nullable),
    encode: t.encode(dartName, nullable),
    doc: (_resolve(schema)['description'] as String?),
  );
}

class _TypeRef {
  _TypeRef(this.name, this.decode, this.encode);
  final String name;
  final String Function(String access, bool nullable) decode;
  final String Function(String value, bool nullable) encode;
}

_TypeRef _dartType(String owner, String hint, Map<String, dynamic> schema,
    StringBuffer nested) {
  final refName = _refName(schema);
  final s = _resolve(schema);

  // A named enum or object we can reference by class name.
  if (refName != null && (s['enum'] is List || s['properties'] is Map)) {
    if (!emittedModels.containsKey(refName)) {
      nested.write(_emitType(refName, s));
    }
    if (s['enum'] is List) {
      return _TypeRef(
        refName,
        (a, n) => '$refName.fromWire($a)',
        (v, n) => n ? '$v!.wireValue' : '$v.wireValue',
      );
    }
    return _TypeRef(
      refName,
      (a, n) => n
          ? '$a == null ? null : $refName.fromJson($a! as Map<String, Object?>)'
          : '$refName.fromJson(($a as Map<String, Object?>?) ?? const {})',
      (v, n) => n ? '$v!.toJson()' : '$v.toJson()',
    );
  }

  if (s['enum'] is List && (s['type'] ?? 'string') == 'string') {
    final name = _className('$owner${_pascal(hint)}');
    nested.write(_emitEnum(name, s));
    emittedModels[name] = '';
    return _TypeRef(
      name,
      (a, n) => '$name.fromWire($a)',
      (v, n) => n ? '$v!.wireValue' : '$v.wireValue',
    );
  }

  final type = s['type'];

  if (type == 'array') {
    final items = (s['items'] as Map<String, dynamic>?) ?? const {};
    final inner = _dartType(owner, '${hint}Item', items, nested);
    return _TypeRef(
      'List<${inner.name}>',
      (a, n) => n
          ? '($a as List<Object?>?)?.map((e) => ${inner.decode('e', false)}).toList()'
          : '(($a as List<Object?>?) ?? const []).map((e) => ${inner.decode('e', false)}).toList()',
      (v, n) => n
          ? '$v!.map((e) => ${inner.encode('e', false)}).toList()'
          : '$v.map((e) => ${inner.encode('e', false)}).toList()',
    );
  }

  if (type == 'object' || s['properties'] is Map) {
    if (s['properties'] is Map) {
      final name = _className('$owner${_pascal(hint)}');
      nested.write(_emitType(name, s));
      return _TypeRef(
        name,
        (a, n) => n
            ? '$a == null ? null : $name.fromJson($a! as Map<String, Object?>)'
            : '$name.fromJson(($a as Map<String, Object?>?) ?? const {})',
        (v, n) => n ? '$v!.toJson()' : '$v.toJson()',
      );
    }
    // A free-form object (additionalProperties, or no declared shape).
    return _TypeRef(
      'Map<String, Object?>',
      (a, n) => n
          ? '$a as Map<String, Object?>?'
          : '($a as Map<String, Object?>?) ?? const {}',
      (v, n) => v,
    );
  }

  if (s['oneOf'] != null || s['anyOf'] != null) {
    // Only a handful of these, none discriminated. Left as raw JSON rather
    // than inventing a union type the spec does not actually describe.
    return _TypeRef('Object?', (a, n) => a, (v, n) => v);
  }

  switch (type) {
    case 'integer':
      return _TypeRef(
        'int',
        (a, n) => n ? '($a as num?)?.toInt()' : '($a as num?)?.toInt() ?? 0',
        (v, n) => v,
      );
    case 'number':
      return _TypeRef(
        'double',
        (a, n) =>
            n ? '($a as num?)?.toDouble()' : '($a as num?)?.toDouble() ?? 0',
        (v, n) => v,
      );
    case 'boolean':
      return _TypeRef(
        'bool',
        (a, n) => n ? '$a as bool?' : '$a as bool? ?? false',
        (v, n) => v,
      );
    case 'string':
      if (s['format'] == 'date-time') {
        return _TypeRef(
          'DateTime',
          (a, n) => n
              ? 'parseDate($a)'
              : 'parseDate($a) ?? DateTime.fromMillisecondsSinceEpoch(0)',
          (v, n) => n ? '$v!.toIso8601String()' : '$v.toIso8601String()',
        );
      }
      return _TypeRef(
        'String',
        (a, n) => n ? '$a as String?' : "$a as String? ?? ''",
        (v, n) => v,
      );
    default:
      return _TypeRef('Object?', (a, n) => a, (v, n) => v);
  }
}

String _helpers() => '''
/// Lenient ISO-8601 parsing: a malformed timestamp yields null rather than
/// failing an entire response.
DateTime? parseDate(Object? value) =>
    value is String ? DateTime.tryParse(value) : null;
''';

// ---------------------------------------------------------------------------
// API emission
// ---------------------------------------------------------------------------

class _Op {
  _Op(this.path, this.method, this.op, this.sharedParams);
  final String path;
  final String method;
  final Map<String, dynamic> op;

  /// Parameters declared on the path item rather than the operation. OpenAPI
  /// allows either, and Render uses the path-item form for every {id}.
  final List<dynamic> sharedParams;

  String get id => op['operationId'] as String;

  /// Operation parameters win over shared ones with the same name and location.
  List<dynamic> get allParams {
    final own = (op['parameters'] as List?) ?? const [];
    final seen = <String>{};
    final merged = <dynamic>[];
    for (final raw in [...own, ...sharedParams]) {
      final p = _resolve((raw as Map).cast<String, dynamic>());
      final key = '${p['in']}:${p['name']}';
      if (seen.add(key)) merged.add(raw);
    }
    return merged;
  }
}

String _emitApi(String group, List<_Op> ops) {
  final className = '${_className(group)}Endpoints';
  final body = StringBuffer();
  final used = <String>{};
  for (final op in ops) {
    var n = _camel(op.id);
    while (!used.add(n)) {
      n = '${n}_';
    }
    body.writeln(_emitMethod(n, op));
  }

  final buf = StringBuffer()
    ..writeln(_header)
    ..writeln("import '../../client.dart';");
  if (RegExp(r'\b[A-Z][A-Za-z0-9]*\.fromJson\b').hasMatch(body.toString())) {
    buf.writeln("import '../models.dart';");
  }
  buf
    ..writeln()
    ..writeln('/// Generated bindings for the `/$group` endpoints.')
    ..writeln('class $className {')
    ..writeln('  const $className(this._client);')
    ..writeln()
    ..writeln('  final RenderApiClient _client;')
    ..writeln();

  buf.write(body);
  buf.writeln('}');
  return buf.toString();
}

String _emitMethod(String name, _Op op) {
  final buf = StringBuffer();

  final summary = op.op['summary'] as String?;
  final description = op.op['description'] as String?;
  if (summary != null) buf.writeln(_doc(summary, indent: '  '));
  if (description != null && description != summary) {
    buf.writeln('  ///');
    buf.writeln(_doc(description, indent: '  '));
  }

  // Parameters
  final pathParams = <String>[];
  final queryParams = <_QueryParam>[];
  for (final raw in op.allParams) {
    final p = _resolve((raw as Map).cast<String, dynamic>());
    final loc = p['in'] as String?;
    final pname = p['name'] as String;
    if (loc == 'path') {
      pathParams.add(pname);
    } else if (loc == 'query') {
      queryParams.add(_QueryParam(pname, _fieldName(pname),
          (p['required'] as bool?) ?? false, p['description'] as String?));
    }
  }

  // Body
  final body = op.op['requestBody'] as Map<String, dynamic>?;
  final bodySchema =
      (body?['content'] as Map<String, dynamic>?)?['application/json']
          ?['schema'] as Map<String, dynamic>?;

  // Return type
  final ret = _returnType(op);

  final args = <String>[
    for (final p in pathParams) 'String ${_fieldName(p)}',
  ];
  final named = <String>[
    if (bodySchema != null) 'required Map<String, Object?> body',
    for (final q in queryParams)
      '${q.required ? 'required ' : ''}Object? ${q.dartName}',
  ];

  final signature = [
    args.join(', '),
    if (named.isNotEmpty) '{${named.join(', ')}}',
  ].where((s) => s.isNotEmpty).join(', ');

  buf.writeln('  Future<${ret.type}> $name($signature) async {');

  final dartPath = op.path.replaceAllMapped(
    RegExp(r'\{([^}]+)\}'),
    (m) => '\$${_fieldName(m[1]!)}',
  );

  final call = StringBuffer("    ${ret.needsResult ? 'final json = ' : ''}"
      "await _client.${ret.clientMethod}(\n"
      "      '${op.method.toUpperCase()}',\n"
      "      '$dartPath',\n");
  if (queryParams.isNotEmpty) {
    call.writeln('      query: {');
    for (final q in queryParams) {
      call.writeln("        '${q.wireName}': ${q.dartName},");
    }
    call.writeln('      },');
  }
  if (bodySchema != null) call.writeln('      body: body,');
  call.writeln('    );');
  buf.write(call);

  if (ret.needsResult) buf.writeln('    return ${ret.parse};');
  buf.writeln('  }');
  buf.writeln();
  return buf.toString();
}

class _QueryParam {
  _QueryParam(this.wireName, this.dartName, this.required, this.doc);
  final String wireName;
  final String dartName;
  final bool required;
  final String? doc;
}

class _Return {
  _Return(this.type, this.clientMethod, this.parse, this.needsResult);
  final String type;
  final String clientMethod;
  final String parse;
  final bool needsResult;
}

_Return _returnType(_Op op) {
  final responses = (op.op['responses'] as Map<String, dynamic>?) ?? const {};
  final ok = responses.entries
      .where((e) => e.key.startsWith('2'))
      .map((e) => _resolve((e.value as Map).cast<String, dynamic>()))
      .toList();

  if (ok.isEmpty) return _Return('void', 'send', '', false);

  final content = ok.first['content'] as Map<String, dynamic>?;
  final json = content?['application/json'] as Map<String, dynamic>?;
  if (json == null) return _Return('void', 'send', '', false);

  final schema = (json['schema'] as Map<String, dynamic>?) ?? const {};
  final refName = _refName(schema);
  final resolved = _resolve(schema);

  if (resolved['type'] == 'array') {
    final items = (resolved['items'] as Map<String, dynamic>?) ?? const {};
    final itemRef = _refName(items);
    final itemResolved = _resolve(items);
    if (itemRef != null && itemResolved['properties'] is Map) {
      return _Return(
        'List<$itemRef>',
        'sendList',
        'json.whereType<Map<String, Object?>>().map($itemRef.fromJson).toList()',
        true,
      );
    }
    return _Return('List<Object?>', 'sendList', 'json', true);
  }

  if (refName != null && resolved['properties'] is Map) {
    return _Return(refName, 'sendObject', '$refName.fromJson(json)', true);
  }
  if (resolved['properties'] is Map) {
    return _Return('Map<String, Object?>', 'sendObject', 'json', true);
  }
  return _Return('Map<String, Object?>', 'sendObject', 'json', true);
}

// ---------------------------------------------------------------------------
// Naming
// ---------------------------------------------------------------------------

final _reserved = {
  'is', 'in', 'if', 'for', 'new', 'this', 'class', 'enum', 'default', 'switch',
  'return', 'void', 'const', 'final', 'var', 'true', 'false', 'null', 'super',
  'with', 'extends', 'implements', 'static', 'abstract', 'operator', 'part',
  'show', 'hide', 'sync', 'async', 'await', 'yield', 'assert', 'break',
  'case', 'catch', 'continue', 'do', 'else', 'rethrow', 'throw', 'try',
  'while', 'get', 'set', 'external', 'factory', 'library', 'typedef',
};

List<String> _words(String raw) => raw
    .replaceAll(RegExp(r'[^A-Za-z0-9]+'), ' ')
    .replaceAllMapped(RegExp(r'([a-z0-9])([A-Z])'), (m) => '${m[1]} ${m[2]}')
    .trim()
    .split(RegExp(r'\s+'))
    .where((w) => w.isNotEmpty)
    .toList();

String _pascal(String raw) =>
    _words(raw).map((w) => w[0].toUpperCase() + w.substring(1).toLowerCase()).join();

String _camel(String raw) {
  final p = _pascal(raw);
  if (p.isEmpty) return p;
  return p[0].toLowerCase() + p.substring(1);
}

String _snake(String raw) => _words(raw).map((w) => w.toLowerCase()).join('_');

String _className(String raw) {
  var n = _pascal(raw);
  if (n.isEmpty) n = 'Unnamed';
  if (RegExp(r'^[0-9]').hasMatch(n)) n = 'N$n';
  return n;
}

/// A unique, legal Dart identifier for an enum value.
String _enumId(String raw, Set<String> seen) {
  var id = _camel(raw);
  if (id.isEmpty) id = 'empty';
  if (RegExp(r'^[0-9]').hasMatch(id)) id = 'v$id';
  if (_reserved.contains(id)) id = '${id}_';
  while (!seen.add(id)) {
    id = '${id}_';
  }
  return id;
}

String _fieldName(String raw) {
  var n = _camel(raw);
  if (n.isEmpty) n = 'value';
  if (RegExp(r'^[0-9]').hasMatch(n)) n = 'n$n';
  if (_reserved.contains(n)) n = '${n}_';
  return n;
}

String _doc(String text, {String indent = ''}) {
  final lines = text
      .trim()
      .split('\n')
      .map((l) => l.trimRight())
      .toList();
  return lines.map((l) => '$indent/// ${l.trim()}'.trimRight()).join('\n');
}
