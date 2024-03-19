import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppInterceptors extends Interceptor {
  @override
  Future<dynamic> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers.containsKey("token")) {
      // print('asking token');
      //remove the auxiliary header
      options.headers.remove("token");

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.get("token");
      // options.headers.addAll({"token": "$header"});
      debugPrint("--HEADER: Bearer $token");
      options.headers["Authorization"] = "Bearer $token";
      // return handler.next(options);
    }

    // if (options.headers.containsKey("now-payment-key")) {
    //   debugPrint('uri ${options.uri.path}');
    //   debugPrint('host ${options.uri.host}');
    //   debugPrint('data ${options.data.runtimeType}');
    //   debugPrint('baseUrl ${options.baseUrl}');
    //   // print('baseUrl ${options.}');
    //   // print('asking token');
    //   //remove the auxiliary header
    //   // options.headers.remove("now-payment-key");
    //   // debugPrint('x-api-key R4NJQVM-7MW4Z21-MPRSN3B-CRKJ41S');
    //   // options.headers["x-api-key"] = "R4NJQVM-7MW4Z21-MPRSN3B-CRKJ41S";
    //   // return handler.next(options);
    // }
    return handler.next(options);
  }

  @override
  Future<dynamic> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response != null &&
        err.response?.statusCode != null &&
        err.response?.statusCode == 401) {
      // (await CacheManager()).cleanCache();
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString("apiToken", "");
      // navigatorKey.currentState.pushNamed(SplashScreen.routeName);

    }
    return handler.next(err);
  }

  @override
  Future<dynamic> onResponse(Response response, ResponseInterceptorHandler handler) async {
    // print(response);
    return handler.next(response);
  }
}