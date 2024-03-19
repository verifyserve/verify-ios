import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:verify/data/model/services.dart';
import 'package:verify/data/model/subService.dart';
import 'package:verify/data/network/api_service.dart';

class ServiceRepository {
  final SharedPreferences prefs;
  final ApiService _api;

  ServiceRepository(this.prefs, this._api);

  Future<List<Service>> mainPageGrid() async {
    String url = "http://www.verifyserve.social/WebService1.asmx/ShowServiceCat";
    var res = await _api.getRequest(url);
    var resData = jsonDecode(res);
    return List.from(resData.map((e) => Service.fromJson(e)));
  }

  Future bookSlot({String? time, String? day,String? tittle, String? Address,String? Location, String? Longitude,String? Latitude,String? Type_of_requirement,String? customer_name,String? booking_time,String? customer_number}) async {
    String url = "http://www.verifyserve.social/WebService1.asmx/Addtime";
    Map<String,dynamic> data = {
      "tt":time,
      "dt":day,
      "ww":tittle,
      "Scid":prefs.getString("id"),
      "Address":Address,
      "Location":Location,
      "Longitude":Longitude,
      "Latitude":Latitude,
      "Type_of_requirement":Type_of_requirement,
      "customer_name":customer_name,
      "booking_time":booking_time,
      "customer_number":customer_number,
    };
    var res = await _api.getRequest(url,data: data);
    // var resData = jsonDecode(res);
    return res;
  }

  Future<List<SubService>> subService(id) async{
    String url = "http://www.verifyserve.social/WebService1.asmx/ShowSubServicebyType";
    Map<String,dynamic> data = {
      "location":prefs.getString("location"),
      "Serivicelist_id":"$id",
    };
    var res = await _api.getRequest(url,data: data);
    var resData = jsonDecode(res);
    return List.from(resData.map((e) => SubService.fromJson(e)));
  }

  Future<List<SubService>> subDetails(int id) async{
    String url = "http://www.verifyserve.social/WebService1.asmx/ShowSubServicebyID";
    Map<String,dynamic> data = {
      "Sid":id
    };
    var res = await _api.getRequest(url,data: data);
    var resData = jsonDecode(res);
    return List.from(resData.map((e) => SubService.fromJson(e)));
  }

}