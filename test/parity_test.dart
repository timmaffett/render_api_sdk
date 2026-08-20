import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';

/// Guards the property that makes this package predictable: every REST
/// operation is named exactly as Render names it, so an example copied from
/// api-docs.render.com translates directly.
///
/// Render's official Node bindings are generated from the same spec and derive
/// their method names from `operationId` the same way, which is why matching
/// the spec is equivalent to matching them.
void main() {
  final spec =
      jsonDecode(File('tool/render-openapi.json').readAsStringSync())
          as Map<String, dynamic>;

  const httpMethods = {'get', 'post', 'put', 'patch', 'delete'};

  /// `list-headers` -> `listHeaders`, the same transformation the official
  /// bindings apply.
  String methodName(String operationId) {
    final parts = operationId
        .split(RegExp(r'[^A-Za-z0-9]+'))
        .where((p) => p.isNotEmpty)
        .toList();
    return [
      parts.first[0].toLowerCase() + parts.first.substring(1),
      for (final p in parts.skip(1)) p[0].toUpperCase() + p.substring(1),
    ].join();
  }

  final operationIds = <String>[];
  for (final item in (spec['paths'] as Map<String, dynamic>).values) {
    for (final entry in (item as Map<String, dynamic>).entries) {
      if (!httpMethods.contains(entry.key)) continue;
      operationIds.add(
        (entry.value as Map<String, dynamic>)['operationId'] as String,
      );
    }
  }

  final expected = operationIds.map(methodName).toSet();

  /// Names of the `Future`-returning methods declared in [path].
  ///
  /// Reads the whole file rather than line by line, because `dart format` puts
  /// a long return type on its own line:
  ///
  ///     Future<RetrieveOwnerNotificationSettingsResponse>
  ///     retrieveOwnerNotificationSettings({required String ownerId}) => ...
  ///
  /// A line-oriented match silently misses those, which reads as "the generator
  /// dropped five operations" rather than "the formatter moved a line".
  Set<String> declaredIn(String path) {
    final pattern = RegExp(
      r'Future<.*?>\s+([a-zA-Z_][A-Za-z0-9_]*)\(',
      dotAll: true,
    );
    return pattern
        .allMatches(File(path).readAsStringSync())
        .map((m) => m.group(1)!)
        .toSet();
  }

  test('the spec has an operationId for every operation', () {
    expect(operationIds, hasLength(208));
    expect(
      operationIds.toSet(),
      hasLength(208),
      reason: 'duplicate operationIds would collide in the flat facade',
    );
  });

  test('the flat facade exposes every operation, named as Render names it', () {
    final actual = declaredIn('lib/src/generated/flat.dart');

    expect(
      actual.difference(expected),
      isEmpty,
      reason: 'methods that do not correspond to any operationId',
    );
    expect(
      expected.difference(actual),
      isEmpty,
      reason: 'operations missing from the flat facade',
    );
  });

  test('the grouped endpoints expose the same set of operations', () {
    final actual = <String>{};
    for (final file in Directory('lib/src/generated/api').listSync()) {
      if (!file.path.endsWith('.dart')) continue;
      actual.addAll(declaredIn(file.path));
    }

    expect(
      actual,
      equals(expected),
      reason: 'flat and grouped forms must be two routes to one API',
    );
  });

  test('the vendored spec is the one the code was generated from', () {
    // Not a checksum test — just a guard that the file is present and whole,
    // since every generated name traces back to it.
    expect(spec['openapi'], startsWith('3.'));
    expect((spec['servers'] as List).first['url'], 'https://api.render.com/v1');
    expect((spec['components']['schemas'] as Map), hasLength(164));
  });
}
