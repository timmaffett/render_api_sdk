# render_api

A typed Dart client for the [Render](https://render.com) REST API, covering the
workflows surface: workflow services, versions, task definitions and task runs.

Works on Dart and Flutter, including Web. Depends only on `package:http`.

## Usage

```dart
final render = RenderApi();               // reads RENDER_API_KEY

final run = await render.taskRuns.run(
  'my-workflow/sumSquares',
  [[2, 3, 4]],
);
print(run.result);                        // 29

render.close();
```

On the web there is no environment, so pass the token explicitly:
`RenderApi(token: ...)`.

## Typed responses

Roughly a third of the spec's responses describe their shape inline rather
than by reference. Those would otherwise come back as untyped maps, so each
gets a class named after its operation — `getWorkflow` returns a
`GetWorkflowResponse`, not a `Map`.

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

List endpoints return a `Stream`, and walk cursors for you:

```dart
await for (final w in render.workflows.list()) { ... }

final recent = await render.taskRuns.list(max: 50).toList();
```

Use the `*Page` variants if you want to hold cursors yourself.

## Watching runs

`waitFor` and `run` poll, and work on every platform including Flutter Web.

`events` streams server-sent events instead, but **will not work on Flutter Web
with the default HTTP client** — `package:http`'s `BrowserClient` buffers whole
responses. Inject a streaming client (`package:fetch_client`) there, or poll.

## Testing

```bash
dart test                          # offline, no credentials needed
dart run example/smoke.dart        # live, needs RENDER_API_KEY
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

## Running workflow tasks

Starting and watching task runs lives in
[`package:render_workflows`](https://github.com/timmaffett/render_workflows_sdk),
which depends on this package for its transport. Render splits the same way:
`@renderinc/sdk` runs tasks, `@api/render-api` covers REST.

Workflow *services* — creating them, deploying versions, listing task
definitions — are REST, and generated here.

## Regenerating

```bash
dart run tool/generate.dart
```

The spec is vendored at `tool/render-openapi.json` with a checksum beside it.
Render notes that the spec is unversioned and names may change, so regenerate
deliberately: `test/parity_test.dart` fails if the generated surface stops
matching the spec's operation set.
