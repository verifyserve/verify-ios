import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verify/data/model/homePageGrid.dart';
import 'package:verify/data/model/homeSlider.dart';
import 'package:verify/data/network/api_service.dart';

class HomeRepository {
  final SharedPreferences prefs;
  final ApiService _api;

  HomeRepository(this.prefs, this._api);

  Future<List<HomePageGrid>> mainPageGrid() async {
    String url = "http://www.verifyserve.social/WebService1.asmx/MainPage";
    var res = await _api.getRequest(url);
    var resData = jsonDecode(res);
    return List.from(resData.map((e) => HomePageGrid.fromJson(e)));
  }
}