import 'dart:async';
import 'dart:developer';

import 'package:demo_project/api/app_exception.dart';
import 'package:demo_project/utility/constants.dart';
import 'package:demo_project/utility/preference_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioClient {
  static const int timeOutDuration = 20;

  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: timeOutDuration),
      receiveTimeout: const Duration(seconds: timeOutDuration),
      sendTimeout: const Duration(seconds: timeOutDuration),
    ),
  );

  //TODO : API CALL GET API
  Future<dynamic> get(String baseUrl) async {
    final uri = Uri.parse(baseUrl);
    try {
      log("API is:$baseUrl");
      log("API Param is: null");
      log("API Token is:${PreferenceUtils.getAuthToken()}");

      final response = await _dio.get(
        baseUrl,
        options: Options(
          headers: {
            "Authorization": PreferenceUtils.getAuthToken(),
            'x-app-type': 'pos',
            "Content-Type": "application/json",
            'accept': '*/*',
          },
        ),
      );
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
        'API not responded in time',
        uri.toString(),
      );
    } on DioException catch (error) {
      throw handleError(error);
    }
  }

  //TODO : API CALL GET QUERY API
  Future<dynamic> getQueryParam(
    String baseUrl, {
    Map<String, dynamic>? queryParams,
  }) async {
    var uri = Uri.parse(baseUrl);

    if (queryParams != null && queryParams.isNotEmpty) {
      uri = Uri.parse(baseUrl).replace(queryParameters: queryParams);
    }

    log("API is:$baseUrl");
    log("API Param is:$queryParams");
    log("API Token is:${PreferenceUtils.getAuthToken()}");

    try {
      final response = await _dio.get(
        uri.toString(),
        options: Options(
          headers: {
            "Authorization": PreferenceUtils.getAuthToken(),
            'x-app-type': 'pos',
            "Content-Type": "application/json",
            'accept': '*/*',
          },
        ),
      );
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
        'API not responded in time',
        uri.toString(),
      );
    } on DioException catch (error) {
      throw handleError(error);
    }
  }

  Future<dynamic> post(String url, [Map<String, dynamic>? requestParam]) async {
    final uri = Uri.parse(url);
    log("API is: $url");
    log("API Param is: ${requestParam ?? {}}");
    log("API Token is: ${PreferenceUtils.getAuthToken()}");

    try {
      final response = await _dio.post(
        url,
        options: Options(
          headers: {
            "Authorization": PreferenceUtils.getAuthToken(),
            'x-app-type': 'pos',
            "Content-Type": "application/json",
            'accept': '*/*',
          },
        ),
        data: requestParam ?? {},
      );
      return response;
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
        'API not responded in time',
        uri.toString(),
      );
    } on DioException catch (error) {
      throw handleError(error);
    }
  }

  Future<dynamic> put(String url, Map<String, dynamic> requestParam) async {
    final uri = Uri.parse(url);
    log("API is:$url");
    log("API Param is:$requestParam");
    log("API Token is:${PreferenceUtils.getAuthToken()}");
    try {
      final response = await _dio.put(
        url,
        options: Options(
          headers: {
            "Authorization": PreferenceUtils.getAuthToken(),
            'x-app-type': 'pos',
            "Content-Type": "application/json",
            'accept': '*/*',
          },
        ),
        data: requestParam,
      );
      return response;
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
        'API not responded in time',
        uri.toString(),
      );
    } on DioException catch (error) {
      throw handleError(error);
    }
  }

  Future<dynamic> delete(
    String url, {
    Map<String, dynamic>? queryParams,
  }) async {
    final uri = Uri.parse(url);
    log("API is:$url");
    log("API Param is:$queryParams");
    log("API Token is:${PreferenceUtils.getAuthToken()}");
    try {
      final response = await _dio.delete(
        url,
        //queryParameters: queryParams, // Pass query parameters
        options: Options(
          headers: {
            "Authorization": PreferenceUtils.getAuthToken(),
            'x-app-type': 'pos',
            "Content-Type": "application/json",
            'accept': '*/*',
          },
        ),
        data: queryParams,
      );
      return response;
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
        'API not responded in time',
        uri.toString(),
      );
    } on DioException catch (error) {
      throw handleError(error);
    }
  }

  dynamic _processResponse(Response response) {
    final uri = response.requestOptions.uri.toString();
    final statusCode = response.statusCode ?? 0;
    final message = response.data['message']?.toString() ?? 'Unexpected error';

    switch (statusCode) {
      case 200:
      case 201:
        return response.data;
      case 400:
        throw BadRequestException(message, uri);
      case 401:
      case 403:
        throw UnAuthorizedException(message, uri);
      case 404:
        throw NotFoundException(message, uri);
      case 500:
        throw FetchDataException("Internal Server Error: $message", uri);
      default:
        throw FetchDataException("Unexpected Error: $message", uri);
    }
  }

  dynamic handleError(DioException error) {
    final uri = error.requestOptions.uri.toString();

    if (error.response != null) {
      final statusCode = error.response!.statusCode;
      final message =
          error.response?.data['message']?.toString() ??
          'Unexpected error occurred';

      if (kDebugMode) {
        print('Error Code: $statusCode');
        print('Error Message: $message');
      }

      switch (statusCode) {
        case 400:
          throw BadRequestException('400 : $message', uri);
        case 401:
          throw UnAuthorizedException('401 : $message', uri);
        case 403:
          throw ForbiddenException('403 : $message', uri);
        case 404:
          throw NotFoundException('404 : $message', uri);
        case 500:
          throw FetchDataException(
            "500 : Internal Server Error: $message",
            uri,
          );
        default:
          throw FetchDataException("Unexpected Error: $message", uri);
      }
    } else {
      // Handle timeout or no response (network error)
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.sendTimeout) {
        //throw TimeOutException(error.message, uri);
        throw TimeOutException(Constants.timeOutMsg, uri);
      } else if (error.type == DioExceptionType.unknown) {
        //throw SocketException(error.message, uri);
        throw SocketException(Constants.socketMsg, uri);
      } else {
        //throw FetchDataException(error.message, uri);
        throw FetchDataException('"Unexpected Error', uri);
      }
    }
  }
}
