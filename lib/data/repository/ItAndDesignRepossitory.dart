import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:verify/data/model/ItAndDesign.dart';
import 'package:verify/data/model/consultantAndLawyer.dart';
import 'package:verify/data/network/api_service.dart';

class ItAndDesignRepository {
  final SharedPreferences prefs;
  final ApiService _api;

  ItAndDesignRepository(this.prefs, this._api);

  Future<List<ItDesign>> mainPageGrid() async {
    String url = "http://www.verifyserve.social/WebService1.asmx/IT_Design";
    var res = await _api.getRequest(url);
    var resData = jsonDecode(res);
    return List.from(resData.map((e) => ItDesign.fromJson(e)));
  }
}