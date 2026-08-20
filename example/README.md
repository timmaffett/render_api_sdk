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

**Three names collide with Flutter.** The spec has schemas called `State`,
`Route` and `Image`, and the generator takes its names from the spec — that
correspondence is the package's whole promise, so it cannot rename them.
`lib/src/data/api.dart` re-exports the package with those three hidden, once,
for everything else to import.

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
