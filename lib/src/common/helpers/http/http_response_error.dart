class HttpResponseError implements Exception {
  HttpResponseError({
    required this.errorType,
    required this.message,
    this.stackTrace,
    int? statusCode,
    this.extraErrorMessage,
  }) : statusCode = statusCode ?? 999;

  final int statusCode;
  final String? errorType, message;
  final dynamic extraErrorMessage;
  final StackTrace? stackTrace;
}
