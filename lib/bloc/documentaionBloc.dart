import 'dart:async';

import 'package:flutter/material.dart';
import 'package:verify/UI/realEstate/real_estateList.dart';
import 'package:verify/bloc/bloc.dart';
import 'package:verify/data/model/documentaion.dart';
import 'package:verify/data/model/employeeDetail.dart';
import 'package:verify/data/model/realEstate.dart';
import 'package:verify/data/model/realestateFilter.dart';
import 'package:verify/data/model/showAddedEmployee.dart';
import 'package:verify/data/model/showAddedTenant.dart';
import 'package:verify/data/model/showEmployeeType.dart';
import 'package:verify/data/model/yourInfo.dart';
import 'package:verify/data/repository/DocumentationRepository.dart';
import 'package:verify/data/repository/RealEstateRepository.dart';
import 'package:verify/utils/message_handler.dart';

class DocumentationBloc extends Bloc {
  final DocumentationRepository _documentationRepository;
  DocumentationBloc(this._documentationRepository);

  init()async{
    await showDocument();
    // await showPropertyType();
    // await showEmployeeType();
    // await showTenant("FLAT");
    // await showTenant(showPropertyList.value.first.pname ?? "");
  }

  ValueNotifier<String> type = ValueNotifier("null");
  ValueNotifier<List<String>> status = ValueNotifier([]);
  ValueNotifier<List<String>> status2 = ValueNotifier([]);
  List<DocumentationHorizontalCategory> topList = [];
  ValueNotifier<bool> topListLoader = ValueNotifier(false);

  showDocument() async {
    print("venom");
    status.value = [];
    status.value.clear();
    var res = await _documentationRepository.showTenantProperty(property_Type: 'FLAT');
    if(res.isNotEmpty){
      status.value.add("FLAT");
    }
    var res1 = await _documentationRepository.showTenantProperty(property_Type: 'SHOP');
    if(res1.isNotEmpty){
      status.value.add("SHOP");
    }
    var res2 = await _documentationRepository.showTenantProperty(property_Type: 'SHOWROOM');
    if(res2.isNotEmpty){
      status.value.add("SHOWROOM");
    }
    var res3 = await _documentationRepository.showTenantProperty(property_Type: 'WAREHOUSE');
    if(res3.isNotEmpty){
      status.value.add("WAREHOUSE");
    }
    var res7 = await _documentationRepository.showTenantProperty(property_Type: 'FLOOR');
    if(res7.isNotEmpty){
      status.value.add("FLOOR");
    }
    var res4 = await _documentationRepository.showTenantProperty(property_Type: 'BASEMENT');
    if(res4.isNotEmpty){
      status.value.add("BASEMENT");
    }
    var res5 = await _documentationRepository.showTenantProperty(property_Type: 'ROOFS');
    if(res5.isNotEmpty){
      status.value.add("ROOFS");
    }
    var res6 = await _documentationRepository.showTenantProperty(property_Type: 'HOMES');
    if(res6.isNotEmpty){
      status.value.add("HOMES");
    }
    status.notifyListeners();
    showTenant(status.value.first);
  }

  showEmployeeData() async {
    print("venom");
    status2.value = [];
    status2.value.clear();
    var res = await _documentationRepository.showEmployee(employee_Type: 'EMPLOYEE');
    if(res.isNotEmpty){
      status2.value.add("EMPLOYEE");
    }
    var res1 = await _documentationRepository.showEmployee(employee_Type: 'SERVANT');
    if(res1.isNotEmpty){
      status2.value.add("SERVANT");
    }
    var res2 = await _documentationRepository.showEmployee(employee_Type: 'WORKER');
    if(res2.isNotEmpty){
      status2.value.add("WORKER");
    }
    var res3 = await _documentationRepository.showEmployee(employee_Type: 'CUSTOMER');
    if(res3.isNotEmpty){
      status2.value.add("CUSTOMER");
    }
    var res7 = await _documentationRepository.showEmployee(employee_Type: 'STUDENTS');
    if(res7.isNotEmpty){
      status2.value.add("STUDENTS");
    }
    status2.notifyListeners();
    showEmployee(status2.value.first);
  }

