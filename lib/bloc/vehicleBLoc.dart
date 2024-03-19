import 'dart:async';

import 'package:flutter/material.dart';
import 'package:verify/bloc/bloc.dart';
import 'package:verify/data/model/bikeImageSlider.dart';
import 'package:verify/data/model/carImageSlider.dart';
import 'package:verify/data/model/carNewLaunches.dart';
import 'package:verify/data/model/fetchServiceVehical.dart';
import 'package:verify/data/model/newLaunchesDetalilPage.dart';
import 'package:verify/data/model/parkingAlert.dart';
import 'package:verify/data/model/secoundHandCars.dart';
import 'package:verify/data/model/services.dart';
import 'package:verify/data/model/showBrand.dart';
import 'package:verify/data/repository/vehicleRepository.dart';
import 'package:verify/utils/message_handler.dart';

import '../UI/documents/NewDocumaintation.dart';
import '../UI/documents/property menus/Add/add_tenant_servant.dart';

class VehicleBloc extends Bloc {
  final VehicleRepository _vehicleRepository;

  VehicleBloc(this._vehicleRepository);

  ValueNotifier<bool> loader = ValueNotifier(false);

  init() async {
    try {
      loader.value = true;
      await bikeImageSlider();
      await carsNewUpcoming();
      await frontServiceApi();
      await carsNewLaunches();
      await carsImageSlider();
      await bikeNewUpcoming();
      await bikeNewLaunches();
      await parkingList();
      await hlooo();
    } catch (e) {
      print(e);
    } finally {
      loader.value = false;
    }
  }

  List<BikeImageSlider> bikeSlider = [];
  List<NewLaunches> bikeNew = [];
  List<NewLaunches> bikeUpcoming = [];
  List<carImageSlider> carSlider = [];
  List<NewLaunches> carNew = [];
  List<NewLaunches> carUpcoming = [];
  ValueNotifier<List<FrontServiceVehical>> frontService = ValueNotifier([]);

