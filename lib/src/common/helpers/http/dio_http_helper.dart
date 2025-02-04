import 'dart:io';

import 'package:challenge_somnio/src/common/helpers/http/http_helper.dart';
import 'package:challenge_somnio/src/common/helpers/http/http_response.dart';
import 'package:challenge_somnio/src/common/helpers/http/http_response_error.dart';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

class DioHttpHelper implements HttpHelper {
  DioHttpHelper({
    required this.baseUrl,
  }) {
    init();
  }

  late Dio _dio;
  final String baseUrl;

  @override
  void init() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 50000,
      receiveTimeout: 50000,
      sendTimeout: 50000,
    ));
  }

  @override
  Future<Either<HttpResponseError, HttpResponse>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final dioResponse = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );

      return Right(HttpResponse(data: dioResponse.data, statusCode: dioResponse.statusCode));
    } on DioError catch (error) {
      return await _onDioError(
        error: error,
        onRetry: (accessToken) =>
            get(path, queryParameters: queryParameters, options: Options(headers: _headerForRefreshToken(accessToken))),
      );
    }
  }

  @override
  Future<Either<HttpResponseError, HttpResponse>> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final dioResponse = await _dio.post(path, data: data, queryParameters: queryParameters, options: options);
      return Right(HttpResponse(data: dioResponse.data, statusCode: dioResponse.statusCode));
    } on DioError catch (error) {
      return _onDioError(
        error: error,
        onRetry: (accessToken) => post(
          path,
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: _headerForRefreshToken(accessToken)),
        ),
      );
    }
  }

  @override
  Future<Either<HttpResponseError, HttpResponse>> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final dioResponse = await _dio.put(path, data: data, queryParameters: queryParameters, options: options);

      return Right(HttpResponse(statusCode: dioResponse.statusCode, data: dioResponse.data));
    } on DioError catch (error) {
      return _onDioError(
        error: error,
        onRetry: (accessToken) => put(path,
            data: data,
            queryParameters: queryParameters,
            options: Options(headers: _headerForRefreshToken(accessToken))),
      );
    }
  }

  Future<Either<HttpResponseError, HttpResponse>> _onDioError({
    required DioError error,
    required Future<Either<HttpResponseError, HttpResponse>> Function(String accessToken) onRetry,
  }) async {
    final httpResponseError = _onResponseError(error);

    if (kDebugMode) {
      print('status code error ====> ${httpResponseError.statusCode}');
    }
    return Left(httpResponseError);
  }

  Map<String, String> _headerForRefreshToken(String accessToken) {
    Map<String, String> headers = {};
    headers["content-type"] = "application/json";
    headers["authorization"] = "Bearer $accessToken";
    return headers;
  }

  HttpResponseError _onResponseError(DioError error) {
    final data = error.response?.data as Map<String, dynamic>?;

    final errorType = error.type;

    if (kDebugMode) {
      print('error data by Dio ==> $data');
    }

    // aqui lo que voy a hacer es crear una variable "message" y filtrar el mensaje dependiendo como venga el
    // mapa de datos, hay que contemplar todos los casos de como vienen en estructura asi extraemos el mensaje correctamente

    if (data != null) {
      return HttpResponseError(
        message: data.containsKey('message') ? data['message'].toString() : data.toString(),
        stackTrace: error.stackTrace,
        statusCode: error.response?.statusCode,
        errorType: data.containsKey('errorType') ? data['errorType'].toString() : null,
        extraErrorMessage: data.containsKey('errors') ? data['errors'] : null,
      );
    } else {
      if (error.error is SocketException) {
        return HttpResponseError(
          statusCode: 600,
          errorType: 'SocketException',
          message: 'Es necesario conexión a internet para realizar este proceso',
        );
      } else if (errorType == DioErrorType.receiveTimeout) {
        return HttpResponseError(
          statusCode: 504,
          errorType: 'Timeout',
          message: 'Estamos experimentando fallas en el servidor intente mas tarde',
        );
      } else {
        return HttpResponseError(errorType: '', message: 'Error Desconocido');
      }
    }
  }
}
