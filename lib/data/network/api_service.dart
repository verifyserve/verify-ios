import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'api_exception.dart';

class ApiService {
  final Dio dio;
  ApiService(this.dio);

  dynamic postRequest(String subUrl, Map<String, dynamic> inputData,
      {bool withFile = false,
      bool requireToken = false,
      bool isJson = false}) async {
    try {
      print('---POST url $subUrl');
      print('---Params $inputData');
      // print('---Params ${json.encode(inputData)}');
      Response res = await dio.post(
        subUrl,
        data: withFile
            ? FormData.fromMap(inputData)
            : isJson
                ? json.encode(inputData)
                : inputData,
        options: Options(
          // contentType: Headers.formUrlEncodedContentType,
          contentType: Headers.jsonContentType,
          headers: requireToken
              ? {
                  'token': true,
                }
              : {},
        ),
      );
      print(res);
      print('${res.statusCode}');
      print("""asdf""");
      if (res.statusCode == 200) {
        var rData = res.data;
        print('---RESULT: $rData');
        print('---RESULT END');
        return rData;
      } else if(res.statusCode == 417) {
        throw "${jsonDecode(res.data)['message'] ?? "Something went wrong on server1!"}";
      } else {
        throw ApiException.fromString("Error Occurred. ${res.statusCode}");
      }
    } on SocketException {
      throw ApiException.fromString("No Internet Connection!");
    } on DioException catch (dioError) {
      throw ApiException.fromDioError(dioError);
    }
  }

  dynamic getRequest(String subUrl,
      {Map<String, dynamic> data = const {}, bool requireToken = false}) async {
    try {
      print('---GET url $subUrl');
      print('---Params $data');
      Response res = await dio.get(
        subUrl,
        queryParameters: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType, //'application/json',
          headers: requireToken
              ? {
                  'token': true,
                }
              : {},
        ),
      );
      print('---RESULT: ${res.data}');
      if (res.statusCode == 200) {
        var rData = res.data;
        print('---RESULT END');
        return rData;
      } else {
        throw ApiException.fromString("Error Occurred. ${res.statusCode}");
      }
    } on SocketException {
      throw ApiException.fromString("No Internet Connection!");
    } on DioException catch (dioError) {
      throw ApiException.fromDioError(dioError);
    }
  }

  Future<dynamic> dynamicApi(String url, Map<String, dynamic> data) async {
    try {
      // print('---GET url $url');
      // print('---Params $data');
      Response res = await dio.get(url, queryParameters: data);
      // print('---RESULT: ${res.data}');
      if (res.statusCode == 200) {
        var rData = res.data;
        print('---RESULT END');
        return rData;
      } else {
        throw ApiException.fromString("Error Occurred. ${res.statusCode}");
      }
    } on SocketException {
      throw ApiException.fromString("No Internet Connection!");
    } on DioException catch (dioError) {
      throw ApiException.fromDioError(dioError);
    }
  }
}
