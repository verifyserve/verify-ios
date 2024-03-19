import 'dart:async';

import 'package:flutter/material.dart';
import 'package:verify/bloc/bloc.dart';
import 'package:verify/data/model/consultantAndLawyer.dart';
import 'package:verify/data/model/jobs.dart';
import 'package:verify/data/model/showNotification.dart';
import 'package:verify/data/repository/consultantRepository.dart';
import 'package:verify/utils/message_handler.dart';

import '../data/repository/jobsRepository.dart';
import '../data/repository/notificationRepository.dart';

class NotificationBloc extends Bloc {
  final NotificationRepository _notificationRepository;
  NotificationBloc(this._notificationRepository);

  ValueNotifier<List<ShowNotification>> showNoti = ValueNotifier([]);
  ValueNotifier<bool> sendNotiLoader = ValueNotifier(false);
  ValueNotifier<bool> showNotiLoader = ValueNotifier(false);
  Future showNotifi() async {
    try {
      showNotiLoader.value = true;
      var res = await _notificationRepository.showNotification();
      if(res!=null){
        showNoti.value = [];
        showNoti.value.addAll(res);
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      showNotiLoader.value = false;
    }
  }
  ValueNotifier<List<ShowNotification>> recentNot = ValueNotifier([]);
  Future recentNotification() async {
    try {
      showNotiLoader.value = true;
      var res = await _notificationRepository.recentNotification();
      if(res!=null){
        recentNot.value = [];
        recentNot.value.addAll(res);
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      showNotiLoader.value = false;
    }
  }

  StreamController<String> notificationStreamController = StreamController.broadcast();
  Future sendNoti({String? date,String? description,String? location,String? time,String? number,String? type}) async {
    try {
      sendNotiLoader.value = true;
      var res = await _notificationRepository.sendNotification(date: date,description: description,location: location,time: time,number: number,type: type);
      if(res!=null){
        showMessage(const MessageType.success("Your Notification Send Successfully"));
        notificationStreamController.sink.add("POPS");
      }else{
        showMessage(MessageType.error(res));
      }
      print(res);
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      sendNotiLoader.value = false;
    }
  }
}