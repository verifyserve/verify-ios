import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:verify/data/model/documentaion.dart';
import 'package:verify/data/model/employeeDetail.dart';
import 'package:verify/data/model/showAddedEmployee.dart';
import 'package:verify/data/model/showAddedTenant.dart';
import 'package:verify/data/model/showEmployeeType.dart';
import 'package:verify/data/model/yourInfo.dart';
import 'package:verify/data/network/api_service.dart';

class DocumentationRepository {

  final SharedPreferences prefs;
  final ApiService _api;

  DocumentationRepository(this.prefs, this._api);

  Future<List<DocumentationHorizontalCategory>> topHorizontalCategory() async{
    String url = "http://www.verifyserve.social/WebService1.asmx/DOcumentationTopcat";
    var res = await _api.getRequest(url);
    var resData = jsonDecode(res);
    return List.from(resData.map((e) => DocumentationHorizontalCategory.fromJson(e)));
  }

  Future addPropertyType({required name}) async{
    String url = "http://www.verifyserve.social/WebService1.asmx/AddDOcumentationTopproperty";
    Map<String,dynamic> data = {
      "Name":name,
      "id":prefs.getString('id'),
    };
    var res = await _api.getRequest(url,data: data);
    // var resData = jsonDecode(res);
    return res;
  }

  Future<List<ShowEmployeeType>> showPropertyType() async{
    String url = "http://www.verifyserve.social/WebService1.asmx/ShowPropertyType_byid";
    Map<String,dynamic> data = {
      "id":prefs.getString('id'),
    };
    var res = await _api.getRequest(url,data: data);
    var resData = jsonDecode(res);
    return List.from(resData.map((e) => ShowEmployeeType.fromJson(e)));
  }

  Future addTenantProperty({required Address,required floorno,required state,required Tanentname,required date,required rent,required propetrytype,required AboutTanent,required Number,required email,required hometown,}) async{
    String url = "http://www.verifyserve.social/WebService1.asmx/Property_tanent";
    print("user id: ${prefs.getString('id')}");
    Map<String,dynamic> data = {
      // "PropertyImg ":PropertyImg,
      "Addres":Address,
      "floorno":floorno,
      "state":state,
      // "TanentImg ":TanentImg,
      "Tanentname":Tanentname,
      "date":date,
      "rent":rent,
      "subid": prefs.getString('id').toString(),
      "propetrytype":propetrytype,
      "AboutTanent":AboutTanent,
      "Number":Number,
      "email":email,
      "hometown":hometown,
    };
    print("$state $Tanentname $Address $floorno $date $rent $propetrytype $AboutTanent $Number $email $hometown");
    // print(TanentImg);
    var res = await _api.getRequest(url,data:data);
    // var resData = jsonDecode(res);
    return res;
  }

  Future<List<ShowTenant>> showTenantProperty({required property_Type}) async{
    //String url = "http://www.verifyserve.social/WebService1.asmx/ShowAddedProperty";
    String url = "https://verifyserve.social/WebService2.asmx/Show_Property_Documaintation2";
    Map<String,dynamic> data = {
      "property_type":property_Type,
      "number":prefs.getString('id'),
    };
    var res = await _api.getRequest(url,data: data);
    var resData = jsonDecode(res);
    return List.from(resData.map((e) => ShowTenant.fromJson(e)));
  }

  Future addEmployeeType({required name}) async{
    String url = "http://www.verifyserve.social/WebService1.asmx/AddDOcumentationTop_Employee";
    Map<String,dynamic> data = {
      "Name":name,
      "id":prefs.getString('id'),
    };
    var res = await _api.getRequest(url,data: data);
    // var resData = jsonDecode(res);
    return res;
  }

  Future<List<ShowEmployeeType>> showEmployeeType() async{
    String url = "http://www.verifyserve.social/WebService1.asmx/ShowEmployeeType_byid";
    Map<String,dynamic> data = {
      "id":prefs.getString('id'),
    };
    var res = await _api.getRequest(url,data: data);
    var resData = jsonDecode(res);
    return List.from(resData.map((e) => ShowEmployeeType.fromJson(e)));
  }

  Future addEmployee({required Employee_name,required Employee_joiningdate,required Employee_salary,required Employee_work,required Employee_about, required Employee_Mobile,required Employee_email,required Employee_address,required Employee_Type}) async{
    String url = "http://www.verifyserve.social/WebService1.asmx/Employee_MainList";
    Map<String,dynamic> data = {
    // "EmployeeImg": EmployeeImg,
    "Employee_name":Employee_name,
    "Employee_joiningdate":Employee_joiningdate,
    "Employee_salary":Employee_salary,
    "Employee_work":Employee_work,
    "Employee_about":Employee_about,
    "Employee_Mobile":Employee_Mobile,
    "Employee_email":Employee_email,
    "Employee_address":Employee_address,
    "Employee_userid":prefs.getString('id'),
    "Employee_Type":Employee_Type,
    };
    print("$Employee_name $Employee_joiningdate $Employee_salary $Employee_work $Employee_about $Employee_Mobile $Employee_email $Employee_address $Employee_Type ${prefs.getString('id')}");
    var res = await _api.getRequest(url,data: data);
    // var resData = jsonDecode(res);
    return res;
  }

  Future<List<ShowAddedEmployee>> showEmployee({required employee_Type}) async{
    String url = "http://www.verifyserve.social/WebService1.asmx/ShowAddedEmployee_";
    Map<String,dynamic> data = {
      "employee_Type":employee_Type,
      "id":prefs.getString('id'),
    };
    var res = await _api.getRequest(url,data: data);
    var resData = jsonDecode(res);
    return List.from(resData.map((e) => ShowAddedEmployee.fromJson(e)));
  }

  Future<List<EmployeeDetail>> showEmployeeDetail({required id}) async{
    String url = "http://www.verifyserve.social/WebService1.asmx/ShowEmployeedetails_byid";
    Map<String,dynamic> data = {
      "id":id,
    };
    var res = await _api.getRequest(url,data: data);
    var resData = jsonDecode(res);
    return List.from(resData.map((e) => EmployeeDetail.fromJson(e)));
  }

  Future<List<YourInfo>> yourInfo({required id}) async{
    String url = "http://www.verifyserve.social/WebService1.asmx/ShowAddedProperty_documet";
    Map<String,dynamic> data = {
      "id":id,
    };
    var res = await _api.getRequest(url,data: data);
    var resData = jsonDecode(res);
    return List.from(resData.map((e) => YourInfo.fromJson(e)));
  }
}