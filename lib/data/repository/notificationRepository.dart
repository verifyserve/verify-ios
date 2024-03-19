import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:verify/data/model/loginUser.dart';
import 'package:verify/data/model/showNotification.dart';
import 'package:verify/data/network/api_service.dart';

class NotificationRepository {
  final SharedPreferences prefs;
  final ApiService _api;

  NotificationRepository(this.prefs, this._api);

  Future<List<ShowNotification>> showNotification() async {
    String url = "http://www.verifyserve.social/WebService1.asmx/Show_Notification_byNumber";
    Map<String,dynamic> data = {
      "number":prefs.getString('phone'),
    };
    var res = await _api.getRequest(url,data: data);
    var resData = jsonDecode(res);
    return  List.from(resData.map((e) => ShowNotification.fromJson(e)));
  }

  Future sendNotification({String? date,String? time,String? description,String? location,String? number,String? type}) async {
    String url = "http://www.verifyserve.social/WebService1.asmx/Send_Notification";
    Map<String,dynamic> data = {
    "Title" : prefs.getString("name"),
    "Date" : date,
    "Time" : time,
    "Discription" : description,
    "Location" : location,
    "number" : number,
    "Type" : type
    };
    var res = await _api.getRequest(url,data: data);
    // var resData = jsonDecode(res);
    return res;
  }

  Future<List<ShowNotification>> recentNotification() async {
    String url = "http://www.verifyserve.social/WebService1.asmx/History_Notification_byNumber";
    Map<String,dynamic> data = {
      "name": prefs.getString('name'),
    };
    var res = await _api.getRequest(url,data: data);
    var resData = jsonDecode(res);
    return  List.from(resData.map((e) => ShowNotification.fromJson(e)));
  }
}