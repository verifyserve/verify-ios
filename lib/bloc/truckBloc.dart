
import 'package:flutter/cupertino.dart';
import 'package:verify/bloc/bloc.dart';
import 'package:verify/data/model/truckIist.dart';

import '../data/repository/TruckRepositrory.dart';
import '../utils/message_handler.dart';

class TruckBloc extends Bloc{
  final TruckRepository truckRepository;
  TruckBloc(this.truckRepository);

  ValueNotifier<List<TruckList>> truckList = ValueNotifier([]);
  ValueNotifier<bool> truckLoader = ValueNotifier(false);
  Future truckListGrid() async {
    try {
      truckLoader.value = true;
      var res = await truckRepository.truckList();
      if(res!=null){
        truckList.value = [];
        truckList.value.addAll(res);
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      truckLoader.value = false;
    }
  }

  ValueNotifier<List<TruckList>> jcbList = ValueNotifier([]);
  Future jcbListGrid() async {
    try {
      truckLoader.value = true;
      var res = await truckRepository.jcbList();
      if(res!=null){
        jcbList.value = [];
        jcbList.value.addAll(res);
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      truckLoader.value = false;
    }
  }
}