  topListList() async {
    try {
      topListLoader.value = true;
      var res = await _documentationRepository.topHorizontalCategory();
      if(res!=null){
        topList = [];
        topList.addAll(res);
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      topListLoader.value = false;
    }
  }

  StreamController<String> DocumentationStream = StreamController.broadcast();

  addPropertyType(name) async {
    try {
      if(name == ""){
        showMessage(MessageType.info("Field is required!"));
        return ;
      }
      topListLoader.value = true;
      var res = await _documentationRepository.addPropertyType(
        name: name
      );
      // if(res == "Successfully Added"){
      //   print("object");
      //   DocumentationStream.sink.add("POP");
      // }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      topListLoader.value = false;
    }
  }

  ValueNotifier<List<ShowEmployeeType>> showPropertyList = ValueNotifier([]);
  ValueNotifier<int?> showPropertyIndex = ValueNotifier(0);
  showPropertyType() async {
    try {
      topListLoader.value = true;
      var res = await _documentationRepository.showPropertyType();
      if(res != null){
        showPropertyList.value.clear();
        showPropertyList.value.addAll(res);
        showPropertyIndex.value = 0;
        if(showPropertyList.value.isNotEmpty){
          type.value = showPropertyList.value.first.pname ?? "";
        }
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      topListLoader.value = false;
    }
  }

  addTenant({required String email,required String
  AboutTanent,required String
  Address,required String
  date,required String
  floorno,required String
  hometown,required String
  Number,required String
  propetrytype,required String
  rent,required String
  state,required String
  Tanentname,}) async {
    try {
      topListLoader.value = true;
      var res = await _documentationRepository.addTenantProperty(
          email: email,
          AboutTanent: AboutTanent,
          Address: Address,
          date: date,
          floorno: floorno,
          hometown: hometown,
          Number: Number,
          // PropertyImg: PropertyImg,
          propetrytype: propetrytype,
          rent: rent,
          state: state,
          // TanentImg: TanentImg,
          Tanentname: Tanentname
      );
      if(res == "Successfully Added"){
        print("object");
        showMessage(const MessageType.success("Successfully Added"));
        DocumentationStream.sink.add("POP");
        DocumentationStream.sink.add("POP");
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      topListLoader.value = false;
      showDocument();
    }
  }

  List<ShowTenant> tenantList = [];
  ValueNotifier<bool> tenantLoader = ValueNotifier(false);
  showTenant(type) async {
    try {
      tenantLoader.value = true;
      var res = await _documentationRepository.showTenantProperty(property_Type: type);
      if(res != null || res.isNotEmpty){
        // status.value.add(type);
        tenantList.clear();
        tenantList.addAll(res);
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      tenantLoader.value = false;
    }
  }

  addEmployeeType(name) async {
    try {
      if(name == ""){
        showMessage(MessageType.info("Field is required!"));
        return ;
      }
      topListLoader.value = true;
      var res = await _documentationRepository.addEmployeeType(
          name: name
      );
      // if(res == "Successfully Added"){
      //   DocumentationStream.sink.add("POP");
      // }

    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      topListLoader.value = false;
    }
  }

  ValueNotifier<List<ShowEmployeeType>> showEmployeeLists = ValueNotifier([]);
  ValueNotifier<int?> showEmployeeIndex = ValueNotifier(null);
  showEmployeeType() async {
    try {
      topListLoader.value = true;
      var res = await _documentationRepository.showEmployeeType();
      if(res != null){
        showEmployeeLists.value.clear();
        showEmployeeLists.value.addAll(res);
        print("objectas ${showEmployeeLists.value.length}");
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      topListLoader.value = false;
    }
  }

  addEmployee({required String Employee_work,
    required String Employee_address,
    required String Employee_name,
    required String date,
    required String Employee_salary,
    required String Employee_about,
    required String Employee_Mobile,
    required String Employee_email,required String type}) async {
    try {
      topListLoader.value = true;
      var res = await _documentationRepository.addEmployee(
         Employee_about:Employee_about,
        Employee_address:Employee_address,
        Employee_email:Employee_email,
        Employee_joiningdate:date,
        Employee_Mobile:Employee_Mobile,
        Employee_name:Employee_name,
        Employee_salary:Employee_salary,
        Employee_work:Employee_work,
         Employee_Type:type,
      );
      if(res == "Successfully Added"){
        print("object");
        showMessage(const MessageType.success("Successfully Added"));
        DocumentationStream.sink.add("POP");
        DocumentationStream.sink.add("POP");
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      topListLoader.value = false;
      showEmployeeData();
    }
  }

  List<ShowAddedEmployee> employeeList = [];
  ValueNotifier<bool> employeeLoader = ValueNotifier(false);
  showEmployee(type) async {
    try {
      employeeLoader.value = true;
      var res = await _documentationRepository.showEmployee(employee_Type: type);
      if(res != null){
        employeeList.clear();
        employeeList.addAll(res);
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      employeeLoader.value = false;
    }
  }

  List<EmployeeDetail> employeeDetail = [];
  showEmployeeDetail(id) async {
    try {
      employeeLoader.value = true;
      var res = await _documentationRepository.showEmployeeDetail(id: id);
      if(res != null){
        employeeDetail.clear();
        employeeDetail.addAll(res);
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      employeeLoader.value = false;
    }
  }

  ValueNotifier<List<YourInfo>> yourInfoData = ValueNotifier([]);
  ValueNotifier<bool> yourInfoLoader = ValueNotifier(false);
  yourInfo(id) async {
    try {
      employeeLoader.value = true;
      var res = await _documentationRepository.yourInfo(id: id);
      if(res != null){
        yourInfoData.value = [];
        yourInfoData.value.addAll(res);
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      showMessage(MessageType.error('$e'));
    }finally{
      employeeLoader.value = false;
    }
  }
}