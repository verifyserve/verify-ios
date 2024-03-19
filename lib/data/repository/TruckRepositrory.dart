
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:verify/data/model/truckIist.dart';

import '../network/api_service.dart';

class TruckRepository{
  final SharedPreferences prefs;
  final ApiService _api;

  TruckRepository(this.prefs,this._api);

  Future<List<TruckList>> truckList() async {
    String url = "http://www.verifyserve.social/WebService1.asmx/ShowTruck";
    var res = await _api.getRequest(url);
    var resData = jsonDecode(res);
    return List.from(resData.map((e) => TruckList.fromJson(e)));
  }

  Future<List<TruckList>> jcbList() async {
    String url = "http://www.verifyserve.social/WebService1.asmx/ShowJCB";
    var res = await _api.getRequest(url);
    var resData = jsonDecode(res);
    return List.from(resData.map((e) => TruckList.fromJson(e)));
  }

}