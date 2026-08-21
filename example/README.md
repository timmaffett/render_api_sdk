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

That indicator is the whole screen's *oldest* reading, which says less than it
looks like on a page of several independent requests — the metrics tab makes
seven, and CPU can be live while disk is replayed. So each chart panel carries
its own `read 14:32` / `cached 14:29` **in its header bar**, next to a reload
that refetches that panel alone. Both live in the header because four stacked
charts cannot afford a status line each, and because Render rate limits per
endpoint: refreshing everything can be refused while refreshing one thing
succeeds.

Attribution comes from running each loader in a zone the cache records
against, so nothing threads a cache key through the typed loaders.

Where a whole tab comes from one response — sizes, queries, activity are one
call each — there is one stamp for the tab rather than the same time repeated
on every row.

## One chart, four metrics

The database card overlays every metric on a shared percentage axis, each line
in a colour it keeps on the detail page too — so "green is disk" is learned
once. Most of these are already drawn as a share of their own ceiling, which is
what makes them comparable: 20% of memory and 5% of CPU are the same kind of
statement.

Two things fell out of trying it.

**Connections cannot go on that axis.** Render reports no ceiling for it, and
scaling it against its own peak — the obvious workaround — is worse than
useless: a database holding one or two connections becomes a line swinging
between 50% and 100%, the loudest thing on the chart and the least meaningful,
while CPU at 5% is squashed into the baseline. A percentage needs a real
denominator. It keeps its colour and its own chart, where a count is a count — and it still
appears in the scrub readout, parenthesised and de-scaled to `(4 connections)`,
because being unplottable is not a reason to be unreadable.

**A fixed 0–100% axis wastes its height.** An idle database runs at 5% CPU, 6%
disk and 20% memory, so everything piles into the bottom quarter and disk hides
under CPU. The axis fits the data with a little headroom instead, so it reads
0–32% here. Still a percentage of each metric's real ceiling — zoomed, not
distorted.

## Times

Settings carries two, because a timestamp answers different questions in
different places.

**Clock format** — 12 hour with an `am`/`pm` suffix by default, or 24 hour.
Everything that writes a time obeys it: the panel headers, the cached indicator,
and the readout when you scrub a chart.

**What a metric panel shows** — `age` by default, or `clock time`. Age counts
up from when that panel's data was read and **ticks every second**, which is
the only form that answers "did that just reload"; a clock time cannot, because
`read 5:36am` looks the same one second and ten minutes later. The ticker exists
only in age mode and only while the widget is mounted.

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
