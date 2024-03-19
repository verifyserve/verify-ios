import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verify/bloc/bloc.dart';
import 'package:verify/data/model/loginUser.dart';
import 'package:verify/data/repository/AuthRepository.dart';
import 'package:verify/utils/message_handler.dart';

class AuthBloc extends Bloc {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository);

  ValueNotifier<bool> loginLoader = ValueNotifier(false);
  ValueNotifier<bool> registerLoader = ValueNotifier(false);
  ValueNotifier<bool> passShow = ValueNotifier(true);
  TextEditingController mobileController = TextEditingController();
  TextEditingController passController = TextEditingController();
  StreamController<String> loginStreamController = StreamController.broadcast();

  Future login() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      loginLoader.value = true;
      if(mobileController.text.isEmpty){
        showMessage(MessageType.info("Please enter Mobile Number"));
        return ;
      }
      if(passController.text.isEmpty){
        showMessage(MessageType.info("Please enter Password"));
        return ;
      }
      var res = await _authRepository.login(email: mobileController.text,pass: passController.text);
      if(res.first.vvid != null){
          // pref.setString("isLogin", "true");
          pref.setString('id', "${res.first.vvid}");
          pref.setString('email', "${res.first.vemail}");
          pref.setString('phone', '${res.first.vmobile}');
          pref.setString('name', '${res.first.vname}');
          pref.setString('vehicleNo', "${res.first.vechicleNo}");
          pref.setString('location', "${res.first.locationhai}");
          pref.setString('Token_no', "${res.first.Token}");
          print("id: ${pref.getString('id')}, email: ${pref.getString('email')}, phone ${pref.getString('phone')},vehicleNo ${res.first.vechicleNo} ,location ${res.first.locationhai},Token_no ${res.first.Token}");
          loginStreamController.sink.add("success");
      }
      // else{
    // showMessage(MessageType.error("Either email or password is incorrect"));
    //   }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('Either email or password is incorrect'));
    }finally{
      loginLoader.value = false;
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerPassController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController vehicleController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController tokenController = TextEditingController();


  Future register() async {
    try {
      registerLoader.value = true;
      if(nameController.text.isEmpty){
        showMessage(MessageType.info("Please enter name"));
        return ;
      }
      if(registerEmailController.text.isEmpty){
        showMessage(MessageType.info("Please enter Email"));
        return ;
      }
      if(numberController.text.isEmpty){
        showMessage(MessageType.info("Please enter phone number"));
        return ;
      }
      if(registerPassController.text.isEmpty){
        showMessage(MessageType.info("Please enter Password"));
        return ;
      }
      var res = await _authRepository.register(email: registerEmailController.text,pass: registerPassController.text,name: nameController.text,number: numberController.text,vehicle: vehicleController.text,location: locationController.text,token: tokenController.text);
      if(res!=null){
        if(res == "Successfully Registered"){
          showMessage(MessageType.success("Registered Successfully"));
          // pref.setString("isLogin", "true");
          loginStreamController.sink.add("Register");
        }
      }else{
        showMessage(MessageType.error(res));
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      registerLoader.value = false;
    }
  }

  List<loginUser> profiles = [];
  Future profile() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      loginLoader.value = true;
      var res = await _authRepository.profile(email: pref.getString("email"));
      if(res!=null){
        profiles.clear();
        profiles.addAll(res);
      }

    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      loginLoader.value = false;
    }
  }
}