/// Errors raised by the Render API client.
///
/// Render's API is not always forthcoming — creating a workflow against a
/// repository it cannot read returns a bare `500 internal server error` with
/// no indication of the cause. These types exist to turn that into something
/// a caller can act on, so the [hint] carries the likely cause where one can
/// be inferred from the request.
library;

import 'package:meta/meta.dart';

/// Base class for every error this package throws.
sealed class RenderException implements Exception {
  const RenderException(this.message, {this.hint});

  /// What went wrong, in plain terms.
  final String message;

  /// A likely cause and next step, when one can be inferred. Render's own
  /// error responses frequently carry no usable detail.
  final String? hint;

  @override
  String toString() => hint == null
      ? 'RenderException: $message'
      : 'RenderException: $message\n  $hint';
}

/// The request never reached Render, or the response could not be read.
final class RenderNetworkException extends RenderException {
  const RenderNetworkException(super.message, {super.hint, this.cause});

  final Object? cause;

  @override
  String toString() =>
      'RenderNetworkException: $message'
      '${hint == null ? '' : '\n  $hint'}';
}

/// A 2xx response that did not decode into the type the specification
/// declares.
///
/// Always a divergence between Render's API and Render's specification, never
/// a caller's mistake — `/metrics/bandwidth-sources` declared an object and
/// sent an array, and every field of its declared model was wrong too.
///
/// [payload] is what actually arrived, decoded but untyped. Without it a spec
/// bug costs the caller everything; with it they lose the typed view and keep
/// the data.
final class RenderDecodeException extends RenderException {
  const RenderDecodeException(
    super.message, {
    required this.method,
    required this.path,
    required this.payload,
    this.cause,
    super.hint,
  });

  final String method;
  final String path;

  /// The decoded response, exactly as it arrived.
  final Object? payload;

  final Object? cause;

  @override
  String toString() =>
      'RenderDecodeException: $message\n'
      '  $method $path'
      '${hint == null ? '' : '\n  $hint'}';
}

/// Render returned a response outside the 2xx range.
sealed class RenderApiException extends RenderException {
  const RenderApiException(
    super.message, {
    required this.statusCode,
    required this.method,
    required this.path,
    this.body,
    super.hint,
  });

  /// The HTTP status code Render returned.
  final int statusCode;

  /// The HTTP method of the failing request.
  final String method;

  /// The API path of the failing request, without the base URL.
  final String path;

  /// The raw response body, when there was one. Often empty or unhelpful.
  final String? body;

  @override
  String toString() {
    final buffer = StringBuffer()
      ..write('$runtimeType: $statusCode on $method $path')
      ..write('\n  $message');
    if (hint != null) buffer.write('\n  $hint');
    if (body != null && body!.isNotEmpty) buffer.write('\n  Response: $body');
    return buffer.toString();
  }
}

/// A 4xx response: the request was rejected. Retrying it unchanged will fail
/// the same way.
final class RenderClientException extends RenderApiException {
  const RenderClientException(
    super.message, {
    required super.statusCode,
    required super.method,
    required super.path,
    super.body,
    super.hint,
  });
}

/// A 401 or 403: the API key is missing, invalid, or lacks access.
final class RenderAuthException extends RenderApiException {
  const RenderAuthException(
    super.message, {
    required super.statusCode,
    required super.method,
    required super.path,
    super.body,
    super.hint,
  });
}

/// A 404: the resource does not exist, or the key cannot see it.
final class RenderNotFoundException extends RenderApiException {
  const RenderNotFoundException(
    super.message, {
    required super.method,
    required super.path,
    super.body,
    super.hint,
  }) : super(statusCode: 404);
}

/// A 402: the workspace needs billing information before this action is
/// allowed. Workflows require a payment method even when usage is free.
final class RenderPaymentRequiredException extends RenderApiException {
  const RenderPaymentRequiredException(
    super.message, {
    required super.method,
    required super.path,
    super.body,
    super.hint,
  }) : super(statusCode: 402);
}

/// A 429. [retryAfter] is populated from the `Retry-After` header when Render
/// sends one.
final class RenderRateLimitException extends RenderApiException {
  const RenderRateLimitException(
    super.message, {
    required super.method,
    required super.path,
    this.retryAfter,
    super.body,
    super.hint,
  }) : super(statusCode: 429);

