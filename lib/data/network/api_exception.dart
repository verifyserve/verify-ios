import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ApiException implements Exception {
  ApiException.fromDioError(DioError dioError) {
    debugPrint(
        "Error calling url: ${dioError.requestOptions.path} - ${dioError.error.toString()}");
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioErrorType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioErrorType.unknown:
        message = "Connection to API server failed due to internet connection";
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioErrorType.badResponse:
        message = _handleError(
            dioError.response!.statusCode, dioError.response!.data);
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  ApiException.fromString(String errorMsg) {
    message = errorMsg;
  }

  String message = '';

  String _handleError(int? statusCode, dynamic data) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 404:
        return 'The requested resource was not found';
      case 417:
        try {
          debugPrint("--RESPONSE $data");
          // var res = jsonDecode(data);
          // print('--RESPONSE $res');
          return "${data['Message'] ?? "Something went wrong on server!"}";
        } catch (e, s) {
          debugPrint('$e');
          debugPrintStack(stackTrace: s);
          return "Something went wrong on server";
        }
      case 500:
        return 'Internal server error';
      default:
        return 'Something went wrong on server';
    }
  }

  @override
  String toString() => message;
}
