# Command-line examples

Three short programs, each a real call against a live account. They were
`example/` until that became the Flutter dashboard app; nothing about them
changed in the move.

```bash
export RENDER_API_KEY=rnd_...     # Dashboard -> Account Settings -> API Keys
dart run dart_examples/raw_smoke.dart
```

| | |
| --- | --- |
| `example.dart` | The shortest thing that works: construct a client, list owners, print them. This is the file pub.dev's example tab used to show |
| `raw_smoke.dart` | Owners, services and projects, called **both** ways — `render.listServices()` and `render.raw.services.listServices()` are the same operation by two routes |
| `flat_smoke.dart` | The flat form only, laid out to mirror Render's own Node examples so the two can be read side by side |

Each exits with a sentence if `RENDER_API_KEY` is unset, rather than letting a
401 surface from inside the HTTP client.

For something larger, `example/` is a Flutter app that recreates part of the
Render dashboard — the workspace hierarchy, services, databases, workflows and
metrics charts.
