import 'dart:async';

import 'package:flutter/material.dart';
import 'package:verify/bloc/bloc.dart';
import 'package:verify/data/model/services.dart';
import 'package:verify/data/repository/servicesRepository.dart';
import 'package:verify/utils/message_handler.dart';

import '../data/model/subService.dart';

class ServiceBloc extends Bloc {
  final ServiceRepository _serviceRepository;
  ServiceBloc(this._serviceRepository);

  ValueNotifier<List<Service>> mailList = ValueNotifier([]);
  ValueNotifier<bool> mainGridLoader = ValueNotifier(false);
  Future mainPageGrid() async {
    try {
      mainGridLoader.value = true;
      var res = await _serviceRepository.mainPageGrid();
      if(res!=null){
        mailList.value = [];
        mailList.value.addAll(res);
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      mainGridLoader.value = false;
    }
  }


  StreamController<String> serviceStreamController = StreamController.broadcast();
  Future addSlot({String? time, String? day,String? tittle, String? Address,String? Location, String? Longitude,String? Latitude,String? Type_of_requirement,String? customer_name,String? booking_time,String? customer_number}) async {
    try {
      mainGridLoader.value = true;

      var res = await _serviceRepository.bookSlot(time:time,day:day,tittle:tittle,Address:Address,Location:Location,Longitude:Longitude,Latitude:Latitude,Type_of_requirement:Type_of_requirement,customer_name: customer_name,booking_time: booking_time,customer_number: customer_number);
      if(res!=null){
        showMessage(const MessageType.success("Your Request Send Successfully"));
        serviceStreamController.sink.add("POPS");
      }else{
        showMessage(MessageType.error(res));
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      mainGridLoader.value = false;
    }
  }

  ValueNotifier<List<SubService>> subSer = ValueNotifier([]);
  Future subService(id) async {
    try {
      mainGridLoader.value = true;
      var res = await _serviceRepository.subService(id);
      if(res!=null){
        subSer.value = [];
        subSer.value.addAll(res);
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      mainGridLoader.value = false;
    }
  }

  List<SubService> subDe = [];
  subDetails(int? id) async {
    try {
      mainGridLoader.value = true;
      var res = await _serviceRepository.subDetails(id!);
      if(res != null){
        subDe.clear();
        subDe.addAll(res);
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      mainGridLoader.value = false;
    }
  }


}