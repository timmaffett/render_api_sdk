# Working on render_api

A Dart client for Render's REST API — 208 operations and 164 models generated
from a vendored OpenAPI spec.

This file is for coding agents. `README.md` explains the package to a user.

## The spec is the contract

`tool/render-openapi.json` is the single source of truth. Generated code,
`doc/api/`, and `test/parity_test.dart` all derive from it.

**Never hand-edit anything under `lib/src/generated/`.** Change the generator
(`tool/generate.dart`) or the spec, then:

```bash
dart run tool/generate.dart
dart test          # 22 tests, offline
```

Method names come from the spec's `operationId`, which is why they match
Render's official `@api/render-api` bindings one for one. Renaming one to read
better breaks that correspondence — do not.

## Using it

```dart
final render = RenderApi();      // token from the RENDER_API_KEY env var
final workflows = await render.listWorkflows(limit: 20);
render.close();                           // always
```

Two spellings of every call: flat (`render.listWorkflows(...)`, mirroring
Render's Node examples) and grouped (`render.raw.workflows.listWorkflows(...)`).
They are the same call; prefer flat unless the grouping aids readability.

`RENDER_API_KEY` is read from the environment. Note it commonly lives in
`~/.zshrc`, which **non-interactive shells do not source** — a script sees
nothing unless it loads it:

```bash
eval "$(grep -h '^ *export RENDER_API_KEY' ~/.zshrc)"
```

## Traps

**Render answers `500`, not `404`,** for an unknown task run id, and `500` for a
workflow whose repository its Git app cannot read. The exceptions attach hints
for both — keep them when touching `lib/src/exceptions.dart`.

**A workflow's environment can only be set at creation.** `POST /workflows`
accepts `envVars`; `PATCH /workflows/{id}` takes only `name`, `buildConfig`,
`runCommand`, `autoDeployTrigger`. There is no API route afterwards.

**Unknown enum values decode to `.unknown` rather than throwing.** Render ships
new regions and statuses without warning, and Workflows is beta. Do not
"tighten" this into a throw.

**List endpoints return `<Thing>WithCursor`,** not the thing. Reach through
`.workflow`, `.postgres` and so on. Some of those inner types are named
`<Wrapper><Field>` — `WorkflowWithCursorWorkflow`, `TaskRunWithCursorTaskRun`,
`ServiceEventWithCursorEvent` — because Render declares them inline in the list
response instead of as named schemas. Ugly, and faithful. Do not rename them.

**Metrics are gated by plan, and only one of them says so.** On a free instance
`getHttpLatency` answers `400 {"message":"query is not allowed for plan:
Hobby"}` — there is a hint for it — while `getHttpRequests` answers `200` with
zero series, so an empty chart means "not on this plan" rather than "no
traffic". `getCpu`, `getMemory` and `getBandwidth` work everywhere. Nothing in
the spec marks any of this. `render_probes/bin/service_metrics.dart` asks.

**Three schema names collide with Flutter:** `State`, `Route` and `Image`.
*Naming* one while `package:flutter/material.dart` is also in scope is an
`ambiguous_import` error — the import itself is fine until then.

The fix is on the consumer's side, not a rename here, which would break the
spec correspondence above. **Prefer a prefixed import:**

```dart
import 'package:render_api/render_api.dart' as render;

final List<render.Service> services = …;
if (run.state == render.State.success) { … }
```

It costs six characters, it never has to be revisited when Render adds a
schema, and in mixed Flutter code it says which types came from the API. That
is what `example/` does throughout.

`hide State, Route, Image` also compiles, but it is worse in two ways: those
three names become unreachable rather than qualified, and the list is a
maintenance liability — a new colliding schema breaks the build somewhere else
entirely. Reach for `hide` only in a narrow file where you know you want
Flutter's meaning of every shared name.

**Verify a doc snippet by compiling it.** The README shipped a non-compiling
example in 0.1.0 and the library doc comment shipped a different one through
0.1.3, both referring to a facade removed before release. Reading them found
neither.

## Before writing a query

`render_probes/` already has runnable programs for the common questions —
listing Postgres instances, workflows, versions, tasks, task runs. Extend one
rather than writing a throwaway, and never reach for `curl`: a shell one-liner
gets the response shape subtly wrong and does not survive the session.
