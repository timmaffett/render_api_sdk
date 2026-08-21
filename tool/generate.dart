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

/// One generated method, remembered so the flat facade can forward to it.
class _Emitted {
  _Emitted({
    required this.group,
    required this.name,
    required this.signature,
    required this.args,
    required this.returnType,
    required this.operationId,
    required this.httpMethod,
    required this.path,
    required this.params,
    this.summary,
    this.description,
    this.bodyType,
  });

  final String group;
  final String name;
  final String signature;
  final String args;
  final String returnType;
  final String operationId;
  final String httpMethod;
  final String path;
  final List<_DocParam> params;
  final String? summary;
  final String? description;
  final String? bodyType;
}

/// A parameter as it should appear in the generated documentation.
class _DocParam {
  _DocParam(this.name, this.type, this.required, this.location, this.doc);
  final String name;
  final String type;
  final bool required;
  final String location;
  final String? doc;
}

final emittedMethods = <_Emitted>[];

/// Types generated for inline response schemas, appended to models.dart.
///
/// Roughly a third of responses describe their shape inline rather than by
/// reference. Falling back to an untyped map for those would leave a third of
/// the API without types, so each gets a class named after its operation.
final extraModels = StringBuffer();

/// Fields of every emitted model, so documentation can describe what an
/// operation actually returns rather than only naming the type.
final modelFields = <String, List<_DocField>>{};

class _DocField {
  _DocField(this.name, this.type, this.doc);
  final String name;
  final String type;
  final String? doc;
}

/// Enums already emitted, keyed by their value set.
///
/// Inline schemas repeat the same enumerations constantly — every response
/// carrying a `region` would otherwise get its own Region type, and two
/// structurally identical but distinct enums are a trap the moment a value
/// from one meets a parameter expecting the other. Identical value sets are
/// therefore one type.
final enumsByValues = <String, String>{};

String _enumKey(List<dynamic> values) => values.join('\u0000');

/// Chooses a name for every enum before anything is emitted.
///
/// Enums are deduplicated by value set, so whichever schema happened to be
/// visited first used to decide the name — which produced gems like
/// `WorkflowWithCursorWorkflowBuildConfigRuntime` for what is simply a
/// runtime. Naming them up front, after the property they describe, keeps the
/// generated API and its documentation readable.
void _planEnumNames() {
  final schemas =
      (spec['components']?['schemas'] as Map<String, dynamic>?) ?? const {};

  // A component schema that *is* an enum keeps its own name; those are the
  // most deliberate names the spec offers.
  schemas.forEach((name, schema) {
    if (schema is Map<String, dynamic> && schema['enum'] is List) {
      enumsByValues.putIfAbsent(
        _enumKey(schema['enum'] as List),
        () => _className(name),
      );
    }
  });

  // Everything else is named after the property it describes, preferring the
  // spelling that occurs most often. Where several distinct enums share a
  // property name -- `status` is used by a dozen unrelated things -- the
  // owning schema disambiguates, giving DeployStatus and JobStatus rather
  // than Status, StatusValue, StatusValueValue.
  final byProperty = <String, Map<String, int>>{};
  final byOwner = <String, Map<String, int>>{};

  void count(Map<String, Map<String, int>> into, String key, String? value) {
    if (value == null || value.isEmpty) return;
    (into[key] ??= {}).update(value, (n) => n + 1, ifAbsent: () => 1);
  }

  void walk(Object? node, String? propertyName, String? owner) {
    if (node is Map<String, dynamic>) {
      if (node['enum'] is List && propertyName != null) {
        final key = _enumKey(node['enum'] as List);
        if (!enumsByValues.containsKey(key)) {
          count(byProperty, key, propertyName);
          count(byOwner, key, owner);
        }
      }
      final props = node['properties'];
      if (props is Map<String, dynamic>) {
        props.forEach((name, child) => walk(child, name, owner));
      }
      for (final entry in node.entries) {
        if (entry.key == 'properties') continue;
        // An array inherits the property name of the array itself.
        walk(entry.value, entry.key == 'items' ? propertyName : null, owner);
      }
    } else if (node is List) {
      for (final child in node) {
        walk(child, propertyName, owner);
      }
    }
  }

  // Each component schema labels everything beneath it.
  schemas.forEach((name, schema) => walk(schema, null, name));

  // Enums declared inside an operation rather than a schema take the
  // operation's name, so a filter on list-deploys becomes ListDeploysStatus
  // rather than Status2.
  (spec['paths'] as Map<String, dynamic>).forEach((_, item) {
    (item as Map<String, dynamic>).forEach((method, op) {
      if (op is Map<String, dynamic> && op['operationId'] is String) {
        walk(op, null, op['operationId'] as String);
      }
    });
  });

  String mostCommon(Map<String, int>? counts) => counts == null
      ? ''
      : counts.entries.reduce((a, b) => b.value > a.value ? b : a).key;

  final taken = enumsByValues.values.toSet();
  for (final key in byProperty.keys) {
    final property = _className(mostCommon(byProperty[key]));
    // Check the raw value: _className turns an empty string into "Unnamed",
    // which would read as a real owner and produce UnnamedStatus.
    final rawOwner = mostCommon(byOwner[key]);
    final owner = rawOwner.isEmpty ? '' : _className(rawOwner);

    var name = property;
    if (taken.contains(name) && owner.isNotEmpty) {
      // Avoid ServiceServiceStatus when the owner already names the property.
      name = owner.endsWith(property) ? owner : '$owner$property';
    }
    var attempt = 2;
    while (!taken.add(name)) {
      name = '$property$attempt';
      attempt++;
    }
    enumsByValues[key] = name;
  }
}

