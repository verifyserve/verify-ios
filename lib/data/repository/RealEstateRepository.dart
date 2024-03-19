import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verify/data/model/commercialDetail.dart';
import 'package:verify/data/model/realEstate.dart';
import 'package:verify/data/model/realestateFilter.dart';
import 'package:verify/data/model/realstateLocation.dart';
import 'package:verify/data/network/api_service.dart';

class RealEstateRepository {

  final SharedPreferences prefs;
  final ApiService _api;

  RealEstateRepository(this.prefs, this._api);

  Future<List<RealStateHorizontalCategory>> topHorizontalCategory() async{
    String url = "http://www.verifyserve.social/WebService1.asmx/Show_Realestate_topcat";
    var res = await _api.getRequest(url);
    var resData = jsonDecode(res);
    return List.from(resData.map((e) => RealStateHorizontalCategory.fromJson(e)));
  }

  Future<List<RealStateFilters>> getList(path,type) async{
    String url = "http://www.verifyserve.social/WebService1.asmx/showrealestatedata";
    Map<String,dynamic> data = {
      "Path":"$path",
      "Type":"$type",
    };
    var res = await _api.getRequest(url,data: data);
    var resData = jsonDecode(res);
    return List.from(resData.map((e) => RealStateFilters.fromJson(e)));
  }

  Future<List<commercialPGDetail>> getCommercialList(path,type) async{
    String url = "http://www.verifyserve.social/WebService1.asmx/showcomericial_data";
    Map<String,dynamic> data = {
      "Buy_or_Lease":"$path",
      "Type":"$type",
    };
    var res = await _api.getRequest(url,data: data);
    var resData = jsonDecode(res);
    return List.from(resData.map((e) => commercialPGDetail.fromJson(e)));
  }

  Future<List<RealStateFilters>> getListByFilter(path,type,location,bhk) async{
    String url = "http://www.verifyserve.social/WebService1.asmx/showrealestatedata_Byfilter";
    Map<String,dynamic> data = {
      "Path":"$path",
      "Type":"$type",
      "Filterlocation":"$location",
      "Bhk":"$bhk",
    };
    var res = await _api.getRequest(url,data: data);
    var resData = jsonDecode(res);
    return List.from(resData.map((e) => RealStateFilters.fromJson(e)));
  }

  Future<List<realstateLocation>> getLocation() async{
    String url = "http://www.verifyserve.social/WebService1.asmx/Realestatedata_Location";
    var res = await _api.getRequest(url);
    var resData = jsonDecode(res);
    return List.from(resData.map((e) => realstateLocation.fromJson(e)));
  }

  Future<List<RealStateFilters>> buyRentDetails(String id) async{
    String url = "http://www.verifyserve.social/WebService1.asmx/Show_realestate_detail";
    Map<String,dynamic> data = {
      "id":id
    };
    var res = await _api.getRequest(url,data: data);
    var resData = jsonDecode(res);
    return List.from(resData.map((e) => RealStateFilters.fromJson(e)));
  }

  Future<List<commercialPGDetail>> commercialDetails(String id) async{
    String url = "http://www.verifyserve.social/WebService1.asmx/ShowCommericalbyID";
    Map<String,dynamic> data = {
      "id":id
    };
    var res = await _api.getRequest(url,data: data);
    var resData = jsonDecode(res);
    return List.from(resData.map((e) => commercialPGDetail.fromJson(e)));
  }

  Future<List<commercialPGDetail>> getPGListByFilter(food,furnished,gender,foodType,AC,location) async{
    String url = "http://www.verifyserve.social/WebService1.asmx/ShowPG_data_Byfilter";
    Map<String,dynamic> data = {
    "Food_availablity" : "$food",
    "furnished" : "$furnished" ,
    "gender" : "$gender",
    "food_type" : "$foodType",
    "ac_non_ac" : "$AC",
      "location":"$location",
    };
    var res = await _api.getRequest(url,data: data);
    var resData = jsonDecode(res);
    return List.from(resData.map((e) => commercialPGDetail.fromJson(e)));
  }

  Future<List<commercialPGDetail>> getCommercialListByFilter(lookingType,type,location,bhk) async{
    String url = "http://www.verifyserve.social/WebService1.asmx/ShowCommercial_Byfilter";
    Map<String,dynamic> data = {
      "Lookingtype":"$lookingType",
      "Type":"$type",
      "filterlocation":"$location",
      "Bhk":"$bhk",
    };
    var res = await _api.getRequest(url,data: data);
    var resData = jsonDecode(res);
    return List.from(resData.map((e) => commercialPGDetail.fromJson(e)));
  }

  Future<List<commercialPGDetail>> getPGData() async{
    String url = "http://www.verifyserve.social/WebService1.asmx/ShowPG";
    var res = await _api.getRequest(url);
    var resData = jsonDecode(res);
    return List.from(resData.map((e) => commercialPGDetail.fromJson(e)));
  }

  Future<List<commercialPGDetail>> PGDetail(String id) async{
    String url = "http://www.verifyserve.social/WebService1.asmx/ShowPGbyID";
    Map<String,dynamic> data = {
      "id":id
    };
    var res = await _api.getRequest(url,data: data);
    var resData = jsonDecode(res);
    return List.from(resData.map((e) => commercialPGDetail.fromJson(e)));
  }

  Future submitRealEstate(String type,String id,String price,String mobile) async{
    String url = "http://www.verifyserve.social/WebService1.asmx/Submit_Realestate";
    Map<String,dynamic> data = {
      "Property_Type":type,
      "property_id":id,
      "Offer_Price":price,
      "User_Mobile":mobile
    };
    var res = await _api.getRequest(url,data: data);
    // var resData = jsonDecode(res);
    return res;
  }
}