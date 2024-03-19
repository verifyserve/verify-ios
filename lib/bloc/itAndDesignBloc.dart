import 'package:flutter/material.dart';
import 'package:verify/bloc/bloc.dart';
import 'package:verify/data/model/ItAndDesign.dart';
import 'package:verify/data/model/consultantAndLawyer.dart';
import 'package:verify/data/repository/ItAndDesignRepossitory.dart';
import 'package:verify/data/repository/ItAndDesignRepossitory.dart';
import 'package:verify/data/repository/ItAndDesignRepossitory.dart';
import 'package:verify/data/repository/ItAndDesignRepossitory.dart';
import 'package:verify/data/repository/consultantRepository.dart';
import 'package:verify/utils/message_handler.dart';

class ItAndDesignBloc extends Bloc {
  final ItAndDesignRepository _ItAndDesignRepository;
  ItAndDesignBloc(this._ItAndDesignRepository);

  ValueNotifier<List<ItDesign>> mailList = ValueNotifier([]);
  ValueNotifier<bool> mainGridLoader = ValueNotifier(false);
  Future mainPageGrid() async {
    try {
      mainGridLoader.value = true;
      var res = await _ItAndDesignRepository.mainPageGrid();
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