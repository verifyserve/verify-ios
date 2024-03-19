import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class aaaa {
  //final int id;
  final String owner_name;
  final String vehicle_no;
  final String ownership;
  final String model_name;
  final String gen;
  final String insurance_exp;
  final String logo;
  final String regi_date;
  final String regi_rto;
  final String maker_model;
  final String vechicle_class;
  final String fule_type;
  final String fuel_norms;
  final String engine_no;
  final String chassis_no;
  final String vechicle_age;
  final String pollution_upto;
  final String pcu_exp;
  final String insurance_expin;
  final String color;
  final String unloaded_weight;
  final String rc_status;

  aaaa(
      {required this.owner_name, required this.vehicle_no, required this.ownership, required this.model_name,
        required this.gen, required this.insurance_exp, required this.logo, required this.regi_date,
        required this.regi_rto, required this.maker_model, required this.vechicle_class, required this.fule_type,
        required this.fuel_norms, required this.engine_no, required this.chassis_no, required this.vechicle_age,
        required this.pollution_upto, required this.pcu_exp, required this.insurance_expin, required this.color,
        required this.unloaded_weight, required this.rc_status});

  factory aaaa.FromJson(Map<String, dynamic>json){
    return aaaa(owner_name: json['owner_name'],
        vehicle_no: json['vehicle_no'],
        ownership: json['ownership'],
        model_name: json['model_name'],
        gen: json['gen'],
        insurance_exp: json['insurance_exp'],
        logo: json['logo'],
        regi_date: json['regi_date'],
        regi_rto: json['regi_rto'],
        maker_model: json['maker_model'],
        vechicle_class: json['vechicle_class'],
        fule_type: json['fule_type'],
        fuel_norms: json['fuel_norms'],
        engine_no: json['engine_no'],
        chassis_no: json['chassis_no'],
        vechicle_age: json['vechicle_age'],
        pollution_upto: json['pollution_upto'],
        pcu_exp: json['pcu_exp'],
        insurance_expin: json['insurance_expin'],
        color: json['color'],
        unloaded_weight: json['unloaded_weight'],
        rc_status: json['rc_status']);
  }
}



class InsuranceForm extends StatefulWidget {
  const InsuranceForm({super.key});

  @override
  State<InsuranceForm> createState() => _InsuranceFormState();
}

class _InsuranceFormState extends State<InsuranceForm> {

