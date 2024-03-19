import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:verify/data/model/hotelList.dart';

import '../model/hotelImageSlider.dart';
import '../network/api_service.dart';

class HotelRepository{
  final SharedPreferences prefs;
  final ApiService _api;

  HotelRepository(this.prefs,this._api);

  Future<List<HotelList>> hotelList() async {
    String url = "http://www.verifyserve.social/WebService1.asmx/ShowDownHotelimg";
    var res = await _api.getRequest(url);
    var resData = jsonDecode(res);
    return List.from(resData.map((e) => HotelList.fromJson(e)));
  }

  Future<List<HotelImageSlider>> hotelImageList() async {
    String url = "http://www.verifyserve.social/WebService1.asmx/ShowHotelimg";
    var res = await _api.getRequest(url);
    var resData = jsonDecode(res);
    return List.from(resData.map((e) => HotelImageSlider.fromJson(e)));
  }

}