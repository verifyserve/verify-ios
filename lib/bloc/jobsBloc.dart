import 'package:flutter/material.dart';
import 'package:verify/bloc/bloc.dart';
import 'package:verify/data/model/consultantAndLawyer.dart';
import 'package:verify/data/model/jobImageSlider.dart';
import 'package:verify/data/model/jobs.dart';
import 'package:verify/data/repository/consultantRepository.dart';
import 'package:verify/utils/message_handler.dart';

import '../data/repository/jobsRepository.dart';

class JobsBloc extends Bloc {
  final JobsRepository _jobsRepository;
  JobsBloc(this._jobsRepository);

  ValueNotifier<List<Jobs>> mailList = ValueNotifier([]);
  ValueNotifier<bool> mainGridLoader = ValueNotifier(false);

  init() async {
    try {
      mainGridLoader.value = true;

    } catch (e) {
      print(e);
    } finally {
      mainGridLoader.value = false;
    }
  }

  Future mainPageGrid() async {
    try {
      mainGridLoader.value = true;
      var res = await _jobsRepository.mainPageGrid();
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