  Future<List<aaaa>> fetchData() async {
    var url = Uri.parse('https://verifyserve.social/WebService1.asmx/ShowVehicleSearch?vehicle_number=DL11ST2228');
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      List listresponce = json.decode(responce.body);
      return listresponce.map((data) => aaaa.FromJson(data)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  @override
  void initState() {
    super.initState();
    _loaduserdata();
  }

  String data = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Image.asset('assets/images/verify.png', height: 55),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Row(
            children: [
              SizedBox(
                width: 3,
              ),
              Icon(
                PhosphorIcons.caret_left_bold,
                color: Colors.white,
                size: 30,
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15,right: 15,top: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Expanded(
                child: FutureBuilder<List<aaaa>>(
                    future: fetchData(),
                    builder: (context,abc) {
                      return ListView.builder(
                        //itemCount: abc.data!.length,
                          itemCount: 1,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context,int len) {
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(abc.data![len].owner_name,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),),
                                        SizedBox(height: 3,),
                                        Row(
                                          children: [
                                            Text(abc.data![len].vehicle_no,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),),
                                            SizedBox(width: 10,),
                                            Text(abc.data![len].ownership,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),),
                                          ],
                                        ),
                                        SizedBox(height: 5,),
                                        Row(
                                          children: [
                                            Text(abc.data![len].model_name,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),),
                                            SizedBox(width: 10,),
                                            Text(abc.data![len].gen,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Container(
                                      child: Image(image: AssetImage('assets/images/horse.jpeg'),height: 70,width: 70,),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Container(
                                  padding: EdgeInsets.only(left: 10,right: 0,top: 0,bottom: 0),
                                  decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child:  Row(
                                    children: [
                                      Text('Insurance expiry:  '+abc.data![len].insurance_exp,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),),
                                      Spacer(),
                                      InkWell(
                                        onTap: (){
                                          Fluttertoast.showToast(
                                              msg: "Set Reminder",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.grey,
                                              textColor: Colors.white,
                                              fontSize: 14.0
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: Colors.white,
                                            border: Border.all(width: 1, color: Colors.black),
                                          ),
                                          child:  Text('Set Reminder',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }
                      );
                    }
                ),
              ),
            ),
            SizedBox(height: 20,),
            Text('RC DETAILS',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
            SizedBox(height: 10,),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Ownership Details',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,color: Colors.blueGrey,fontFamily: 'Poppins',letterSpacing: 0),),
                          SizedBox(height: 10,),
                          Container(
                            padding: EdgeInsets.only(left: 10,right: 10),
                            child: Column(
                              children: [
                                TextFormField(
                                  initialValue: 'Naman Raj',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),
                                  readOnly: true,
                                  toolbarOptions: ToolbarOptions(
                                    copy: false,
                                    paste: false,
                                    cut: false,
                                    selectAll: false,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Owner Name',
                                    labelStyle: TextStyle(
                                        fontSize: 15,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0
                                    ),
                                    // enabledBorder: UnderlineInputBorder(
                                    //   borderSide: BorderSide(color: Color(0xFF6200EE)),
                                    // ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  initialValue: 'First Owner',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),
                                  readOnly: true,
                                  toolbarOptions: ToolbarOptions(
                                    copy: false,
                                    paste: false,
                                    cut: false,
                                    selectAll: false,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Ownership',
                                    labelStyle: TextStyle(
                                        fontSize: 15,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0
                                    ),
                                    // enabledBorder: UnderlineInputBorder(
                                    //   borderSide: BorderSide(color: Color(0xFF6200EE)),
                                    // ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  initialValue: '16-Oct-2017',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),
                                  readOnly: true,
                                  toolbarOptions: ToolbarOptions(
                                    copy: false,
                                    paste: false,
                                    cut: false,
                                    selectAll: false,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Registration Date',
                                    labelStyle: TextStyle(
                                        fontSize: 15,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0
                                    ),
                                    // enabledBorder: UnderlineInputBorder(
                                    //   borderSide: BorderSide(color: Color(0xFF6200EE)),
                                    // ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  initialValue: 'ROHINI, Delhi',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),
                                  readOnly: true,
                                  toolbarOptions: ToolbarOptions(
                                    copy: false,
                                    paste: false,
                                    cut: false,
                                    selectAll: false,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Registered RTO',
                                    labelStyle: TextStyle(
                                        fontSize: 15,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0
                                    ),
                                    // enabledBorder: UnderlineInputBorder(
                                    //   borderSide: BorderSide(color: Color(0xFF6200EE)),
                                    // ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Vehicle Details',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,color: Colors.blueGrey,fontFamily: 'Poppins',letterSpacing: 0),),
                          SizedBox(height: 10,),
                          Container(
                            padding: EdgeInsets.only(left: 10,right: 10),
                            child: Column(
                              children: [
                                TextFormField(
                                  initialValue: 'TVS MOTOR COMPANY LTD, TVS VICTOR',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),
                                  readOnly: true,
                                  toolbarOptions: ToolbarOptions(
                                    copy: false,
                                    paste: false,
                                    cut: false,
                                    selectAll: false,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Maker Model',
                                    labelStyle: TextStyle(
                                        fontSize: 15,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0
                                    ),
                                    // enabledBorder: UnderlineInputBorder(
                                    //   borderSide: BorderSide(color: Color(0xFF6200EE)),
                                    // ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  initialValue: 'M-Cycle/Scooter(2WN)',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),
                                  readOnly: true,
                                  toolbarOptions: ToolbarOptions(
                                    copy: false,
                                    paste: false,
                                    cut: false,
                                    selectAll: false,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Vehicle Class',
                                    labelStyle: TextStyle(
                                        fontSize: 15,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0
                                    ),
                                    // enabledBorder: UnderlineInputBorder(
                                    //   borderSide: BorderSide(color: Color(0xFF6200EE)),
                                    // ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  initialValue: 'Petrol',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),
                                  readOnly: true,
                                  toolbarOptions: ToolbarOptions(
                                    copy: false,
                                    paste: false,
                                    cut: false,
                                    selectAll: false,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Fuel Type',
                                    labelStyle: TextStyle(
                                        fontSize: 15,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0
                                    ),
                                    // enabledBorder: UnderlineInputBorder(
                                    //   borderSide: BorderSide(color: Color(0xFF6200EE)),
                                    // ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  initialValue: 'BHARAT STAFE IV',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),
                                  readOnly: true,
                                  toolbarOptions: ToolbarOptions(
                                    copy: false,
                                    paste: false,
                                    cut: false,
                                    selectAll: false,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Fuel Norms',
                                    labelStyle: TextStyle(
                                        fontSize: 15,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0
                                    ),
                                    // enabledBorder: UnderlineInputBorder(
                                    //   borderSide: BorderSide(color: Color(0xFF6200EE)),
                                    // ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  initialValue: 'GF1HH16XXXXX',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),
                                  readOnly: true,
                                  toolbarOptions: ToolbarOptions(
                                    copy: false,
                                    paste: false,
                                    cut: false,
                                    selectAll: false,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Engine No',
                                    labelStyle: TextStyle(
                                        fontSize: 15,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0
                                    ),
                                    // enabledBorder: UnderlineInputBorder(
                                    //   borderSide: BorderSide(color: Color(0xFF6200EE)),
                                    // ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  initialValue: 'MD625GF1XH1HXXXXX',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),
                                  readOnly: true,
                                  toolbarOptions: ToolbarOptions(
                                    copy: false,
                                    paste: false,
                                    cut: false,
                                    selectAll: false,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Chassis No',
                                    labelStyle: TextStyle(
                                        fontSize: 15,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0
                                    ),
                                    // enabledBorder: UnderlineInputBorder(
                                    //   borderSide: BorderSide(color: Color(0xFF6200EE)),
                                    // ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Important Dates',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,color: Colors.blueGrey,fontFamily: 'Poppins',letterSpacing: 0),),
                          SizedBox(height: 10,),
                          Container(
                            padding: EdgeInsets.only(left: 10,right: 10),
                            child: Column(
                              children: [
                                TextFormField(
                                  initialValue: '16-Oct-2017',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),
                                  readOnly: true,
                                  toolbarOptions: ToolbarOptions(
                                    copy: false,
                                    paste: false,
                                    cut: false,
                                    selectAll: false,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Registration Date',
                                    labelStyle: TextStyle(
                                        fontSize: 15,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0
                                    ),
                                    // enabledBorder: UnderlineInputBorder(
                                    //   borderSide: BorderSide(color: Color(0xFF6200EE)),
                                    // ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  initialValue: '6 years & 0 month',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),
                                  readOnly: true,
                                  toolbarOptions: ToolbarOptions(
                                    copy: false,
                                    paste: false,
                                    cut: false,
                                    selectAll: false,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Vehicle Age',
                                    labelStyle: TextStyle(
                                        fontSize: 15,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0
                                    ),
                                    // enabledBorder: UnderlineInputBorder(
                                    //   borderSide: BorderSide(color: Color(0xFF6200EE)),
                                    // ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  initialValue: '15-Oct-2032',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),
                                  readOnly: true,
                                  toolbarOptions: ToolbarOptions(
                                    copy: false,
                                    paste: false,
                                    cut: false,
                                    selectAll: false,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Fitness Upto',
                                    labelStyle: TextStyle(
                                        fontSize: 15,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0
                                    ),
                                    // enabledBorder: UnderlineInputBorder(
                                    //   borderSide: BorderSide(color: Color(0xFF6200EE)),
                                    // ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  initialValue: '06-Jan-2024',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),
                                  readOnly: true,
                                  toolbarOptions: ToolbarOptions(
                                    copy: false,
                                    paste: false,
                                    cut: false,
                                    selectAll: false,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Pollution Upto',
                                    labelStyle: TextStyle(
                                        fontSize: 15,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0
                                    ),
                                    // enabledBorder: UnderlineInputBorder(
                                    //   borderSide: BorderSide(color: Color(0xFF6200EE)),
                                    // ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  initialValue: '2 months & 11 days',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),
                                  readOnly: true,
                                  toolbarOptions: ToolbarOptions(
                                    copy: false,
                                    paste: false,
                                    cut: false,
                                    selectAll: false,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'PCU Expiring',
                                    labelStyle: TextStyle(
                                        fontSize: 15,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0
                                    ),
                                    // enabledBorder: UnderlineInputBorder(
                                    //   borderSide: BorderSide(color: Color(0xFF6200EE)),
                                    // ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  initialValue: '12-Oct-2024',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),
                                  readOnly: true,
                                  toolbarOptions: ToolbarOptions(
                                    copy: false,
                                    paste: false,
                                    cut: false,
                                    selectAll: false,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Insurance Expiry',
                                    labelStyle: TextStyle(
                                        fontSize: 15,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0
                                    ),
                                    // enabledBorder: UnderlineInputBorder(
                                    //   borderSide: BorderSide(color: Color(0xFF6200EE)),
                                    // ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  initialValue: '11 months & 16 days',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),
                                  readOnly: true,
                                  toolbarOptions: ToolbarOptions(
                                    copy: false,
                                    paste: false,
                                    cut: false,
                                    selectAll: false,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Insurance Expiring in',
                                    labelStyle: TextStyle(
                                        fontSize: 15,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0
                                    ),
                                    // enabledBorder: UnderlineInputBorder(
                                    //   borderSide: BorderSide(color: Color(0xFF6200EE)),
                                    // ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Other Info',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,color: Colors.blueGrey,fontFamily: 'Poppins',letterSpacing: 0),),
                          SizedBox(height: 10,),
                          Container(
                            padding: EdgeInsets.only(left: 10,right: 10),
                            child: Column(
                              children: [
                                TextFormField(
                                  initialValue: 'DL11ST2228',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),
                                  readOnly: true,
                                  toolbarOptions: ToolbarOptions(
                                    copy: false,
                                    paste: false,
                                    cut: false,
                                    selectAll: false,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Registration No',
                                    labelStyle: TextStyle(
                                        fontSize: 15,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0
                                    ),
                                    // enabledBorder: UnderlineInputBorder(
                                    //   borderSide: BorderSide(color: Color(0xFF6200EE)),
                                    // ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  initialValue: 'Sky Blue',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),
                                  readOnly: true,
                                  toolbarOptions: ToolbarOptions(
                                    copy: false,
                                    paste: false,
                                    cut: false,
                                    selectAll: false,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Color',
                                    labelStyle: TextStyle(
                                        fontSize: 15,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0
                                    ),
                                    // enabledBorder: UnderlineInputBorder(
                                    //   borderSide: BorderSide(color: Color(0xFF6200EE)),
                                    // ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  initialValue: '113',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),
                                  readOnly: true,
                                  toolbarOptions: ToolbarOptions(
                                    copy: false,
                                    paste: false,
                                    cut: false,
                                    selectAll: false,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Unloaded Weight (Kg)',
                                    labelStyle: TextStyle(
                                        fontSize: 15,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0
                                    ),
                                    // enabledBorder: UnderlineInputBorder(
                                    //   borderSide: BorderSide(color: Color(0xFF6200EE)),
                                    // ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  initialValue: 'Active',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),
                                  readOnly: true,
                                  toolbarOptions: ToolbarOptions(
                                    copy: false,
                                    paste: false,
                                    cut: false,
                                    selectAll: false,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'RC Status',
                                    labelStyle: TextStyle(
                                        fontSize: 15,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0
                                    ),
                                    // enabledBorder: UnderlineInputBorder(
                                    //   borderSide: BorderSide(color: Color(0xFF6200EE)),
                                    // ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('You are insured',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,color: Colors.blueGrey,fontFamily: 'Poppins',letterSpacing: 0),),
                              Spacer(),
                              Container(
                                child: Image(image: AssetImage('assets/images/insure.png'),height: 100,width: 100,),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10,right: 10),
                            child: Column(
                              children: [
                                TextFormField(
                                  initialValue: 'Bajaj Allianz General Insurance Co.Ltd.',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),
                                  readOnly: true,
                                  toolbarOptions: ToolbarOptions(
                                    copy: false,
                                    paste: false,
                                    cut: false,
                                    selectAll: false,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Insurer Name',
                                    labelStyle: TextStyle(
                                        fontSize: 15,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0
                                    ),
                                    // enabledBorder: UnderlineInputBorder(
                                    //   borderSide: BorderSide(color: Color(0xFF6200EE)),
                                    // ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  initialValue: '12-Oct-2024',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),
                                  readOnly: true,
                                  toolbarOptions: ToolbarOptions(
                                    copy: false,
                                    paste: false,
                                    cut: false,
                                    selectAll: false,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Insurance Expiry',
                                    labelStyle: TextStyle(
                                        fontSize: 15,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0
                                    ),
                                    // enabledBorder: UnderlineInputBorder(
                                    //   borderSide: BorderSide(color: Color(0xFF6200EE)),
                                    // ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _loaduserdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      data = prefs.getString('vehicle_number') ?? '';
    });


  }

}