  Future bikeImageSlider() async {
    try {
      var res = await _vehicleRepository.bikeImageSlider();
      if (res != null) {
        bikeSlider = [];
        bikeSlider.addAll(res);
      } else {
        showMessage(const MessageType.error("Something went wrong!"));
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }
  }

  Future bikeNewLaunches() async {
    try {
      var res = await _vehicleRepository.bikeNewLaunches();
      if (res != null) {
        bikeNew = [];
        bikeNew.addAll(res);
      } else {
        showMessage(const MessageType.error("Something went wrong!"));
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }
  }

  Future bikeNewUpcoming() async {
    try {
      var res = await _vehicleRepository.bikeNewUpcoming();
      if (res != null) {
        bikeUpcoming = [];
        bikeUpcoming.addAll(res);
      } else {
        showMessage(const MessageType.error("Something went wrong!"));
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }
  }

  Future carsImageSlider() async {
    try {
      var res = await _vehicleRepository.carsImageSlider();
      if (res != null) {
        carSlider = [];
        carSlider.addAll(res);
      } else {
        showMessage(const MessageType.error("Something went wrong!"));
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }
  }

  Future carsNewLaunches() async {
    try {
      var res = await _vehicleRepository.carsNewLaunches();
      if (res != null) {
        carNew = [];
        carNew.addAll(res);
      } else {
        showMessage(const MessageType.error("Something went wrong!"));
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }
  }

  Future frontServiceApi() async {
    try {
      var res = await _vehicleRepository.frontServiceApi();
      if (res != null) {
        frontService.value.clear();
        frontService.value.addAll(res);
      } else {
        showMessage(const MessageType.error("Something went wrong!"));
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }
  }

  Future carsNewUpcoming() async {
    try {
      var res = await _vehicleRepository.carsNewUpcoming();
      if (res != null) {
        carUpcoming = [];
        carUpcoming.addAll(res);
      } else {
        showMessage(const MessageType.error("Something went wrong!"));
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }
  }

  ValueNotifier<List<LaunchesDetailsPage>> details = ValueNotifier([]);
  StreamController<String> detailsController = StreamController.broadcast();

  Future carNewDetail(String id) async {
    try {
       isLoading.value = true;
      var res = await _vehicleRepository.carNewDetail(id);
      if (res != null || res.isEmpty) {
        details.value.clear();
        details.value.addAll(res);

        detailsController.sink.add("success");
      } else {
        showMessage(const MessageType.error("No Data Found!"));
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }
  }

  Future carUpcomingDetail(String id) async {
    try {

      isLoading.value = true;
      var res = await _vehicleRepository.carUpcomingDetail(id);
      if (res != null || res.isEmpty) {
        details.value.clear();
        details.value.addAll(res);

        detailsController.sink.add("success");
      } else {
        showMessage(const MessageType.error("No Data Found!"));
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }
  }

  Future bikeNewDetail(String id) async {
    try {
      isLoading.value = true;
      var res = await _vehicleRepository.bikeNewDetail(id);
      if (res != null || res.isEmpty) {
        details.value.clear();
        details.value.addAll(res);
        detailsController.sink.add("success");
      } else {
        showMessage(const MessageType.error("No Data Found!"));
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }
  }

  Future bikeUpcomingDetail(String id) async {
    try {
      isLoading.value = true;
      var res = await _vehicleRepository.bikeUpcomingDetail(id);
      if (res != null || res.isEmpty) {
        details.value.clear();
        details.value.addAll(res);
        detailsController.sink.add("success");
      } else {
        showMessage(const MessageType.error("No Data Found!"));
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }
  }

  ValueNotifier<List<ShowBrand>> showBrands = ValueNotifier([]);

  Future showBrand() async {
    try {
      isLoading.value = true;
      var res = await _vehicleRepository.showBrand();
      if (res != null || res.isEmpty) {
        showBrands.value.clear();
        showBrands.value.addAll(res);

        // detailsController.sink.add("success");
      } else {
        showMessage(const MessageType.error("No Data Found!"));
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      isLoading.value = false;
    }
  }

  Future showBrandBike() async {
    try {
      isLoading.value = true;
      var res = await _vehicleRepository.showBrandBike();
      if (res != null || res.isEmpty) {
        showBrands.value.clear();
        showBrands.value.addAll(res);

        // detailsController.sink.add("success");
      } else {
        showMessage(const MessageType.error("No Data Found!"));
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      isLoading.value = false;
    }
  }


  ValueNotifier<List<SecoundHandCars>> showByBrands = ValueNotifier([]);
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future showCarsByBrand(String id) async {
    try {
      isLoading.value = true;
      var res = await _vehicleRepository.showByBrand(id);
      if (res != null || res.isEmpty) {
        showByBrands.value.clear();
        showByBrands.value.addAll(res);

        // detailsController.sink.add("success");
      } else {
        showMessage(const MessageType.error("No Data Found!"));
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }
    finally{
      isLoading.value = false;
    }
  }

  Future showBikeByBrand(String id) async {
    try {
      isLoading.value = true;
      var res = await _vehicleRepository.showByBrandBike(id);
      if (res != null || res.isEmpty) {
        showByBrands.value.clear();
        showByBrands.value.addAll(res);

        // detailsController.sink.add("success");
      } else {
        showMessage(const MessageType.error("No Data Found!"));
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      isLoading.value = false;
    }
  }

  ValueNotifier<List<SecoundHandCars>> secoundHandCars = ValueNotifier([]);

  Future allSecoundCars() async {
    try {
      isLoading.value = true;
      var res = await _vehicleRepository.secoundHandCars();
      if (res != null || res.isEmpty) {
        secoundHandCars.value.clear();
        secoundHandCars.value.addAll(res);

        // detailsController.sink.add("success");
      } else {
        showMessage(const MessageType.error("No Data Found!"));
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      isLoading.value = false;
    }
  }

  Future allSecoundBike() async {
    try {
      isLoading.value = true;
      var res = await _vehicleRepository.secoundHandBike();
      if (res != null || res.isEmpty) {
        secoundHandCars.value.clear();
        secoundHandCars.value.addAll(res);

        // detailsController.sink.add("success");
      } else {
        showMessage(const MessageType.error("No Data Found!"));
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      isLoading.value = false;
    }
  }

  ValueNotifier<List<SecoundHandCars>> seoundHandCarsDetail = ValueNotifier([]);

  Future secoundHandsCarsDetail(String id) async {
    try {
      isLoading.value = true;
      var res = await _vehicleRepository.secoundHandCarsDetail(id);
      if (res != null || res.isEmpty) {
        seoundHandCarsDetail.value.clear();
        seoundHandCarsDetail.value.addAll(res);

        // detailsController.sink.add("success");
      } else {
        showMessage(const MessageType.error("No Data Found!"));
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      isLoading.value = false;
    }
  }


  Future secoundHandsBikeDetail(String id) async {
    try {
      isLoading.value = true;
      var res = await _vehicleRepository.secoundHandBikeDetail(id);
      if (res != null || res.isEmpty) {
        seoundHandCarsDetail.value.clear();
        seoundHandCarsDetail.value.addAll(res);

        // detailsController.sink.add("success");
      } else {
        showMessage(const MessageType.error("No Data Found!"));
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      isLoading.value = false;
    }
  }

  StreamController<String> vehicleStream = StreamController.broadcast();

  sendParkingAlert(number) async {
    try {
      if(number == ""){
        showMessage(const MessageType.info("Field is required!"));
        return ;
      }
      isLoading.value = true;
      var res = await _vehicleRepository.sendParkingAlert(
          number: number
      );
      if(res == "Successfully Sent"){
        showMessage(const MessageType.success("Successfully Sent"));
      }
      // if(res == "Successfully Added"){
      //   print("object");
      //   DocumentationStream.sink.add("POP");
      // }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      isLoading.value = false;
    }
  }

  ValueNotifier<List<ParkingAlerts>> parkingLists = ValueNotifier([]);
  Future parkingList() async {
    try {
      isLoading.value = true;
      var res = await _vehicleRepository.alertList();
      if (res != null || res.isEmpty) {
        parkingLists.value.clear();
        parkingLists.value.addAll(res);

        // detailsController.sink.add("success");
      } else {
        showMessage(const MessageType.error("No Data Found!"));
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      isLoading.value = false;
    }
  }

  Future hlooo() async {



    return Add_Tenant_Servant();

  }

}
