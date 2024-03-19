import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:verify/data/model/loginUser.dart';
import 'package:verify/data/network/api_service.dart';

class AuthRepository {
  final SharedPreferences prefs;
  final ApiService _api;

  AuthRepository(this.prefs, this._api);

  Future<List<loginUser>> login({String? email, String? pass}) async {
    String url = "https://verifyserve.social/WebService1.asmx/login2";
    Map<String,dynamic> data = {
      "number":email,
      "pass":pass,
    };
    var res = await _api.getRequest(url,data: data);
    var resData = jsonDecode(res);
    return  List.from(resData.map((e) => loginUser.fromJson(e)));
  }

  Future register({String? email, String? pass,String? name,String? number,String? vehicle,String? location,String? token,}) async {
    String url = "https://verifyserve.social/WebService1.asmx/registration_full";
    Map<String,dynamic> data = {
      "Email":email,
      "Password":pass,
      "Name":name,
      "Number":number,
      "Vehicle_no":vehicle,
      "Location":location,
      "Token_no":token,
    };
    var res = await _api.getRequest(url,data: data);
    // var resData = jsonDecode(res);
    return res;
  }

  Future<List<loginUser>> profile({String? email}) async {
    String url = "http://www.verifyserve.social/WebService1.asmx/Profile";
    Map<String,dynamic> data = {
      "Email":email,
    };
    var res = await _api.getRequest(url,data: data);
    var resData = jsonDecode(res);
    return  List.from(resData.map((e) => loginUser.fromJson(e)));
  }
}