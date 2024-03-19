import 'package:flutter/material.dart';
import 'package:verify/bloc/bloc.dart';
import 'package:verify/data/model/consultantAndLawyer.dart';
import 'package:verify/data/model/eventsAndWedding.dart';
import 'package:verify/data/repository/consultantRepository.dart';
import 'package:verify/data/repository/eventsAndWeddingRepository.dart';
import 'package:verify/utils/message_handler.dart';

class EventsAndWeddingBloc extends Bloc {
  final EventsAndWeddingRepository _eventsAndWeddingRepository;
  EventsAndWeddingBloc(this._eventsAndWeddingRepository);

  ValueNotifier<List<EventsAndWedding>> mailList = ValueNotifier([]);
  ValueNotifier<bool> mainGridLoader = ValueNotifier(false);
  Future mainPageGrid() async {
    try {
      mainGridLoader.value = true;
      var res = await _eventsAndWeddingRepository.mainPageGrid();
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
}