import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:verify/data/model/consultantAndLawyer.dart';
import 'package:verify/data/network/api_service.dart';

class ConsultantRepository {
  final SharedPreferences prefs;
  final ApiService _api;

  ConsultantRepository(this.prefs, this._api);

  Future<List<ConsultantAndLawyer>> mainPageGrid() async {
    String url = "http://www.verifyserve.social/WebService1.asmx/Consultant_Lawyers";
    var res = await _api.getRequest(url);
    var resData = jsonDecode(res);
    return List.from(resData.map((e) => ConsultantAndLawyer.fromJson(e)));
  }
}