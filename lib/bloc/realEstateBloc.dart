import 'dart:async';

import 'package:flutter/material.dart';
import 'package:verify/UI/realEstate/real_estateList.dart';
import 'package:verify/bloc/bloc.dart';
import 'package:verify/data/model/commercialDetail.dart';
import 'package:verify/data/model/realEstate.dart';
import 'package:verify/data/model/realestateFilter.dart';
import 'package:verify/data/model/realstateLocation.dart';
import 'package:verify/data/repository/RealEstateRepository.dart';
import 'package:verify/utils/message_handler.dart';

class RealEstateBloc extends Bloc {
  final RealEstateRepository _realEstateRepository;
  RealEstateBloc(this._realEstateRepository);

  List<RealStateHorizontalCategory> topList = [];
  ValueNotifier<bool> topListLoader = ValueNotifier(false);
  topListList() async {
    try {
      topListLoader.value = true;
      var res = await _realEstateRepository.topHorizontalCategory();
      if (res != null) {
        topList = [];
        topList.addAll(res);
        print(topList.length);
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    } finally {
      topListLoader.value = false;
    }
  }

  ValueNotifier<String?> path = ValueNotifier("Rent");
  ValueNotifier<String?> type = ValueNotifier("Flat");
  ValueNotifier<String?> location = ValueNotifier(null);
  ValueNotifier<String?> bhk = ValueNotifier("1 BHK");
  List<RealStateFilters> realStateList = [];
  StreamController<String> realEstateStreamController =
      StreamController.broadcast();
  ValueNotifier<bool> buttonLoader = ValueNotifier(false);
  getListByFilter() async {
    try {
      buttonLoader.value = true;
      if(location.value == null ){
        showMessage(const MessageType.info("location can not empty"));
        return;
      }
      var res = await _realEstateRepository.getListByFilter(path.value, type.value,location.value,bhk.value);
      if(res == null || res.isEmpty){
        showMessage(MessageType.error("No Data Found"));
      }else{
        realStateList = [];
        realStateList.addAll(res);
        realEstateStreamController.sink.add("success");
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      buttonLoader.value = false;
    }
  }

  ValueNotifier<List<RealStateFilters>> buyFlatList = ValueNotifier([]);
  ValueNotifier<List<RealStateFilters>> buyShowroomList = ValueNotifier([]);
  ValueNotifier<List<RealStateFilters>> buyWarehouseList = ValueNotifier([]);
  ValueNotifier<List<RealStateFilters>> buyShopList = ValueNotifier([]);
  ValueNotifier<List<RealStateFilters>> buyHouseList = ValueNotifier([]);
  ValueNotifier<List<RealStateFilters>> buyPlotsList = ValueNotifier([]);
  ValueNotifier<List<RealStateFilters>> buyFarmsList = ValueNotifier([]);
  ValueNotifier<List<RealStateFilters>> buyBasementList = ValueNotifier([]);
  ValueNotifier<List<RealStateFilters>> buyRoofList = ValueNotifier([]);
  ValueNotifier<List<RealStateFilters>> buyOfficeList = ValueNotifier([]);
  ValueNotifier<List<RealStateFilters>> buyAppartmentList = ValueNotifier([]);
  ValueNotifier<List<RealStateFilters>> buyVillaList = ValueNotifier([]);
  ValueNotifier<bool> buyRentLoader = ValueNotifier(false);
  buyRent() async {
    try {
      buyRentLoader.value = true;
      var flat = await _realEstateRepository.getList(path.value, "Flat");
      var showroom =
          await _realEstateRepository.getList(path.value, "Showroom");
      var warehouse =
          await _realEstateRepository.getList(path.value, "Warehouse");
      var shop = await _realEstateRepository.getList(path.value, "Shop");
      var house = await _realEstateRepository.getList(path.value, "House");
      var plots = await _realEstateRepository.getList(path.value, "Plots");
      var farms = await _realEstateRepository.getList(path.value, "Farms");
      var basement =
          await _realEstateRepository.getList(path.value, "Basement");
      var roof = await _realEstateRepository.getList(path.value, "Roof");
      var office = await _realEstateRepository.getList(path.value, "Office");
      var appartment =
          await _realEstateRepository.getList(path.value, "Appartment");
      var villa = await _realEstateRepository.getList(path.value, "Villa");
      if (flat != null) {
        buyFlatList.value = [];
        buyFlatList.value.addAll(flat);
      }
      if (showroom != null) {
        buyShowroomList.value = [];
        buyShowroomList.value.addAll(showroom);
      }
      if (warehouse != null) {
        buyWarehouseList.value = [];
        buyWarehouseList.value.addAll(warehouse);
      }
      if (shop != null) {
        buyShopList.value = [];
        buyShopList.value.addAll(shop);
      }
      if (house != null) {
        buyHouseList.value = [];
        buyHouseList.value.addAll(house);
      }
      if (plots != null) {
        buyPlotsList.value = [];
        buyPlotsList.value.addAll(plots);
      }
      if (farms != null) {
        buyFarmsList.value = [];
        buyFarmsList.value.addAll(farms);
      }
      if (basement != null) {
        buyBasementList.value = [];
        buyBasementList.value.addAll(basement);
      }
      if (roof != null) {
        buyRoofList.value = [];
        buyRoofList.value.addAll(roof);
      }
      if (office != null) {
        buyOfficeList.value = [];
        buyOfficeList.value.addAll(office);
      }
      if (appartment != null) {
        buyAppartmentList.value = [];
        buyAppartmentList.value.addAll(appartment);
      }
      if (villa != null) {
        buyVillaList.value = [];
        buyVillaList.value.addAll(villa);
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      buyRentLoader.value = false;
    }
  }

  List<realstateLocation> locationData = [];
  ValueNotifier<bool> locationLoader = ValueNotifier(false);
  getLocation() async {
    try {
      locationLoader.value = true;
      var res = await _realEstateRepository.getLocation();
      if(res!=null){
        locationData = [];
        locationData.addAll(res);
      }else{
        showMessage(MessageType.success("No Data Found"));
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      locationLoader.value = false;
    }
  }

  List<RealStateFilters> buyRentDetailsData = [];
  ValueNotifier<bool> buyRentDetailLoader = ValueNotifier(false);
  buyRentDetails(String id) async {
    try {
      buyRentDetailLoader.value = true;
      var res = await _realEstateRepository.buyRentDetails(id);
      if(res!=null){
        buyRentDetailsData = [];
        buyRentDetailsData.addAll(res);
      }else{
        showMessage(MessageType.success("No Data Found"));
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      buyRentDetailLoader.value = false;
    }
  }

  ValueNotifier<List<commercialPGDetail>> commercialFlatList = ValueNotifier([]);
  ValueNotifier<List<commercialPGDetail>> commercialShowroomList = ValueNotifier([]);
  ValueNotifier<List<commercialPGDetail>> commercialWarehouseList = ValueNotifier([]);
  ValueNotifier<List<commercialPGDetail>> commercialShopList = ValueNotifier([]);
  ValueNotifier<List<commercialPGDetail>> commercialHouseList = ValueNotifier([]);
  ValueNotifier<List<commercialPGDetail>> commercialPlotsList = ValueNotifier([]);
  ValueNotifier<List<commercialPGDetail>> commercialFarmsList = ValueNotifier([]);
  ValueNotifier<List<commercialPGDetail>> commercialBasementsList = ValueNotifier([]);
  ValueNotifier<List<commercialPGDetail>> commercialRoofList = ValueNotifier([]);
  ValueNotifier<List<commercialPGDetail>> commercialOfficeList = ValueNotifier([]);
  ValueNotifier<List<commercialPGDetail>> commercialApartmentList = ValueNotifier([]);
  ValueNotifier<List<commercialPGDetail>> commercialVillaList = ValueNotifier([]);
  ValueNotifier<bool> commercialLoader = ValueNotifier(false);
  showCommercial(String path) async {
    try {
      commercialLoader.value = true;
      var flat = await _realEstateRepository.getCommercialList(path, "Flat");
      var showroom = await _realEstateRepository.getCommercialList(path, "Showroom");
      var warehouse= await _realEstateRepository.getCommercialList(path, "Warehouse");
      var shop = await _realEstateRepository.getCommercialList(path, "Shop");
      var house = await _realEstateRepository.getCommercialList(path, "House");
      var plots = await _realEstateRepository.getCommercialList(path, "Plots");
      var farms = await _realEstateRepository.getCommercialList(path, "Farms");
      var basements = await _realEstateRepository.getCommercialList(path, "Basements");
      var roof = await _realEstateRepository.getCommercialList(path, "Roof");
      var office = await _realEstateRepository.getCommercialList(path, "Office");
      var appartment = await _realEstateRepository.getCommercialList(path, "Appartment");
      var villa = await _realEstateRepository.getCommercialList(path, "Villa");
      if (flat != null) {
        commercialFlatList.value = [];
        commercialFlatList.value.addAll(flat);
      }
      if (showroom != null) {
        commercialShowroomList.value = [];
        commercialShowroomList.value.addAll(showroom);
      }
      if (warehouse != null) {
        commercialWarehouseList.value = [];
        commercialWarehouseList.value.addAll(warehouse);
      }
      if (shop != null) {
        commercialShopList.value = [];
        commercialShopList.value.addAll(shop);
      }
      if (house != null) {
        commercialHouseList.value = [];
        commercialHouseList.value.addAll(house);
      }
      if (plots != null) {
        commercialPlotsList.value = [];
        commercialPlotsList.value.addAll(plots);
      }
      if (farms != null) {
        commercialFarmsList.value = [];
        commercialFarmsList.value.addAll(farms);
      }
      if (basements != null) {
        commercialBasementsList.value = [];
        commercialBasementsList.value.addAll(basements);
      }
      if (roof != null) {
        commercialRoofList.value = [];
        commercialRoofList.value.addAll(roof);
      }
      if (office != null) {
        commercialOfficeList.value = [];
        commercialOfficeList.value.addAll(office);
      }
      if (appartment != null) {
        commercialApartmentList.value = [];
        commercialApartmentList.value.addAll(appartment);
      }
      if (villa != null) {
        commercialVillaList.value = [];
        commercialVillaList.value.addAll(villa);
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      commercialLoader.value = false;
    }
  }

  List<commercialPGDetail> commercialDetailsData = [];
  commercialDetails(String id) async {
    try {
      buyRentDetailLoader.value = true;
      var res = await _realEstateRepository.commercialDetails(id);
      if(res!=null){
        commercialDetailsData = [];
        commercialDetailsData.addAll(res);
      }else{
        showMessage(MessageType.success("No Data Found"));
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      buyRentDetailLoader.value = false;
    }
  }

  List<commercialPGDetail> PGListData = [];
  getPGListByFilter({food,furnished,gender,foodType,AC}) async {
    try {
      buttonLoader.value = true;
      if(location.value == null ){
        showMessage(const MessageType.info("location can not empty"));
        return;
      }
      var res = await _realEstateRepository.getPGListByFilter(food,furnished,gender,foodType,AC,location.value);
      if(res == null || res.isEmpty){
        showMessage(MessageType.error("No Data Found"));
      }else{
        PGListData = [];
        PGListData.addAll(res);
        realEstateStreamController.sink.add("successPG");
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      buttonLoader.value = false;
    }
  }

  List<commercialPGDetail> commercialListData = [];
  getCommercialListByFilter({lookingType}) async {
    try {
      buttonLoader.value = true;
      if(location.value == null ){
        showMessage(const MessageType.info("location can not empty"));
        return;
      }
      var res = await _realEstateRepository.getCommercialListByFilter(lookingType,type.value,location.value,bhk.value);
      if(res == null || res.isEmpty){
        showMessage(MessageType.error("No Data Found"));
      }else{
        commercialListData = [];
        commercialListData.addAll(res);
        realEstateStreamController.sink.add("successCommercial");
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      buttonLoader.value = false;
    }
  }

  List<commercialPGDetail> PGData = [];
  getPGData() async {
    try {
      PGLoader.value = true;
      var res = await _realEstateRepository.getPGData();
      if(res == null || res.isEmpty){
        showMessage(MessageType.error("No Data Found"));
      }else{
        PGData = [];
        PGData.addAll(res);
        // realEstateStreamController.sink.add("success");
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      PGLoader.value = false;
    }
  }

  List<commercialPGDetail> PGDetailData = [];
  ValueNotifier<bool> PGLoader = ValueNotifier(false);
  PGDetail(id) async {
    try {
      PGLoader.value = true;
      var res = await _realEstateRepository.PGDetail(id);
      if(res == null || res.isEmpty){
        showMessage(MessageType.error("No Data Found"));
      }else{
        PGDetailData = [];
        PGDetailData.addAll(res);
        // realEstateStreamController.sink.add("success");
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      PGLoader.value = false;
    }
  }

  submitRealEstate(String type,String id,String price,String mobile) async {
    try {
      var res = await _realEstateRepository.submitRealEstate(type,id,price,mobile);

    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      // showMessage(MessageType.error('$e'));
    }
  }
}
