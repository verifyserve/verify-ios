
import 'package:flutter/cupertino.dart';
import 'package:verify/bloc/bloc.dart';
import 'package:verify/data/model/hotelList.dart';

import '../data/model/hotelImageSlider.dart';
import '../data/repository/HotelRepository.dart';
import '../utils/message_handler.dart';

class HotelBloc extends Bloc{
  final HotelRepository hotelRepository;
  HotelBloc(this.hotelRepository);

  ValueNotifier<List<HotelList>> hotelList = ValueNotifier([]);
  ValueNotifier<bool> hotelLoader = ValueNotifier(false);
  Future hotelListGrid() async {
    try {
      hotelLoader.value = true;
      var res = await hotelRepository.hotelList();
      if(res!=null){
        hotelList.value = [];
        hotelList.value.addAll(res);
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      hotelLoader.value = false;
    }
  }
  List<HotelImageSlider> hotelImageList = [];
  Future hotelImageListGrid() async {
    try {
      hotelLoader.value = true;
      var res = await hotelRepository.hotelImageList();
      if(res!=null){
        hotelImageList= [];
        hotelImageList.addAll(res);
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      hotelLoader.value = false;
    }
  }

  init() async {
    try {
      hotelLoader.value = true;
      await hotelListGrid();
      await hotelImageListGrid();
    } catch (e) {
      print(e);
    } finally {
      hotelLoader.value = false;
    }
  }

}