  final Duration? retryAfter;
}

/// A 5xx response. Frequently transient, and worth retrying — but see [hint]:
/// Render also returns 500 for at least one condition that is not transient
/// at all.
final class RenderServerException extends RenderApiException {
  const RenderServerException(
    super.message, {
    required super.statusCode,
    required super.method,
    required super.path,
    super.body,
    super.hint,
  });
}

/// Builds the most specific exception available for a failed response, and
/// attaches a hint when the combination of status and request suggests a
/// cause that Render itself does not report.
@internal
RenderApiException exceptionFor({
  required int statusCode,
  required String method,
  required String path,
  String? body,
  Duration? retryAfter,
}) {
  final hint = hintFor(
    statusCode: statusCode,
    method: method,
    path: path,
    body: body,
  );
  final detail = (body == null || body.isEmpty)
      ? 'Render returned no detail.'
      : body;

  return switch (statusCode) {
    401 || 403 => RenderAuthException(
      'Authentication failed. $detail',
      statusCode: statusCode,
      method: method,
      path: path,
      body: body,
      hint: hint,
    ),
    402 => RenderPaymentRequiredException(
      'Payment information is required. $detail',
      method: method,
      path: path,
      body: body,
      hint: hint,
    ),
    404 => RenderNotFoundException(
      'Not found. $detail',
      method: method,
      path: path,
      body: body,
      hint: hint,
    ),
    429 => RenderRateLimitException(
      'Rate limited. $detail',
      method: method,
      path: path,
      retryAfter: retryAfter,
      body: body,
      hint: hint,
    ),
    >= 500 => RenderServerException(
      'Render returned a server error. $detail',
      statusCode: statusCode,
      method: method,
      path: path,
      body: body,
      hint: hint,
    ),
    _ => RenderClientException(
      'Request rejected. $detail',
      statusCode: statusCode,
      method: method,
      path: path,
      body: body,
      hint: hint,
    ),
  };
}

/// Known cases where Render's status code hides the real cause.
///
/// These are not guesses for their own sake — each one cost real debugging
/// time against the live API.
@internal
String? hintFor({
  required int statusCode,
  required String method,
  required String path,
  String? body,
}) {
  final creatingWorkflow = method == 'POST' && path.startsWith('/workflows');

  if (statusCode == 402) {
    return 'Workflows require a payment method on the workspace, even though '
        'test usage costs a fraction of a cent. Add one at '
        'https://dashboard.render.com/billing';
  }

  if (statusCode >= 500 && path.startsWith('/task-runs/')) {
    return 'Render answers 500 rather than 404 for a task run id that does '
        'not exist or is malformed. Check the id before assuming the service '
        'is unhealthy — ids look like trn-xxxxxxxxxxxxxxxxxxxx.';
  }

  if (statusCode >= 500 && creatingWorkflow) {
    return 'Render returns a bare 500 here when it cannot reach the repository. '
        'Check that the Render GitHub/GitLab app has been granted access to it, '
        'and note the grant can take a minute to propagate. The request itself '
        'is probably fine.';
  }

  if (statusCode == 404 && path.startsWith('/workflows')) {
    return 'Workflows are workspace-scoped. Confirm the API key belongs to the '
        'workspace that owns this resource.';
  }

  if (statusCode == 400 &&
      body != null &&
      body.contains('not allowed for plan')) {
    return 'This metric is gated by the resource\'s instance plan — Render '
        'names the plan in the message, and calls the free tier "Hobby". HTTP '
        'request and latency metrics are the ones that bite; CPU, memory and '
        'bandwidth are returned on every plan.';
  }

  if (statusCode == 429) {
    return path.contains('/query/')
        ? 'Postgres introspection endpoints — processes, sizes, table-scans '
              'and top-queries — are rate limited far more tightly than the '
              'metrics endpoints, and a handful of calls in a row is enough to '
              'trip it. Fetch them on demand rather than eagerly, and honour '
              'retryAfter.'
        : 'Slow down and retry after retryAfter, which this exception carries '
              'when Render sends it.';
  }

  if (statusCode == 401 || statusCode == 403) {
    return 'Check that RENDER_API_KEY is set and still valid.';
  }

  return null;
}
