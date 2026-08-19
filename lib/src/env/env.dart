/// Environment access, absent on the web.
library;

export 'env_web.dart' if (dart.library.io) 'env_io.dart';
