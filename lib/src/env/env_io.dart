import 'dart:io' show Platform;

/// Reads an environment variable. Native implementation.
String? readEnv(String name) => Platform.environment[name];