void main() {
  final file = File('tool/render-openapi.json');
  if (!file.existsSync()) {
    stderr.writeln(
      'tool/render-openapi.json not found. Run from the package root.',
    );
    exit(1);
  }
  spec = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
  _planEnumNames();

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
          .add(_Op(path, method, op, shared, group));
    }
  }

  final exports = <String>[];
  final apiFiles = <String, String>{};
  for (final group in groups.keys.toList()..sort()) {
    final fileName = '${_snake(group)}_api.dart';
    apiFiles[fileName] = _emitApi(group, groups[group]!);
    exports.add(fileName);
  }

  // Written now, after API emission has contributed its inline response types.
  models.write(extraModels);
  File('lib/src/generated/models.dart').writeAsStringSync(models.toString());
  apiFiles.forEach(
    (name, source) =>
        File('lib/src/generated/api/$name').writeAsStringSync(source),
  );

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
  File(
    'lib/src/generated/endpoints.dart',
  ).writeAsStringSync(endpoints.toString());

  // A flat facade, so every call matches Render's official Node bindings
  // one for one: renderApi.listHeaders({...}) becomes render.listHeaders(...).
  final flat = StringBuffer()
    ..writeln(_header)
    ..writeln("import '../../render_api.dart';")
    ..writeln()
    ..writeln('/// Every REST operation, named exactly as Render names it.')
    ..writeln('///')
    ..writeln("/// The official Node bindings expose one flat object, so")
    ..writeln('/// `renderApi.listHeaders({serviceId, limit})` becomes')
    ..writeln('/// `render.listHeaders(serviceId: ..., limit: ...)`. Each of')
    ..writeln('/// these forwards to the grouped form on [RenderApi.raw],')
    ..writeln('/// which is the same call by a different route.')
    ..writeln('extension RenderRestApi on RenderApi {');
  final sorted = [...emittedMethods]..sort((a, b) => a.name.compareTo(b.name));
  for (final m in sorted) {
    if (m.summary != null) flat.writeln(_doc(m.summary!, indent: '  '));
    flat.writeln('  Future<${m.returnType}> ${m.name}(${m.signature}) =>');
    flat.writeln('      raw.${_fieldName(m.group)}.${m.name}(${m.args});');
    flat.writeln();
  }
  flat.writeln('}');
  File('lib/src/generated/flat.dart').writeAsStringSync(flat.toString());

  _emitDocs(groups);

  final ops = groups.values.fold<int>(0, (n, l) => n + l.length);
  stdout.writeln(
    'generated ${names.length} models and $ops operations '
    'across ${groups.length} groups',
  );

  // Formatting is part of generating, not a separate chore.
  //
  // pana scores `dart format` compliance, and almost every file in this package
  // is generated — so without this, formatting drifts back out on the next
  // regeneration and the score quietly drops again.
  final formatted = Process.runSync('dart', ['format', '.']);
  if (formatted.exitCode != 0) {
    stderr.writeln('dart format failed:\n${formatted.stderr}');
    exitCode = 1;
    return;
  }
  stdout.writeln('formatted');
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
  return current['allOf'] is List ? _flattenAllOf(current) : current;
}

