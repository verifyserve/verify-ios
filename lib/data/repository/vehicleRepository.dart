import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:verify/UI/vehicle/ParkingAlert.dart';
import 'package:verify/data/model/bikeImageSlider.dart';
import 'package:verify/data/model/bikeImageSlider.dart';
import 'package:verify/data/model/bikeImageSlider.dart';
import 'package:verify/data/model/carImageSlider.dart';
import 'package:verify/data/model/carNewLaunches.dart';
import 'package:verify/data/model/fetchServiceVehical.dart';
import 'package:verify/data/model/newLaunchesDetalilPage.dart';
import 'package:verify/data/model/secoundHandCars.dart';
import 'package:verify/data/model/services.dart';
import 'package:verify/data/model/showBrand.dart';
import 'package:verify/data/network/api_service.dart';

import '../model/bikeImageSlider.dart';
import '../model/parkingAlert.dart';

class VehicleRepository {
  final SharedPreferences prefs;
  final ApiService _api;

  VehicleRepository(this.prefs, this._api);

  Future<List<FrontServiceVehical>> frontServiceApi() async {
    String url = "http://www.verifyserve.social/WebService1.asmx/top_cat";
    var res = await _api.getRequest(url);
    var resData = jsonDecode(res);
    return List.from(resData.map((e) => FrontServiceVehical.fromJson(e)));
  }

  Future<List<carImageSlider>> carsImageSlider() async {
    String url = "http://www.verifyserve.social/WebService1.asmx/Cars_Slider";
    var res = await _api.getRequest(url);
    var resData = jsonDecode(res);
    return List.from(resData.map((e) => carImageSlider.fromJson(e)));
  }

  Future<List<BikeImageSlider>> bikeImageSlider() async {
    String url = "http://www.verifyserve.social/WebService1.asmx/Bike_Slider";
    var res = await _api.getRequest(url);
    var resData = jsonDecode(res);
    return List.from(resData.map((e) => BikeImageSlider.fromJson(e)));
  }

  Future<List<NewLaunches>> carsNewLaunches() async {
    String url = "http://www.verifyserve.social/WebService1.asmx/Shownewlaunches_car";
    var res = await _api.getRequest(url);
    var resData = jsonDecode(res);
    return List.from(resData.map((e) => NewLaunches.fromJson(e)));
  }

  Future<List<NewLaunches>> carsNewUpcoming() async {
    String url = "http://www.verifyserve.social/WebService1.asmx/Showupcominglaunches_car";
    var res = await _api.getRequest(url);
    var resData = jsonDecode(res);
    return List.from(resData.map((e) => NewLaunches.fromJson(e)));
  }

  Future<List<NewLaunches>> bikeNewLaunches() async {
    String url = "http://www.verifyserve.social/WebService1.asmx/Shownewlaunches_bike";
    var res = await _api.getRequest(url);
    var resData = jsonDecode(res);
    return List.from(resData.map((e) => NewLaunches.fromJson(e)));
  }

  Future<List<NewLaunches>> bikeNewUpcoming() async {
    String url = "http://www.verifyserve.social/WebService1.asmx/Showupcominglaunches_bike";
    var res = await _api.getRequest(url);
    var resData = jsonDecode(res);
    return List.from(resData.map((e) => NewLaunches.fromJson(e)));
  }

  Future<List<LaunchesDetailsPage>> carNewDetail(String id) async {
    String url = "http://www.verifyserve.social/WebService1.asmx/Shownewlaunches_carDetails";
    Map<String,dynamic> data = {
      "id":id,
    };
    var res = await _api.getRequest(url,data: data);

    var resData = jsonDecode(res);
    return List.from(resData.map((e) => LaunchesDetailsPage.fromJson(e)));
  }

  Future<List<LaunchesDetailsPage>> carUpcomingDetail(String id) async {
    String url = "http://www.verifyserve.social/WebService1.asmx/Showupcominglaunches_carDetails";
    Map<String,dynamic> data = {
      "id":id,
    };
    var res = await _api.getRequest(url,data: data);

    var resData = jsonDecode(res);
    return List.from(resData.map((e) => LaunchesDetailsPage.fromJson(e)));
  }

