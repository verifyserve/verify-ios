import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:verify/data/model/consultantAndLawyer.dart';
import 'package:verify/data/model/jobs.dart';
import 'package:verify/data/network/api_service.dart';


class JobsRepository {
  final SharedPreferences prefs;
  final ApiService _api;

  JobsRepository(this.prefs, this._api);

  Future<List<Jobs>> mainPageGrid() async {
    String url = "http://www.verifyserve.social/WebService1.asmx/Jobs";
    var res = await _api.getRequest(url);
    var resData = jsonDecode(res);
    return List.from(resData.map((e) => Jobs.fromJson(e)));
  }

}