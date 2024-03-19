import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:verify/data/model/consultantAndLawyer.dart';
import 'package:verify/data/model/eventsAndWedding.dart';
import 'package:verify/data/network/api_service.dart';

class EventsAndWeddingRepository {
  final SharedPreferences prefs;
  final ApiService _api;

  EventsAndWeddingRepository(this.prefs, this._api);

  Future<List<EventsAndWedding>> mainPageGrid() async {
    String url = "http://www.verifyserve.social/WebService1.asmx/Event_Weeding";
    var res = await _api.getRequest(url);
    var resData = jsonDecode(res);
    return List.from(resData.map((e) => EventsAndWedding.fromJson(e)));
  }
}