  Future<List<LaunchesDetailsPage>> bikeNewDetail(String id) async {
    String url = "http://www.verifyserve.social/WebService1.asmx/Shownewlaunches_bikedetails";
    Map<String,dynamic> data = {
      "id":id,
    };
    var res = await _api.getRequest(url,data: data);

    var resData = jsonDecode(res);
    return List.from(resData.map((e) => LaunchesDetailsPage.fromJson(e)));
  }

  Future<List<LaunchesDetailsPage>> bikeUpcomingDetail(String id) async {
    String url = "http://www.verifyserve.social/WebService1.asmx/Showupcominglaunches_bikeDetails";
    Map<String,dynamic> data = {
      "id":id,
    };
    var res = await _api.getRequest(url,data: data);

    var resData = jsonDecode(res);
    return List.from(resData.map((e) => LaunchesDetailsPage.fromJson(e)));
  }

  Future<List<ShowBrand>> showBrand() async {
    String url = "http://www.verifyserve.social/WebService1.asmx/ShowBrand";
    var res = await _api.getRequest(url);

    var resData = jsonDecode(res);
    return List.from(resData.map((e) => ShowBrand.fromJson(e)));
  }

  Future<List<SecoundHandCars>> showByBrand(String brand) async {
    String url = "http://www.verifyserve.social/WebService1.asmx/ShowProduct_ByBrand";
    Map<String,dynamic> data = {
      "Brand":brand,
    };
    var res = await _api.getRequest(url,data: data);

    var resData = jsonDecode(res);
    return List.from(resData.map((e) => SecoundHandCars.fromJson(e)));
  }

  Future<List<SecoundHandCars>> secoundHandCars() async {
    String url = "http://www.verifyserve.social/WebService1.asmx/SecondHand_carVechicle";
    var res = await _api.getRequest(url);

    var resData = jsonDecode(res);
    return List.from(resData.map((e) => SecoundHandCars.fromJson(e)));
  }

  Future<List<SecoundHandCars>> secoundHandCarsDetail(String id) async {
    String url = "http://www.verifyserve.social/WebService1.asmx/SecondHand_carVechicle_Byid";
    Map<String,dynamic> data = {
      "id":id,
    };
    var res = await _api.getRequest(url,data: data);

    var resData = jsonDecode(res);
    return List.from(resData.map((e) => SecoundHandCars.fromJson(e)));
  }


  Future<List<ShowBrand>> showBrandBike() async {
    String url = "http://www.verifyserve.social/WebService1.asmx/ShowBrand_Bike";
    var res = await _api.getRequest(url);

    var resData = jsonDecode(res);
    return List.from(resData.map((e) => ShowBrand.fromJson(e)));
  }

  Future<List<SecoundHandCars>> showByBrandBike(String brand) async {
    String url = "http://www.verifyserve.social/WebService1.asmx/ShowProduct_ByBrand_Bike";
    Map<String,dynamic> data = {
      "Brand":brand,
    };
    var res = await _api.getRequest(url,data: data);

    var resData = jsonDecode(res);
    return List.from(resData.map((e) => SecoundHandCars.fromJson(e)));
  }

  Future<List<SecoundHandCars>> secoundHandBike() async {
    String url = "http://www.verifyserve.social/WebService1.asmx/SecondHand_BikeVechicle";
    var res = await _api.getRequest(url);

    var resData = jsonDecode(res);
    return List.from(resData.map((e) => SecoundHandCars.fromJson(e)));
  }

  Future<List<SecoundHandCars>> secoundHandBikeDetail(String id) async {
    String url = "http://www.verifyserve.social/WebService1.asmx/SecondHand_BikeVechicle_Byid";
    Map<String,dynamic> data = {
      "id":id,
    };
    var res = await _api.getRequest(url,data: data);

    var resData = jsonDecode(res);
    return List.from(resData.map((e) => SecoundHandCars.fromJson(e)));
  }

  Future sendParkingAlert({required number}) async{
    String url = "http://www.verifyserve.social/WebService1.asmx/Send_Parking";
    Map<String,dynamic> data = {
      "Car_no":number,
    };
    var res = await _api.getRequest(url,data: data);
    return res;
  }

  Future<List<ParkingAlerts>> alertList() async {
    String url = "http://www.verifyserve.social/WebService1.asmx/Show_Parking_alert";
    Map<String,dynamic> data = {
      "number":prefs.getString('vehicleNo'),
    };
    var res = await _api.getRequest(url,data: data);

    var resData = jsonDecode(res);
    return List.from(resData.map((e) => ParkingAlerts.fromJson(e)));
  }
}