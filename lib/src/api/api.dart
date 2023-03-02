import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sprout_mobile/src/api/api_constant.dart';
import 'package:sprout_mobile/src/environment.dart';
import 'package:sprout_mobile/src/utils/constants.dart';

import '../utils/global_function.dart';

class Api {
  Dio dio;

  String token = "";
  //String _sessionTimeOut = "";

  Api(this.dio) {
    dio = Dio(baseOptions);
  }

  final BaseOptions baseOptions = BaseOptions(
      connectTimeout: 60 * 1000,
      receiveTimeout: 60 * 1000,
      baseUrl: Environment.apiUrl,
      headers: {});

  void setUpInterceptors() {
    dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options,
        RequestInterceptorHandler requestInterceptorHandler) {
      "======================================================================>";
      debugPrint("REQUEST HEADERS ==============>  ${options.headers}");
      debugPrint("REQUEST URI ==============>  ${options.uri}");
      debugPrint("REQUEST DATA ==============>  ${options.data}");
      "======================================================================>";
      return requestInterceptorHandler.next(options); //continue
    }, onResponse:
        (Response<dynamic> response, ResponseInterceptorHandler handler) {
      "======================================================================>";
      debugPrint("RESPONSE DATA ==============>  ${response.data}");
      debugPrint("RESPONSE HEADERS ==============>  ${response.headers}");
      debugPrint("RESPONSE STATUSCODE ==============>  ${response.statusCode}");
      debugPrint(
          "RESPONSE STATUSMESSAGE ==============>  ${response.statusMessage}");
      "======================================================================>";
      return handler.next(response); // continue
    }, onError: (DioError e, handler) {
      debugPrint("RESPONSE ERRORTYPE ==============>  ${e.type}");
      debugPrint("RESPONSE ERROR ==============>  ${e.message}");
      return handler.next(e); //continue
    }));
  }

  Response? handleError(DioError e) {
    debugPrint("${e.error} dddddddddddddddddddddd");
    debugPrint("${e.response} messagggggggeee");
    debugPrint("${e.message} dddddddddddddddddddddd");

    Response? response;
    switch (e.type) {
      case DioErrorType.cancel:
        response = Response(
            data: apiResponse("Request cancelled"),
            statusCode: 000,
            requestOptions: RequestOptions(path: ''));
        break;
      case DioErrorType.connectTimeout:
        response = Response(
            data: apiResponse("Network connection timed out"),
            statusCode: 000,
            requestOptions: RequestOptions(path: ''));
        break;
      case DioErrorType.receiveTimeout:
        response = Response(
            data: apiResponse("Network connection timed out"),
            statusCode: 000,
            requestOptions: RequestOptions(path: ''));
        break;
      case DioErrorType.sendTimeout:
        response = Response(
            data: apiResponse("Network connection timed out"),
            statusCode: 000,
            requestOptions: RequestOptions(path: ''));
        break;
      case DioErrorType.other:
        if (e.error is SocketException) {
          response = Response(
              data: apiResponse("Please check your network connection"),
              statusCode: 000,
              requestOptions: RequestOptions(path: ''));
        } else if (e.error is HttpException) {
          response = Response(
              data: apiResponse("Network connection issue"),
              statusCode: 000,
              requestOptions: RequestOptions(path: ''));
        }
        break;
      default:
        if (e.response?.data.runtimeType == String ||
            e.error.toString().contains("404")) {
          response = Response(
              data: apiResponse("An error occurred, please try again"),
              statusCode: 000,
              requestOptions: RequestOptions(path: ''));
        } else if (e.response?.data.runtimeType == String ||
            e.error.toString().contains("400")) {
          response = Response(
              data: apiResponse(e.response?.data?["message"],
                  e.response?.data?["responseCode"]),
              statusCode: e.response?.statusCode ?? 000,
              requestOptions: RequestOptions(path: ''));
        } else if (e.response?.data.runtimeType == String ||
            e.error.toString().contains("401")) {
          // logout(code: 401);
        } else if (e.response?.data.runtimeType == String ||
            e.error.toString().contains("422")) {
          response = Response(
              data: apiResponse(e.response?.data?["errors"]["account"][0],
                  e.response?.data?["responseCode"]),
              statusCode: e.response?.statusCode ?? 000,
              requestOptions: RequestOptions(path: ''));
        } else {
          debugPrint("came in here");
          response = Response(
              data: apiResponse(e.response?.data?["message"],
                  e.response?.data?["responseCode"]),
              statusCode: e.response?.statusCode ?? 000,
              requestOptions: RequestOptions(path: ''));
        }
    }
    return response;
  }

  logout({code}) async {
    bool canLogin = await preferenceRepository.getBooleanPref(IS_LOGGED_IN);
    if (code == 401 && canLogin) {}
  }

  void setExtraHeader(Map<String, dynamic> newHeaders) {
    debugPrint("$newHeaders");
    Map<String, dynamic> existingHeaders = dio.options.headers;
    newHeaders.forEach((key, value) =>
        existingHeaders.update(key, (_) => value, ifAbsent: () => value));
    dio.options.headers = existingHeaders;
  }
}
