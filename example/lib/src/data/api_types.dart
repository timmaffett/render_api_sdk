/// The one Render type the pages name directly, aliased so the import stays
/// prefixed everywhere else.
///
/// `Postgres` does not collide with anything in Flutter, but importing the
/// package unprefixed alongside `material.dart` is what causes the `State`,
/// `Route` and `Image` ambiguity, so no page does it.
library;

import 'package:render_api/render_api.dart' as render;

typedef PostgresRecord = render.Postgres;
