# Render Dashboard

A read-only Flutter app that recreates part of the
[Render](https://render.com) dashboard, and the example for
[`render_api`](https://pub.dev/packages/render_api).

Three command-line scripts prove the package works. They do not show what it
covers — 208 operations across 26 resource groups — so this walks the same
hierarchy the real dashboard does and draws real charts from real metrics.

```bash
flutter run -d macos
```

Paste an API key from **Dashboard → Account Settings → API Keys**. It is stored
in the platform keychain and sent only to `api.render.com`.

## What it shows

| Page | Operations |
| --- | --- |
| Workspace | `listOwners`, `listProjects`, `listEnvironments` |
| Services | `listServices`, `retrieveService` |
| Service detail | `listDeploys`, `listEvents`, `getEnvVarsForService`, `getCpu`, `getMemory`, `getBandwidth`, `getHttpRequests` |
| Databases | `listPostgres`, plus CPU for each |
| Workflows | `listWorkflows`, `listTasks`, `listTaskRuns` |

Every write operation is out of scope. Nothing here creates, edits, deletes or
deploys anything, and environment variable **values are never displayed** —
only their names.

## Three things it exists to demonstrate

**List endpoints return `<Thing>WithCursor`.** Not `<Thing>` — the pagination
cursor rides along. `lib/src/data/render_client.dart` unwraps them in one place
so no page has to.

**Errors are typed, and some carry a hint.** Render's status codes are
sometimes misleading: `500` for an unknown task run id, `400` for a metric a
plan does not include. `RenderApiException.hint` explains those, and
`lib/src/widgets/async_view.dart` shows it verbatim rather than paraphrasing.
`RenderAuthException` is handled separately — it signs the app out.

**Charts are plotted against the plan's ceiling.** `getCpuLimit` and
`getMemoryLimit` are separate operations from `getCpu` and `getMemory`, and
easy to miss — without them a chart scales to its own data, so an idle service
looks like a noisy full-height waveform instead of a flat line near zero. The
axis runs 0 to the limit, the toggle switches the labels between a share of
that ceiling and the raw reading, and hovering scrubs a readout along the line.

**Three names collide with Flutter**, and the fix is a prefix. The spec has
schemas called `State`, `Route` and `Image`; the generator takes its names from
the spec, and that correspondence is the package's whole promise, so it cannot
rename them. Every file here that mixes the two imports it as:

```dart
import 'package:render_api/render_api.dart' as render;
```

and spells the types `render.Service`, `render.Deploy`, `render.State`. It
costs six characters, it never needs revisiting when Render adds a schema, and
in a file full of widgets it says which types came from the API — which is
worth having on its own.

`hide State, Route, Image` also compiles, and is the wrong habit: those three
become unreachable rather than qualified, and the list has to be maintained.
`lib/src/data/render_client.dart` imports the package unprefixed because it
pulls in no Flutter, so nothing collides there — the prefix is for files where
both are in scope.

## No web build

Render's API sends no CORS headers. A preflight to `/v1/owners` returns `200`
with no `Access-Control-Allow-Origin`, so a browser blocks the response. This
is a property of the API, not of Flutter, and there is nothing the app can do
about it — desktop and mobile are unaffected.

## The theme

[`auris`](https://pub.dev/packages/auris), driven by three values — accent,
bevel scale, glow scale — which is why the Settings page can adjust the whole
look live rather than behind a save button.

No state-management package. A `ChangeNotifier` for the theme, another for the
token, `FutureBuilder` for loads. An example for an API client should be about
the API client.

## Cached, and refreshed on demand

Render rate limits hard — the Postgres introspection endpoints allow about one
request a minute and answer `Retry-After: 51`. Reloading a tab twice in a row
would otherwise replace real data with an error, so the app forgets something
it already knew.

`lib/src/data/response_cache.dart` is an `http.Client` decorator that keeps the
last good response for every GET, in memory and in `shared_preferences`, and
replays it when a fresh one cannot be had. It sits at the HTTP layer rather
than around the typed loaders, so every endpoint gets it without knowing and a
replayed body decodes through exactly the same path a live one does.

Nothing reloads on its own. The refresh button in the top right reloads
whatever is on screen; when the refresh cannot get through, the data stays and
the button is labelled `CACHED 14:32` with the time it was actually read.
Cached and stale beats blank and correct.

## Tests

```bash
flutter test
```

Four widget tests render the pages against canned responses through a
`MockClient` — no token, no network. `RenderApi.fromClient` takes any
`http.Client`, which is what makes that possible.

## Platforms

macOS, iOS and Android. The platform directories are committed so `flutter run`
works from a clone, but a `.pubignore` keeps them out of the published archive.

Building for macOS or iOS needs **Xcode 15 or newer** — a Flutter requirement,
not one of this app's.
