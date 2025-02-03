import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:challenge_somnio/src/common/helpers/http/http_response.dart';
import 'package:challenge_somnio/src/common/helpers/http/http_response_error.dart';

abstract class HttpHelper {
  void init();

  Future<Either<HttpResponseError, HttpResponse>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  });

  Future<Either<HttpResponseError, HttpResponse>> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });

  Future<Either<HttpResponseError, HttpResponse>> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });

  Future<Either<HttpResponseError, HttpResponse>> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });
}
