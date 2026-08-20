/// `package:render_api`, minus three names Flutter also defines.
///
/// The Render spec has schemas called `State` (a task run's state), `Route`
/// and `Image`, and the generator takes its names from the spec — that
/// correspondence is the one thing this package promises, so it cannot rename
/// them. Flutter's `State`, `Route` and `Image` are rather more famous, and
/// importing both libraries unprefixed is an `ambiguous_import` error.
///
/// Hiding them once here means no page has to think about it. Anything needing
/// the Render `State` can import the package directly with a prefix:
///
/// ```dart
/// import 'package:render_api/render_api.dart' as render;
/// if (run.state == render.State.success) { … }
/// ```
library;

export 'package:render_api/render_api.dart' hide State, Route, Image;
