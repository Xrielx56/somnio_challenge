class HttpResponse<T> {
  HttpResponse({this.data, int? statusCode}) : statusCode = statusCode ?? 999;

  final T? data;
  final int statusCode;
}
