import 'package:flutter/material.dart';
import 'package:verify/bloc/bloc.dart';
import 'package:verify/data/model/consultantAndLawyer.dart';
import 'package:verify/data/repository/consultantRepository.dart';
import 'package:verify/utils/message_handler.dart';

class ConsultantBloc extends Bloc {
  final ConsultantRepository _consultantRepository;
  ConsultantBloc(this._consultantRepository);

  ValueNotifier<List<ConsultantAndLawyer>> mailList = ValueNotifier([]);
  ValueNotifier<bool> mainGridLoader = ValueNotifier(false);
  Future mainPageGrid() async {
    try {
      mainGridLoader.value = true;
      var res = await _consultantRepository.mainPageGrid();
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