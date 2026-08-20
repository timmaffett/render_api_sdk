# render_api

> ## ⚠️ UNOFFICIAL
>
> An independent, community-built project. **Not affiliated with, endorsed by,
> or supported by [Render](https://render.com).**
>
> Render's own SDKs and documentation are at
> [render.com/docs](https://render.com/docs).

[![Render](https://raw.githubusercontent.com/timmaffett/render_api_sdk/main/doc/render-logo.png)](https://render.com)

<sub>The Render name and logo are trademarks of Render Services, Inc.
The mark itself is unmodified, shown on white with the clear space
Render's brand kit specifies, referentially — to identify the service
these packages work with, not to suggest any endorsement.</sub>

A typed Dart client for the [Render](https://render.com) REST API, covering the
workflows surface: workflow services, versions, task definitions and task runs.

Works on Dart and Flutter, including Web. Depends only on `package:http`.

## Usage

```dart
final render = RenderApi();               // reads RENDER_API_KEY

// Flat form — spelled the way Render's own documentation spells it.
for (final entry in await render.listWorkflows(limit: 10)) {
  print('${entry.workflow.name}  ${entry.workflow.id}');
}

// Grouped form — the same call, organised by resource.
final owners = await render.raw.owners.listOwners(limit: 5);

render.close();
```

List endpoints return a `<Thing>WithCursor`, so reach through it —
`entry.workflow`, `entry.postgres`, `entry.service`.

On the web there is no environment, so pass the token explicitly:
`RenderApi(token: ...)`.

A runnable version is in [`example/example.dart`](example/example.dart).

## Typed responses

Every operation that returns JSON returns a typed model. Two things in the
spec would otherwise have left large gaps:

Roughly a third of responses describe their shape inline rather than by
reference. Each of those gets a class named after its operation, so
`getWorkflow` returns a `GetWorkflowResponse`, not a `Map`.

A handful describe a value as `oneOf` several shapes with no discriminator.
Where the variants can be told apart by which fields are present, they become
a sealed class — so a `switch` over them is exhaustive, and adding a variant
is a compile error rather than a silent fallthrough:

```dart
final details = EnvSpecificDetails.fromJson(json);
final summary = switch (details) {
  EnvSpecificDetailsDocker() => 'built from a Dockerfile',
  EnvSpecificDetailsBuild()  => 'built with a native runtime',
};
```

Two unions stay raw JSON, honestly: `events.details` has sixty-eight variants
with no distinguishing field, and `service.serviceDetails` is discriminated by
a sibling `type` the schema cannot see from inside the property.

Another handful compose their response with `allOf` — the env-group endpoints
all do. Since the spec uses it only to combine plain objects, those are merged
into one class: `EnvGroup` carries the fields of both members.

Enums with identical value sets are one type rather than many: every response
carrying a `region` shares `Region`, instead of each getting its own
structurally-identical copy.

## Why the errors are opinionated

Render's API frequently reports failures without saying what went wrong.
Creating a workflow against a repository its Git app cannot read returns a bare
`500 internal server error`; that one cost an hour of debugging and four
accidental workflow services. So failures here are typed, and carry a `hint`
naming the likely cause where one can be inferred:

```dart
try {
  await render.createWorkflow(body: {...});
} on RenderServerException catch (e) {
  print(e.hint);
  // Render returns a bare 500 here when it cannot reach the repository.
  // Check that the Render GitHub/GitLab app has been granted access to it...
}
```

It answers `500` rather than `404` for an unknown task run id, too. Both hints
exist because the bare status cost real debugging time.

The same instinct applies to limits Render enforces remotely: a task input over
4 MB is rejected locally, before the request, so the error names the real
problem.

## Retry policy

`429` is always retried, honouring `Retry-After` — nothing was processed. `5xx`
is retried only for `GET`, `HEAD` and `DELETE`: a `POST` that fails with `5xx`
may still have taken effect, and retrying it could create duplicates.

## Pagination

List endpoints take a `cursor` and a `limit`, and each result carries the
cursor for the next page:

```dart
String? cursor;
do {
  final page = await render.listTaskRuns(limit: 50, cursor: cursor);
  for (final entry in page) {
    print(entry.taskRun.id);
  }
  cursor = page.isEmpty ? null : page.last.cursor;
} while (cursor != null && cursor.isNotEmpty);
```

`package:render_workflows` wraps this for task runs, if that is what you are
paging.

## Running task runs

`createTask` starts one — Render's `operationId` for `POST /task-runs` is
`createTask`, though the operation is "run task":

```dart
final started = await render.createTask(
  body: CreateTaskRequest(task: 'my-workflow/sumSquares', input: [[2, 3, 4]]),
);
final run = await render.getTaskRun(taskRunId: started.id);
```

Poll a run's **own** `status` to know when it is finished — a run has attempts,
and an attempt reaches a terminal state before the run does. Both `completed`
and `succeeded` are terminal.

[`package:render_workflows`](https://pub.dev/packages/render_workflows) has
`waitFor`, which does this properly; prefer it over hand-rolling the loop.

`streamTaskRunsEvents` uses server-sent events, which **will not work on Flutter
Web with the default HTTP client** — `package:http`'s `BrowserClient` buffers
whole responses. Inject a streaming client (`package:fetch_client`) there, or
poll.

## Testing

```bash
dart test                            # 22 tests, offline, no credentials
dart run example/example.dart        # live, needs RENDER_API_KEY
dart run example/raw_smoke.dart      # live, both call forms
dart run example/flat_smoke.dart     # live, mirrors Render's Node examples
```

## Coverage

All 208 operations across 26 resource groups, generated from the vendored
OpenAPI spec, with 164 typed models.

## Two routes to the same API

Every operation is named exactly as Render names it, because both this package
and Render's official Node bindings derive their names from the spec's
`operationId`. An example from the docs translates directly:

```js
// @api/render-api
renderApi.listHeaders({limit: '20', serviceId: 'serviceId'})
```

```dart
// flat — the same spelling
await render.listHeaders(serviceId: 'srv-x', limit: 20);

// grouped — the same call, organised by resource
await render.raw.services.listHeaders(serviceId: 'srv-x', limit: 20);
```

Query parameters are typed from the spec rather than passed as strings, so
`limit` is an `int` and repeated filters are a `List<String>`.

## Running workflow tasks, and writing them in Dart

Starting and watching task runs lives in
[`package:render_workflows`](https://pub.dev/packages/render_workflows), which
depends on this package for its transport. Render splits the same way:
`@renderinc/sdk` runs tasks, `@api/render-api` covers REST.

Workflow *services* — creating them, deploying versions, listing task
definitions — are REST, and generated here.

The task bodies can be Dart as well, with
[**`render-dart`**](https://www.npmjs.com/package/render-dart) (npm). Render's
own SDK covers TypeScript and Python only; `render-dart` compiles Dart task
bodies to JavaScript and registers them through it, and compiles anything
needing `dart:io`, `dart:ffi` or isolates to a native executable.

| | |
| --- | --- |
| [`render-dart`](https://www.npmjs.com/package/render-dart) (npm) | **Writing** tasks in Dart |
| [`render_workflows`](https://pub.dev/packages/render_workflows) | **Running** them |
| `render_api` (this) | Managing the services |

## Per-method reference

[`doc/api/`](doc/api/README.md) documents every operation: signature,
parameters with Render's own descriptions, the fields of what it returns, and
a link to the matching page on api-docs.render.com. Generated alongside the
code, so the two cannot drift.

## Verified against the documentation

Every reference page on api-docs.render.com embeds a scoped OpenAPI fragment
for its endpoint — the same spec vendored here. All 225 documented operations
were diffed against it: parameters, request bodies and response shapes agree
throughout. The docs and this client are two renderings of one source.

## Regenerating

```bash
dart run tool/generate.dart
```

The spec is vendored at `tool/render-openapi.json` with a checksum beside it.
Render notes that the spec is unversioned and names may change, so regenerate
deliberately: `test/parity_test.dart` fails if the generated surface stops
matching the spec's operation set.
