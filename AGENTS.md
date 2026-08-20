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
`.workflow`, `.postgres` and so on.

## Before writing a query

`render_probes/` already has runnable programs for the common questions —
listing Postgres instances, workflows, versions, tasks, task runs. Extend one
rather than writing a throwaway, and never reach for `curl`: a shell one-liner
gets the response shape subtly wrong and does not survive the session.
