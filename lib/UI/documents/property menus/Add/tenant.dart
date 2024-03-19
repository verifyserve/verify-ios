import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verify/UI/documents/document_screen.dart';

import '../Main/ShowPropertyTenant.dart';
import 'add_tenant_servant.dart';

class TenantDetails extends StatefulWidget {
  const TenantDetails({super.key});

  @override
  State<TenantDetails> createState() => _TenantDetailsState();
}

class _TenantDetailsState extends State<TenantDetails> {



  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late SharedPreferences preferences;
  ValueNotifier<String>name=ValueNotifier("");
  ValueNotifier<String>email=ValueNotifier("");
  ValueNotifier<String>number=ValueNotifier("");

  @override
  void initState() {
    super.initState();
    init();
    _rentdate.text = "";
    _loaduserdata();
  }

  init()async{
    preferences=await SharedPreferences.getInstance();
    name.value=preferences.getString("name")??'';
    email.value=preferences.getString("email")??'';
    number.value=preferences.getString("phone")??'';

  }
  String data1 = '';

  //TextEditingController dateinput = TextEditingController();

  final TextEditingController _tenantName = TextEditingController();
  final TextEditingController _Flatfloor_num = TextEditingController();
  final TextEditingController _rentamount = TextEditingController();
  final TextEditingController _rentdate = TextEditingController();
  final TextEditingController _about = TextEditingController();
  final TextEditingController _tenantnum = TextEditingController();
  final TextEditingController _tenantemail = TextEditingController();
  final TextEditingController _tenantwork = TextEditingController();
  late TextEditingController _tenantmember = TextEditingController();

  Future<void> fetchdata(tenantname,Flatfloor_num,rentamount,rentdate,about,tenentnum,tenentemail,tenantwork,tenentmember,ownername,numb,emil) async{
    final responce = await http.get(Uri.parse('https://verifyserve.social/WebService2.asmx/Add_Tenants_Documaintation?Tenant_Name=$tenantname&Flat_floor=$Flatfloor_num&Tenant_Rented_Amount=$rentamount&Tenant_Rented_Date=$rentdate&About_tenant=$about&Tenant_Number=$tenentnum&Tenant_Email=$tenentemail&Tenant_WorkProfile=$tenantwork&Tenant_Members=$tenentmember&Owner_Name=$ownername&Owner_Number=$numb&Owner_Email=$emil&Subid=$data1'));
    //final responce = await http.get(Uri.parse('https://verifyserve.social/WebService2.asmx/Add_Tenants_Documaintation?Tenant_Name=gjhgjg&Tenant_Rented_Amount=entamount&Tenant_Rented_Date=entdat&About_tenant=bout&Tenant_Number=enentnum&Tenant_Email=enentemail&Tenant_WorkProfile=nantwor&Tenant_Members=enentmember&Owner_Name=wnername&Owner_Number=umb&Owner_Email=emi&Subid=3'));

    if(responce.statusCode == 200){
      print(responce.body);

      //SharedPreferences prefs = await SharedPreferences.getInstance();

    } else {
      print('Failed Registration');
    }

  }