/// Collapses `allOf` into one object schema.
///
/// The spec uses it only to compose plain objects -- no discriminators, no
/// conflicting members -- so merging properties and required lists is exactly
/// what it means. Without this the six env-group operations that compose their
/// responses this way fall back to an untyped map.
Map<String, dynamic> _flattenAllOf(Map<String, dynamic> node) {
  final properties = <String, dynamic>{};
  final required = <String>[];
  final merged = <String, dynamic>{
    for (final entry in node.entries)
      if (entry.key != 'allOf') entry.key: entry.value,
    'type': 'object',
  };

  for (final member in (node['allOf'] as List)) {
    final resolved = _resolve((member as Map).cast<String, dynamic>());
    properties.addAll(
      (resolved['properties'] as Map<String, dynamic>?) ?? const {},
    );
    required.addAll(
      ((resolved['required'] as List?) ?? const []).cast<String>(),
    );
    // A description on a member is better than none on the whole.
    merged['description'] ??= resolved['description'];
  }

  merged['properties'] = properties;
  merged['required'] = required.toSet().toList();
  return merged;
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

/// The members of a `oneOf` that can be told apart by the fields present.
///
/// Returns null when they cannot be — `events.details` has sixty-eight
/// variants with no distinguishing key, and `service.serviceDetails` is
/// discriminated by a sibling field this cannot see. Those stay raw JSON,
/// which is the honest type for them.
List<_UnionMember>? _discriminableUnion(Map<String, dynamic> schema) {
  final oneOf = schema['oneOf'];
  if (oneOf is! List || oneOf.length < 2) return null;

  final members = oneOf
      .map((m) => _resolve((m as Map).cast<String, dynamic>()))
      .toList();
  if (members.any((m) => m['properties'] is! Map)) return null;

  final propertySets = [
    for (final m in members)
      ((m['properties'] as Map<String, dynamic>).keys.toSet()),
  ];

  final result = <_UnionMember>[];
  for (var i = 0; i < members.length; i++) {
    final others = <String>{
      for (var j = 0; j < members.length; j++)
        if (j != i) ...propertySets[j],
    };
    final unique = propertySets[i].difference(others).toList()..sort();
    if (unique.isEmpty) return null;
    result.add(_UnionMember(members[i], unique));
  }
  return result;
}

class _UnionMember {
  _UnionMember(this.schema, this.uniqueProperties);
  final Map<String, dynamic> schema;
  final List<String> uniqueProperties;

  /// A single distinguishing field names the variant outright; several share a
  /// prefix worth using instead — dockerCommand, dockerContext -> Docker.
  String get label => uniqueProperties.length == 1
      ? _pascal(uniqueProperties.first)
      : _pascal(_words(uniqueProperties.first).first);
}

/// Emits a sealed base plus one class per variant.
String _emitSealedUnion(String name, List<_UnionMember> members) {
  final buf = StringBuffer();
  final nested = StringBuffer();

  buf.writeln('/// One of ${members.length} shapes. Which one is decided by');
  buf.writeln('/// the fields present — the spec gives no discriminator, but');
  buf.writeln('/// each variant has fields the others do not.');
  buf.writeln('sealed class $name {');
  buf.writeln('  const $name();');
  buf.writeln();
  buf.writeln('  factory $name.fromJson(Map<String, Object?> json) {');
  for (var i = 0; i < members.length - 1; i++) {
    final m = members[i];
    final test = m.uniqueProperties
        .map((p) => "json.containsKey('$p')")
        .join(' || ');
    buf.writeln('    if ($test) {');
    buf.writeln('      return $name${m.label}.fromJson(json);');
    buf.writeln('    }');
  }
  buf.writeln('    return $name${members.last.label}.fromJson(json);');
  buf.writeln('  }');
  buf.writeln();
  buf.writeln('  Map<String, Object?> toJson();');
  buf.writeln('}');
  buf.writeln();

  for (final m in members) {
    nested.write(_emitClass('$name${m.label}', m.schema, extendsName: name));
  }

  return buf.toString() + nested.toString();
}

/// Emits a class or enum for [schema], plus any nested types it needs.
String _emitType(String name, Map<String, dynamic> schema) {
  if (emittedModels.containsKey(name)) return '';
  emittedModels[name] = '';

  final resolved = _resolve(schema);

  if (resolved['enum'] is List) {
    return _emitEnum(name, resolved);
  }
  final union = _discriminableUnion(resolved);
  if (union != null) {
    return _emitSealedUnion(name, union);
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
  enumsByValues.putIfAbsent(_enumKey(values), () => name);
  emittedModels[name] = '';
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

String _emitClass(
  String name,
  Map<String, dynamic> schema, {
  String? extendsName,
}) {
  final props = (schema['properties'] as Map<String, dynamic>?) ?? const {};
  final required = ((schema['required'] as List?) ?? const []).cast<String>();

  final nested = StringBuffer();
  final fields = <_Field>[];

  for (final entry in props.entries) {
    final field = _field(
      name,
      entry.key,
      entry.value as Map<String, dynamic>,
      required.contains(entry.key),
      nested,
    );
    fields.add(field);
  }

  modelFields[name] = [
    for (final f in fields)
      _DocField(
        f.dartName,
        '${f.dartType}${f.dartType.endsWith('?') ? '' : (f.nullable ? '?' : '')}',
        f.doc,
      ),
  ];

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
    buf.writeln(
      '  /// The spec declares no fixed properties for this type, so',
    );
    buf.writeln('  /// the payload is preserved verbatim.');
    buf.writeln('  final Map<String, Object?> json;');
    buf.writeln();
    buf.writeln('  Map<String, Object?> toJson() => json;');
    buf.writeln('}');
    buf.writeln();
    return nested.toString() + buf.toString();
  }

  buf.writeln(
    extendsName == null
        ? 'class $name {'
        : 'final class $name extends $extendsName {',
  );
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
  buf.writeln(
    extendsName == null
        ? '  Map<String, Object?> toJson() => {'
        : '  @override\n  Map<String, Object?> toJson() => {',
  );
  for (final f in fields) {
    if (f.nullable) {
      buf.writeln(
        "        if (${f.dartName} != null) '${f.wireName}': ${f.encode},",
      );
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

_Field _field(
  String owner,
  String wireName,
  Map<String, dynamic> schema,
  bool isRequired,
  StringBuffer nested,
) {
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

_TypeRef _dartType(
  String owner,
  String hint,
  Map<String, dynamic> schema,
  StringBuffer nested,
) {
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
    final values = (s['enum'] as List).cast<String>();
    final name =
        enumsByValues[_enumKey(values)] ?? _className('$owner${_pascal(hint)}');
    if (!emittedModels.containsKey(name)) {
      emittedModels[name] = '';
      nested.write(_emitEnum(name, s));
    }
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
    final refName = _refName(schema);
    final union = _discriminableUnion(s);
    if (union != null) {
      final unionName = refName ?? _className('$owner${_pascal(hint)}');
      if (!emittedModels.containsKey(unionName)) {
        emittedModels[unionName] = '';
        nested.write(_emitSealedUnion(unionName, union));
      }
      return _TypeRef(
        unionName,
        (a, n) => n
            ? '$a == null ? null : $unionName.fromJson($a! as Map<String, Object?>)'
            : '$unionName.fromJson(($a as Map<String, Object?>?) ?? const {})',
        (v, n) => n ? '$v!.toJson()' : '$v.toJson()',
      );
    }
    // No distinguishing field: raw JSON is the honest type.
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
  _Op(this.path, this.method, this.op, this.sharedParams, this.group);
  final String group;
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
      queryParams.add(
        _QueryParam(
          pname,
          _fieldName(pname),
          (p['required'] as bool?) ?? false,
          p['description'] as String?,
          _queryType((p['schema'] as Map<String, dynamic>?) ?? const {}),
        ),
      );
    }
  }

  // Body
  final body = op.op['requestBody'] as Map<String, dynamic>?;
  final bodySchema =
      (body?['content']
              as Map<String, dynamic>?)?['application/json']?['schema']
          as Map<String, dynamic>?;
  final bodyType = bodySchema == null ? null : _bodyType(op, bodySchema);

  // Return type
  final ret = _returnType(op);

  // Every parameter is named, path segments included. That reads better at
  // the call site than positional ids, and mirrors the single-object argument
  // the official Node bindings take.
  final named = <String>[
    for (final p in pathParams) 'required String ${_fieldName(p)}',
    if (bodyType != null) 'required ${bodyType.type} body',
    for (final q in queryParams)
      '${q.required ? 'required ${q.type}' : '${q.type}?'} ${q.dartName}',
  ];

  final signature = named.isEmpty ? '' : '{${named.join(', ')}}';

  final forwardArgs = [
    for (final p in pathParams) '${_fieldName(p)}: ${_fieldName(p)}',
    if (bodyType != null) 'body: body',
    for (final q in queryParams) '${q.dartName}: ${q.dartName}',
  ].join(', ');
  emittedMethods.add(
    _Emitted(
      group: op.group,
      name: name,
      signature: signature,
      args: forwardArgs,
      returnType: ret.type,
      operationId: op.id,
      httpMethod: op.method.toUpperCase(),
      path: op.path,
      summary: summary,
      description: description,
      bodyType: bodyType?.type,
      params: [
        for (final p in pathParams)
          _DocParam(_fieldName(p), 'String', true, 'path', null),
        if (bodyType != null)
          _DocParam('body', bodyType.type, true, 'body', null),
        for (final q in queryParams)
          _DocParam(q.dartName, q.type, q.required, 'query', q.doc),
      ],
    ),
  );

  for (final q in queryParams) {
    if (q.doc == null) continue;
    buf.writeln('  ///');
    buf.writeln(_doc('[${q.dartName}] ${q.doc}', indent: '  '));
  }
  buf.writeln('  Future<${ret.type}> $name($signature) async {');

  final dartPath = op.path.replaceAllMapped(
    RegExp(r'\{([^}]+)\}'),
    (m) => '\$${_fieldName(m[1]!)}',
  );

  final call = StringBuffer(
    "    ${ret.needsResult ? 'final json = ' : ''}"
    "await _client.${ret.clientMethod}(\n"
    "      '${op.method.toUpperCase()}',\n"
    "      '$dartPath',\n",
  );
  if (queryParams.isNotEmpty) {
    call.writeln('      query: {');
    for (final q in queryParams) {
      call.writeln("        '${q.wireName}': ${q.dartName},");
    }
    call.writeln('      },');
  }
  if (bodyType != null) call.writeln('      body: ${bodyType.encode},');
  call.writeln('    );');
  buf.write(call);

  if (ret.needsResult) buf.writeln('    return ${ret.parse};');
  buf.writeln('  }');
  buf.writeln();
  return buf.toString();
}

/// The Dart type a request body takes, and how to serialise it.
class _Body {
  _Body(this.type, this.encode);
  final String type;
  final String encode;
}

/// Types a request body.
///
/// Responses were typed first, which made reading safe while writing still
/// meant guessing key names against the docs — the direction where being wrong
/// costs more. Named schemas are reused; inline ones get a class named after
/// their operation, exactly as inline responses do.
_Body _bodyType(_Op op, Map<String, dynamic> schema) {
  final refName = _refName(schema);
  final resolved = _resolve(schema);

  // A body that is itself a union — PUT env-var takes {value} or
  // {generateValue}, and nothing else distinguishes them.
  final union = _discriminableUnion(resolved);
  if (union != null) {
    final name = refName ?? '${_className(op.id)}Request';
    if (!emittedModels.containsKey(name)) {
      emittedModels[name] = '';
      extraModels.write(_emitSealedUnion(name, union));
    }
    return _Body(name, 'body.toJson()');
  }

  if (refName != null && resolved['properties'] is Map) {
    if (!emittedModels.containsKey(refName)) {
      extraModels.write(_emitType(refName, resolved));
    }
    return _Body(refName, 'body.toJson()');
  }

  if (resolved['type'] == 'array') {
    final items = (resolved['items'] as Map<String, dynamic>?) ?? const {};
    final itemRef = _refName(items);
    final itemResolved = _resolve(items);
    if (itemRef != null && itemResolved['properties'] is Map) {
      if (!emittedModels.containsKey(itemRef)) {
        extraModels.write(_emitType(itemRef, itemResolved));
      }
      return _Body('List<$itemRef>', 'body.map((e) => e.toJson()).toList()');
    }
    if (itemResolved['properties'] is Map) {
      final name = '${_className(op.id)}RequestItem';
      extraModels.write(_emitType(name, itemResolved));
      return _Body('List<$name>', 'body.map((e) => e.toJson()).toList()');
    }
    final union = _discriminableUnion(itemResolved);
    if (union != null) {
      final name = itemRef ?? '${_className(op.id)}RequestItem';
      if (!emittedModels.containsKey(name)) {
        emittedModels[name] = '';
        extraModels.write(_emitSealedUnion(name, union));
      }
      return _Body('List<$name>', 'body.map((e) => e.toJson()).toList()');
    }
    // Items are a union with no distinguishing field; raw JSON is honest.
    return _Body('List<Map<String, Object?>>', 'body');
  }

  if (resolved['properties'] is Map) {
    final name = '${_className(op.id)}Request';
    extraModels.write(_emitType(name, resolved));
    return _Body(name, 'body.toJson()');
  }

  return _Body('Map<String, Object?>', 'body');
}

class _QueryParam {
  _QueryParam(this.wireName, this.dartName, this.required, this.doc, this.type);
  final String wireName;
  final String dartName;
  final bool required;
  final String? doc;

  /// The Dart type from the parameter's schema. The spec types these properly
  /// -- strings, string lists, integers -- so there is no reason to hand the
  /// caller an untyped Object.
  final String type;
}

/// Maps a query parameter's schema to a Dart type.
String _queryType(Map<String, dynamic> schema) {
  final s = _resolve(schema);
  switch (s['type']) {
    case 'array':
      final items = _resolve((s['items'] as Map<String, dynamic>?) ?? const {});
      return items['type'] == 'integer' ? 'List<int>' : 'List<String>';
    case 'integer':
      return 'int';
    case 'number':
      return 'double';
    case 'boolean':
      return 'bool';
    case 'string':
      return 'String';
    default:
      return 'Object';
  }
}

class _Return {
  const _Return(this.type, this.clientMethod, this.parse, this.needsResult);
  final String type;
  final String clientMethod;
  final String parse;
  final bool needsResult;
}

/// Operations where Render's specification does not describe what the API
/// sends, and the generated code would therefore be unusable.
///
/// The spec is this package's contract, so the vendored copy stays a faithful
/// mirror of Render's and is never edited. Correcting the response here means
/// the fix survives regeneration, which a hand-edit of the output would not.
///
/// `get-bandwidth-sources` declares an object wrapping a `data` array, with
/// labels as an object and timestamps as epoch integers. The live API returns
/// the same array-of-series every other metrics endpoint returns — labels as
/// {field, value} pairs, ISO-8601 timestamps — distinguished by a
/// `trafficSource` label carrying `total` or `http`. Verified against the API
/// on 2026-08-21; decoded against the spec it throws before a caller sees
/// anything.
const _responseOverrides = <String, _Return>{
  'get-bandwidth-sources': _Return(
    'List<GetBandwidthResponse>',
    'sendList',
    'json.whereType<Map<String, Object?>>().map(GetBandwidthResponse.fromJson).toList()',
    true,
  ),
};

_Return _returnType(_Op op) {
  final override = _responseOverrides[op.id];
  if (override != null) return override;

  final inlineName = '${_className(op.id)}Response';
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
    if (itemResolved['properties'] is Map) {
      extraModels.write(_emitType(inlineName, itemResolved));
      return _Return(
        'List<$inlineName>',
        'sendList',
        'json.whereType<Map<String, Object?>>().map($inlineName.fromJson).toList()',
        true,
      );
    }
    return _Return('List<Object?>', 'sendList', 'json', true);
  }

  if (refName != null && resolved['properties'] is Map) {
    return _Return(refName, 'sendObject', '$refName.fromJson(json)', true);
  }
  if (resolved['properties'] is Map) {
    extraModels.write(_emitType(inlineName, resolved));
    return _Return(
      inlineName,
      'sendObject',
      '$inlineName.fromJson(json)',
      true,
    );
  }
  return _Return('Map<String, Object?>', 'sendObject', 'json', true);
}

// ---------------------------------------------------------------------------
// Documentation
// ---------------------------------------------------------------------------

/// Writes doc/api/*.md: one page per resource group, plus an index.
///
/// Generated from the same spec the code is, and from the same spec Render's
/// own reference pages render from — so the three cannot drift apart.
void _emitDocs(Map<String, List<_Op>> groups) {
  Directory('doc/api').createSync(recursive: true);

  final byGroup = <String, List<_Emitted>>{};
  for (final m in emittedMethods) {
    byGroup.putIfAbsent(m.group, () => []).add(m);
  }

  final index = StringBuffer()
    ..writeln('# Render API reference')
    ..writeln()
    ..writeln('Every operation in the Render REST API, named exactly as Render')
    ..writeln('names it. Generated from `tool/render-openapi.json`, the same')
    ..writeln('spec [api-docs.render.com](https://api-docs.render.com) renders')
    ..writeln('from.')
    ..writeln()
    ..writeln('Each operation can be called two ways:')
    ..writeln()
    ..writeln('```dart')
    ..writeln('await render.listHeaders(serviceId: id);            // flat')
    ..writeln(
      'await render.raw.services.listHeaders(serviceId: id); // grouped',
    )
    ..writeln('```')
    ..writeln()
    ..writeln('| Group | Operations | |')
    ..writeln('| --- | --- | --- |');

  for (final group in byGroup.keys.toList()..sort()) {
    final methods = byGroup[group]!..sort((a, b) => a.name.compareTo(b.name));
    index.writeln(
      '| `${_fieldName(group)}` | ${methods.length} | '
      '[reference](${_snake(group)}.md) |',
    );

    final page = StringBuffer()
      ..writeln('# ${_className(group)}')
      ..writeln()
      ..writeln(
        '`render.raw.${_fieldName(group)}` — ${methods.length} '
        'operation${methods.length == 1 ? '' : 's'} on `/$group`.',
      )
      ..writeln()
      ..writeln('| Method | | |')
      ..writeln('| --- | --- | --- |');
    for (final m in methods) {
      final line = m.summary?.split('\n').first ?? '';
      page.writeln(
        '| [`${m.name}`](#${m.name.toLowerCase()}) | '
        '`${m.httpMethod} ${m.path}` | $line |',
      );
    }
    page.writeln();
    page.writeln('---');
    page.writeln();

    for (final m in methods) {
      page.writeln('## ${m.name}');
      page.writeln();
      if (m.summary != null) page.writeln('**${m.summary}**');
      page.writeln();
      if (m.description != null && m.description != m.summary) {
        page.writeln(m.description);
        page.writeln();
      }
      page.writeln('```dart');
      page.writeln('Future<${m.returnType}> ${m.name}(${m.signature})');
      page.writeln('```');
      page.writeln();
      page.writeln('`${m.httpMethod} ${m.path}`');
      page.writeln();

      if (m.params.isEmpty) {
        page.writeln('Takes no parameters.');
        page.writeln();
      } else {
        page.writeln('| Parameter | Type | In | Required | |');
        page.writeln('| --- | --- | --- | --- | --- |');
        for (final p in m.params) {
          final doc = (p.doc ?? '')
              .replaceAll('\n', ' ')
              .replaceAll('|', '\\|');
          page.writeln(
            '| `${p.name}` | `${p.type}` | ${p.location} | '
            '${p.required ? 'yes' : 'no'} | $doc |',
          );
        }
        page.writeln();
      }

      final element = _bareType(m.returnType);
      page.writeln(
        element == m.returnType
            ? 'Returns `${m.returnType}`.'
            : 'Returns `${m.returnType}` — each element carries:',
      );
      final fields = modelFields[element];
      if (fields != null && fields.isNotEmpty) {
        page.writeln();
        page.writeln('| Field | Type | |');
        page.writeln('| --- | --- | --- |');
        for (final f in fields) {
          final doc = (f.doc ?? '')
              .replaceAll('\n', ' ')
              .replaceAll('|', '\\|');
          page.writeln('| `${f.name}` | `${f.type}` | $doc |');
        }
      }
      page.writeln();
      page.writeln(
        '[Render documentation]'
        '(https://api-docs.render.com/reference/${m.operationId})',
      );
      page.writeln();
    }

    File('doc/api/${_snake(group)}.md').writeAsStringSync(page.toString());
  }

  index.writeln();
  index.writeln('Generated by `dart run tool/generate.dart`.');
  File('doc/api/README.md').writeAsStringSync(index.toString());
  stdout.writeln('wrote doc/api for ${byGroup.length} groups');
}

/// `List<Foo>` -> `Foo`, so a list return can still document its element.
String _bareType(String type) => type.startsWith('List<') && type.endsWith('>')
    ? type.substring('List<'.length, type.length - 1)
    : type;

// ---------------------------------------------------------------------------
// Naming
// ---------------------------------------------------------------------------

final _reserved = {
  'is',
  'in',
  'if',
  'for',
  'new',
  'this',
  'class',
  'enum',
  'default',
  'switch',
  'return',
  'void',
  'const',
  'final',
  'var',
  'true',
  'false',
  'null',
  'super',
  'with',
  'extends',
  'implements',
  'static',
  'abstract',
  'operator',
  'part',
  'show',
  'hide',
  'sync',
  'async',
  'await',
  'yield',
  'assert',
  'break',
  'case',
  'catch',
  'continue',
  'do',
  'else',
  'rethrow',
  'throw',
  'try',
  'while',
  'get',
  'set',
  'external',
  'factory',
  'library',
  'typedef',
};

List<String> _words(String raw) => raw
    .replaceAll(RegExp(r'[^A-Za-z0-9]+'), ' ')
    .replaceAllMapped(RegExp(r'([a-z0-9])([A-Z])'), (m) => '${m[1]} ${m[2]}')
    .trim()
    .split(RegExp(r'\s+'))
    .where((w) => w.isNotEmpty)
    .toList();

String _pascal(String raw) => _words(
  raw,
).map((w) => w[0].toUpperCase() + w.substring(1).toLowerCase()).join();

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
  final lines = text.trim().split('\n').map((l) => l.trimRight()).toList();
  return lines.map((l) => '$indent/// ${l.trim()}'.trimRight()).join('\n');
}
