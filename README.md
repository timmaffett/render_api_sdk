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

## Why the errors are opinionated

Render's API frequently reports failures without saying what went wrong.
Creating a workflow against a repository its Git app cannot read returns a bare
`500 internal server error`; that one cost an hour of debugging and four
accidental workflow services. So failures here are typed, and carry a `hint`
naming the likely cause where one can be inferred:

```dart
try {
  await render.workflows.create(...);
} on RenderServerException catch (e) {
  print(e.hint);
  // Render returns a bare 500 here when it cannot reach the repository.
  // Check that the Render GitHub/GitLab app has been granted access to it...
}
```

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

Implemented: workflows, workflow versions, tasks, task runs.

Not yet: services, databases, deploys, metrics, env groups. The transport
handles them already — `render.client.send('GET', '/services')` works today;
they simply lack typed wrappers.
