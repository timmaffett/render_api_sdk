## 0.1.4

- **A 400 on a metric now says why.** HTTP request and latency metrics are gated
  by the resource's instance plan: on the free tier Render answers
  `400 {"message":"query is not allowed for plan: Hobby"}`, which reads like a
  malformed request and is not. CPU, memory and bandwidth are returned on every
  plan. Found against a live free service, not inferred from the spec — the
  parameter is optional there and nothing marks the endpoint as paid-only.
- `hintFor` now receives the response body, so a hint can key on what Render
  actually said rather than on the status code alone. Internal; no public API
  change.

## 0.1.3

- The `RenderApi()` example said `// reads RENDER_API_KEY` without saying from
  where. Now `// token from the RENDER_API_KEY env var`, in the README and in
  the library doc comment pub.dev renders on the API page.

## 0.1.2

- Clean up README
- **Corrected what this package is.** Both the description and the README's
  opening said it covered "workflows, tasks and task runs" — the description
  duplicated `render_workflows`, and neither conveyed that this is the *whole*
  REST API: 208 operations across 26 resource groups, of which workflows are
  three. Services, Postgres, cron jobs, disks, env groups, metrics, logs and
  the rest were invisible to anyone reading either.
- The opening now points at `render_workflows` for actually running tasks, so
  the two packages read as complementary rather than overlapping.

## 0.1.1

Documentation and packaging; no API changes.

- **The README's usage example did not compile.** It described an earlier
  hand-written facade — `render.taskRuns.run(...)`, `render.workflows.list()`,
  `waitFor` — none of which exist on the generated API. Rewritten around what
  the package actually exposes, and every snippet now verified by compiling it.
- Adds `example/example.dart`, and formats the package. Those were the two
  things costing pub.dev points; the score is now 160/160.
- `tool/generate.dart` runs `dart format` as its last step, so regenerating
  cannot undo the formatting.
- The README now points at the two companion packages:
  [`render_workflows`](https://pub.dev/packages/render_workflows) for running
  tasks, and [`render-dart`](https://www.npmjs.com/package/render-dart) on npm
  for writing the task bodies in Dart. pub.dev serves the README from the
  published archive, so this needed a release to become visible.

## 0.1.0

Initial release.

- The whole Render REST API: 208 operations and 164 models, generated from
  Render's OpenAPI specification.
- Two spellings of every call — flat (`render.listWorkflows(...)`, matching
  Render's own Node examples) and grouped (`render.raw.workflows.listWorkflows(...)`).
- Method names taken from the spec's `operationId`, so they correspond one for
  one with Render's official `@api/render-api` bindings.
- Typed exceptions carrying hints for Render's less obvious responses — `500`
  rather than `404` for an unknown task run id, and `500` for a workflow whose
  repository cannot be read.
- Unknown enum values decode to `.unknown` rather than throwing, so a new
  region or status cannot break a working client.
- Cursor pagination, retries with backoff, and a configurable timeout.
- Runs on the Dart VM and under dart2js. On the web there is no environment, so
  the API token must be passed explicitly.
