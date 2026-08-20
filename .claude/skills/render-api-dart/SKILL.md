---
name: render-api-dart
description: Uses package:render_api, a Dart client for Render's REST API, to query and manage services, Postgres databases, workflows, deploys, environment variables and owners. Covers the flat and grouped call forms, authentication, pagination, typed errors, and the API's surprising behaviours. Use when Dart code needs to talk to Render's REST API, inspect a Render account, or provision Render resources programmatically.
license: MIT
compatibility: Dart 3.9+. Reads RENDER_API_KEY from the environment. Covers 208 operations generated from Render's OpenAPI spec.
metadata:
  author: Tim Maffett
  version: "1.0.0"
  category: api
---

# Render's REST API from Dart

`package:render_api` covers Render's whole REST surface — 208 operations and 164
models generated from the OpenAPI spec. Method names come from the spec's
`operationId`, so they match Render's official `@api/render-api` bindings one
for one, and Render's own documentation carries over.

## Calling it

```dart
import 'package:render_api/render_api.dart';

final render = RenderApi();                  // reads RENDER_API_KEY
try {
  final workflows = await render.listWorkflows(limit: 20);
  for (final entry in workflows) {
    print('${entry.workflow.name}  ${entry.workflow.id}');
  }
} finally {
  render.close();                            // always
}
```

Two spellings of every call, the same underneath:

```dart
await render.listWorkflows(limit: 20);                  // flat, like the docs
await render.raw.workflows.listWorkflows(limit: 20);    // grouped
```

## Authentication

`RENDER_API_KEY` from the environment, or pass `token:` explicitly (required on
the web, which has no environment).

The key commonly lives in `~/.zshrc`, which **non-interactive shells do not
source**. A script sees nothing unless it loads it:

```bash
eval "$(grep -h '^ *export RENDER_API_KEY' ~/.zshrc)"
```

Check for the key and fail with a sentence rather than letting a 401 surface
from inside the HTTP client.

## Behaviours that surprise people

**`500` is not always a server fault.** Render answers `500`, not `404`, for an
unknown task run id, and `500` for a workflow whose repository its Git app
cannot read. The exceptions attach hints for both — read
`RenderApiException.hint` before assuming an outage.

**A workflow's environment can only be set when it is created.**
`POST /workflows` accepts `envVars`; `PATCH /workflows/{id}` takes only `name`,
`buildConfig`, `runCommand` and `autoDeployTrigger`. Afterwards the Dashboard is
the only route — so pass env vars at creation time.

**List endpoints return `<Thing>WithCursor`**, not the thing. Reach through
`.workflow`, `.postgres`, `.service`.

**Unknown enum values decode to `.unknown`** rather than throwing, because
Render ships new regions and statuses without warning.

## Secrets

`retrievePostgresConnectionInfo` returns a password, in **two** shapes — inside
a `postgresql://user:pass@host/db` URI and inside a ready-made
`PGPASSWORD=... psql ...` command. Redact both before printing; handling only
the URI leaks the password while looking safe.

## Do not

- Hand-edit `lib/src/generated/` — change the spec or `tool/generate.dart` and
  run `dart run tool/generate.dart`
- Rename methods to read better; the correspondence with `operationId` and with
  Render's Node bindings is the point
- Write a `curl` one-liner to query Render. `render_probes/` holds runnable Dart
  programs for the common questions — extend one
