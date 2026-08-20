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
