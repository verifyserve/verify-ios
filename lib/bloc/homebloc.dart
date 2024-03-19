import 'package:flutter/material.dart';
import 'package:verify/bloc/bloc.dart';
import 'package:verify/data/model/homePageGrid.dart';
import 'package:verify/data/model/homeSlider.dart';
import 'package:verify/data/network/api_exception.dart';
import 'package:verify/data/repository/HomeRepository.dart';
import 'package:verify/utils/message_handler.dart';

class HomeBloc extends Bloc {
  final HomeRepository _homeRepository;
  HomeBloc(this._homeRepository);

  ValueNotifier<List<HomePageGrid>> mailList = ValueNotifier([]);
  ValueNotifier<bool> mainGridLoader = ValueNotifier(false);
  Future mainPageGrid() async {
    try {
      mainGridLoader.value = true;
      var res = await _homeRepository.mainPageGrid();
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