  String? dropdownValue,dropdownValue_dob,dropdownValue_gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 10,right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20,),

              Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text('Tenant Name',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

              SizedBox(height: 5,),

              Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  // boxShadow: K.boxShadow,
                ),
                child: TextField(
                  controller: _tenantName,
                  decoration: InputDecoration(
                      hintText: "Enter Tenant Name",
                      prefixIcon: Icon(
                        Icons.person_2_outlined,
                        color: Colors.black54,
                      ),
                      hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                      border: InputBorder.none),
                ),
              ),

              SizedBox(height: 20,),

              Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text('Tenant Flat/Floor Number',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

              SizedBox(height: 5,),

              Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  // boxShadow: K.boxShadow,
                ),
                child: TextField(
                  controller: _Flatfloor_num,
                  decoration: InputDecoration(
                      hintText: "Enter Tenant Flat/Floor Number",
                      prefixIcon: Icon(
                        PhosphorIcons.house_line,
                        color: Colors.black54,
                      ),
                      hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                      border: InputBorder.none),
                ),
              ),

              SizedBox(height: 20,),

              Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text('Rent Amount',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

              SizedBox(height: 5,),

              Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  // boxShadow: K.boxShadow,
                ),
                child: TextField(
                  keyboardType: TextInputType.number,
                    controller: _rentamount,
                  decoration: InputDecoration(
                      hintText: "Enter Rent Amount",
                      prefixIcon: Icon(
                        PhosphorIcons.currency_inr,
                        color: Colors.black54,
                      ),
                      hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                      border: InputBorder.none),
                ),
              ),

              SizedBox(height: 20,),

              Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text('Rent Date',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

              SizedBox(height: 5,),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        // boxShadow: K.boxShadow,
                      ),
                      child: TextField(
                          controller: _rentdate,
                        readOnly: true,
                        onTap: () async{
                          DateTime? pickedDate = await showDatePicker(
                              context: context, initialDate: DateTime.now(),
                              firstDate: DateTime(2010), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));

                          if(pickedDate != null ){
                            print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
                            print(formattedDate); //formatted date output using intl package =>  2021-03-16
                            //you can implement different kind of Date Format here according to your requirement
                            //yyyy-MM-dd
                            setState(() {
                              _rentdate.text = formattedDate; //set output date to TextField value.
                            });
                          }else{
                            print("Date is not selected");
                          }
                        },
                        decoration: InputDecoration(
                            hintText: "Enter Rent Date",
                            prefixIcon: Icon(
                              PhosphorIcons.calendar,
                              color: Colors.black54,
                            ),
                            hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.pinkAccent.shade100
                    ),
                    child: IconButton(
                      onPressed: () async{
                        DateTime? pickedDate = await showDatePicker(
                            context: context, initialDate: DateTime.now(),
                            firstDate: DateTime(2010), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2101));

                        if(pickedDate != null ){
                          print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
                          print(formattedDate); //formatted date output using intl package =>  2021-03-16
                          //you can implement different kind of Date Format here according to your requirement
                          //yyyy-MM-dd
                          setState(() {
                            _rentdate.text = formattedDate; //set output date to TextField value.
                          });
                        }else{
                          print("Date is not selected");
                        }
                      },
                      icon: Icon(
                      PhosphorIcons.calendar,
                      color: Colors.black,
                    ),),
                  )
                ],
              ),

              SizedBox(height: 20,),

              Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text('About Tenant',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

              SizedBox(height: 5,),

              Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  // boxShadow: K.boxShadow,
                ),
                child: TextField(
                  maxLines: 5,
                  controller: _about,
                  decoration: InputDecoration(
                      hintText: "About Tenant",
                      contentPadding: EdgeInsets.only(left: 10,top: 5),
                      // prefixIcon: Icon(
                      //   PhosphorIcons.phone_call,
                      //   color: Colors.black54,
                      // ),
                      hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                      border: InputBorder.none),
                ),
              ),

              SizedBox(height: 20,),

              Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text('Tenant Number',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

              SizedBox(height: 5,),

              Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  // boxShadow: K.boxShadow,
                ),
                child: TextField(
                  controller: _tenantnum,
                  decoration: InputDecoration(
                      hintText: "Enter Tenant Number",
                      prefixIcon: Icon(
                        PhosphorIcons.phone_call,
                        color: Colors.black54,
                      ),
                      hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                      border: InputBorder.none),
                ),
              ),

              SizedBox(height: 20,),

              Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text('Tenant Email',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

              SizedBox(height: 5,),

              Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  // boxShadow: K.boxShadow,
                ),
                child: TextField(
                    controller: _tenantemail,
                  decoration: InputDecoration(
                      hintText: "Enter Tenant Email",
                      prefixIcon: Icon(
                        Icons.mail_outline,
                        color: Colors.black54,
                      ),
                      hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                      border: InputBorder.none),
                ),
              ),

              SizedBox(height: 20,),

              Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text("Tenant WorkProfile",style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

              SizedBox(height: 5,),

              Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  // boxShadow: K.boxShadow,
                ),
                child: TextField(
                    controller: _tenantwork,
                  decoration: InputDecoration(
                      hintText: "Enter Tenant WorkProfile",
                      prefixIcon: Icon(
                        Icons.work_outline,
                        color: Colors.black54,
                      ),
                      hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                      border: InputBorder.none),
                ),
              ),

              SizedBox(height: 20,),

              Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text("Tenant Members",style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

              SizedBox(height: 5,),

              Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  // boxShadow: K.boxShadow,
                ),
                child: TextField(
                    controller: _tenantmember,
                  decoration: InputDecoration(
                      hintText: "Enter Tenant Members",
                      prefixIcon: Icon(
                        Icons.people_alt_outlined,
                        color: Colors.black54,
                      ),
                      hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                      border: InputBorder.none),
                ),
              ),

              SizedBox(height: 40,),

              Center(
                child:  ValueListenableBuilder(
                    valueListenable: name,
                    builder: (context, String n,__) {
                      return ValueListenableBuilder(
                          valueListenable: email,
                          builder: (context, String e,__) {
                            return ValueListenableBuilder(
                                valueListenable: number,
                                builder: (context, String num,__) {
                                  return Container(
                                    height: 50,
                                    width: 200,
                                    margin: const EdgeInsets.symmetric(horizontal: 50),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                        color: Colors.red.withOpacity(0.8)
                                    ),



                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red
                                      ),
                                      onPressed: (){

                                        //data = _email.toString();
                                        fetchdata(_Flatfloor_num.text ,_tenantName.text, _rentamount.text, _rentdate.text, _about.text, _tenantnum.text, _tenantemail.text, _tenantwork.text, _tenantmember.text, n,num,e);

                                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => ShowProperty(iidd: data1),), (route) => route.isFirst);

                                      }, child: Text("Submit", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, ),
                                    ),
                                    ),

                                  );
                                }
                            );
                          }
                      );
                    }
                ),
              ),

              SizedBox(height: 40,),

            ],
          ),
        ),
      ),
    );
  }
  void _loaduserdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      data1 = prefs.getString('id_Document') ?? '';
    });


  }
}
