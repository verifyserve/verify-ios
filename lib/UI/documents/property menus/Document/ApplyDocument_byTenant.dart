import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verify/UI/documents/property%20menus/Document/Tenant_Documemt_Form/Tenant-Autofill_Form.dart';
import '../../../../utils/constant.dart';
import '../flat_list.dart';
import 'Owner_Document_form/Owner_AutoFill_Form.dart';
import 'Owner_Document_form/Owner_FullDetails_Form.dart';
import 'Pending_tenantDocument_Fill.dart';

class Catid {
  final int id;
  final String document_type;
  final String looking_type;
  final String amount;

  Catid(
      {required this.id,required this.document_type,required this.looking_type,required this.amount});

  factory Catid.FromJson(Map<String, dynamic>json){
    return Catid(id: json['id'],
        looking_type: json['looking_type'],
        document_type: json['document_type'],
        amount: json['amount']);
  }
}

class Catid_Tenant {
  final int id;
  final String Name_;
  final String Number;
  final String Father_name;
  final String Occupation;
  final String Date_of_birth;
  final String Permanent_address;
  final String District;
  final String Pin_code;
  final String Police_station;
  final String Place;

  Catid_Tenant(
      {required this.id,required this.Name_,required this.Number,required this.Father_name,required this.Occupation,
        required this.Date_of_birth, required this.Permanent_address,required this.District,required this.Pin_code,
        required this.Police_station,required this.Place});

  factory Catid_Tenant.FromJson(Map<String, dynamic>json){
    return Catid_Tenant(id: json['id'],
        Name_: json['Name_'],
        Number: json['Number'],
        Father_name: json['Father_name'],
        Occupation: json['Occupation'],
        Date_of_birth: json['Date_of_birth'],
        Permanent_address: json['Permanent_address'],
        District: json['District'],
        Pin_code: json['Pin_code'],
        Police_station: json['Police_station'],
        Place: json['Place']);
  }
}

class ApplyDocument_Tenant extends StatefulWidget {
  const ApplyDocument_Tenant({super.key});

  @override
  State<ApplyDocument_Tenant> createState() => _ApplyDocument_TenantState();
}

class _ApplyDocument_TenantState extends State<ApplyDocument_Tenant> {

  String _TenanttNumber = '';
  String Subid = '';

  Future<List<Catid>> fetchData() async {
    var url = Uri.parse('https://verifyserve.social/WebService4.asmx/display_policeverification_rent_by_sub_id_looking_type_?building_subid=$Subid&looking_type=Payment Pending');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      //await Future.delayed(Duration(seconds: 1));
      final List result = json.decode(response.body);
      return result.map((data) => Catid.FromJson(data)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<Catid>> fetchData_PendingTenant() async {
    var url = Uri.parse('https://verifyserve.social/WebService4.asmx/display_policeverification_rent_by_sub_id_looking_type_?building_subid=$Subid&looking_type=Pending Tenant Details');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      //await Future.delayed(Duration(seconds: 1));
      final List result = json.decode(response.body);
      return result.map((data) => Catid.FromJson(data)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<Catid>> fetchData_PendingOwner() async {
    var url = Uri.parse('https://verifyserve.social/WebService4.asmx/display_policeverification_rent_by_sub_id_looking_type_?building_subid=$Subid&looking_type=Pending Owner Details');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      //await Future.delayed(Duration(seconds: 1));
      final List result = json.decode(response.body);
      return result.map((data) => Catid.FromJson(data)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<Catid_Tenant>> fetchData_Tenant() async{
    var url=Uri.parse("https://verifyserve.social/WebService4.asmx/show_store_document_by_number_?number=${_TenanttNumber}");
    final responce=await http.get(url);
    if(responce.statusCode==200){
      List listresponce=json.decode(responce.body);
      return listresponce.map((data) => Catid_Tenant.FromJson(data)).toList();
    }
    else{
      throw Exception('Unexpected error occured!');
    }
  }

  // document Auto Scan

  @override
  void initState() {
    _loaduserdata();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Image.asset(AppImages.verify, height: 75),
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
        actions:  [
          GestureDetector(
            onTap: () async {

            },
            child: const Icon(
              PhosphorIcons.trash,
              color: Colors.black,
              size: 30,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),

      body: Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            FutureBuilder<List<Catid>>(
              future: fetchData(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator());
                }
                else if(snapshot.hasError){
                  return Text('${snapshot.error}');
                }
                else if (snapshot.data == null || snapshot.data!.isEmpty) {
                  // If the list is empty, show an empty image
                  return Center(
                    child: Column(
                      children: [
                        //  Lottie.asset("assets/images/no data.json",width: 450),
                        Center(child: Text("No Data Found!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),)),
                      ],
                    ),
                  );
                }
                else{

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          /*Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PdfViewScreen(pdfPath: 'https://verifyserve.social/Done_Verification/${snapshot.data![index].documentPDF}'),
                          ),
                        );*/

                        },
                        child: Card(
                          child: Container(
                              padding: EdgeInsets.only(right: 10,left: 10,top: 10,bottom: 10),
                              child: Container(
                                padding: EdgeInsets.only(right: 15,left: 10,top: 15,bottom: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                  border: Border.all(width: 1, color: Colors.grey),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        //Image(image: AssetImage('assets/images/history_icon.png'),width: 60),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                width: 300,
                                                child: Text('${snapshot.data![index].document_type}',maxLines: 4, style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 1.5,overflow: TextOverflow.ellipsis),)),
                                          ],
                                        ),
                                        // Image(image: AssetImage('assets/images/outgoing_arrow.png'),width: 20,color: Colors.greenAccent),
                                      ],
                                    ),

                                    SizedBox(
                                      height: 10,
                                    ),

                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        //Image(image: AssetImage('assets/images/history_icon.png'),width: 60),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                width: 300,
                                                child: Text('${snapshot.data![index].looking_type}...',maxLines: 4, style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.red,fontFamily: 'Poppins',letterSpacing: 1.5,overflow: TextOverflow.ellipsis),)),
                                          ],
                                        ),
                                        // Image(image: AssetImage('assets/images/outgoing_arrow.png'),width: 20,color: Colors.greenAccent),
                                      ],
                                    ),

                                    SizedBox(
                                      height: 10,
                                    ),

                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        //Image(image: AssetImage('assets/images/history_icon.png'),width: 60),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                width: 300,
                                                child: Text('Rs ${snapshot.data![index].amount} including GST',maxLines: 4, style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.green,fontFamily: 'Poppins',letterSpacing: 1.5,overflow: TextOverflow.ellipsis),)),
                                          ],
                                        ),
                                        // Image(image: AssetImage('assets/images/
                                        //
                                        // '),width: 20,color: Colors.greenAccent),
                                      ],
                                    ),

                                  ],
                                ),
                              )
                          ),
                        ),
                      );

                    },
                  );
                }
              },
            ),

            FutureBuilder<List<Catid>>(
              future: fetchData_PendingTenant(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator());
                }
                else if(snapshot.hasError){
                  return Text('${snapshot.error}');
                }
                else if (snapshot.data == null || snapshot.data!.isEmpty) {
                  // If the list is empty, show an empty image
                  return Center(
                    child: Column(
                      children: [
                        //  Lottie.asset("assets/images/no data.json",width: 450),
                        Center(child: Text("No Data Found!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),)),
                      ],
                    ),
                  );
                }
                else{

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Tenant_Document(id: '${snapshot.data![index].id.toString()}',),
                          ),
                        );

                        },
                        child: Card(
                          child: Container(
                              padding: EdgeInsets.only(right: 10,left: 10,top: 10,bottom: 10),
                              child: Container(
                                padding: EdgeInsets.only(right: 15,left: 10,top: 15,bottom: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                  border: Border.all(width: 1, color: Colors.grey),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        //Image(image: AssetImage('assets/images/history_icon.png'),width: 60),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                width: 300,
                                                child: Text('${snapshot.data![index].document_type}',maxLines: 4, style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 1.5,overflow: TextOverflow.ellipsis),)),
                                          ],
                                        ),
                                        // Image(image: AssetImage('assets/images/outgoing_arrow.png'),width: 20,color: Colors.greenAccent),
                                      ],
                                    ),

                                    SizedBox(
                                      height: 10,
                                    ),

                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        //Image(image: AssetImage('assets/images/history_icon.png'),width: 60),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                width: 300,
                                                child: Text('${snapshot.data![index].looking_type}...',maxLines: 4, style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.red,fontFamily: 'Poppins',letterSpacing: 1.5,overflow: TextOverflow.ellipsis),)),
                                          ],
                                        ),
                                        // Image(image: AssetImage('assets/images/outgoing_arrow.png'),width: 20,color: Colors.greenAccent),
                                      ],
                                    ),

                                    SizedBox(
                                      height: 10,
                                    ),

                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        //Image(image: AssetImage('assets/images/history_icon.png'),width: 60),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                width: 300,
                                                child: Text('Rs ${snapshot.data![index].amount} including GST',maxLines: 4, style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.green,fontFamily: 'Poppins',letterSpacing: 1.5,overflow: TextOverflow.ellipsis),)),
                                          ],
                                        ),
                                        // Image(image: AssetImage('assets/images/outgoing_arrow.png'),width: 20,color: Colors.greenAccent),
                                      ],
                                    ),

                                  ],
                                ),
                              )
                          ),
                        ),
                      );

                    },
                  );
                }
              },
            ),

            FutureBuilder<List<Catid>>(
              future: fetchData_PendingOwner(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator());
                }
                else if(snapshot.hasError){
                  return Text('${snapshot.error}');
                }
                else if (snapshot.data == null || snapshot.data!.isEmpty) {
                  // If the list is empty, show an empty image
                  return Center(
                    child: Column(
                      children: [
                        //  Lottie.asset("assets/images/no data.json",width: 450),
                        Center(child: Text("No Data Found!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),)),
                      ],
                    ),
                  );
                }
                else{

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          /*Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PdfViewScreen(pdfPath: 'https://verifyserve.social/Done_Verification/${snapshot.data![index].documentPDF}'),
                          ),
                        );*/

                        },
                        child: Card(
                          child: Container(
                              padding: EdgeInsets.only(right: 10,left: 10,top: 10,bottom: 10),
                              child: Container(
                                padding: EdgeInsets.only(right: 15,left: 10,top: 15,bottom: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                  border: Border.all(width: 1, color: Colors.grey),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        //Image(image: AssetImage('assets/images/history_icon.png'),width: 60),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                width: 300,
                                                child: Text('${snapshot.data![index].document_type}',maxLines: 4, style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 1.5,overflow: TextOverflow.ellipsis),)),
                                          ],
                                        ),
                                        // Image(image: AssetImage('assets/images/outgoing_arrow.png'),width: 20,color: Colors.greenAccent),
                                      ],
                                    ),

                                    SizedBox(
                                      height: 10,
                                    ),

                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        //Image(image: AssetImage('assets/images/history_icon.png'),width: 60),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                width: 300,
                                                child: Text('${snapshot.data![index].looking_type}...',maxLines: 4, style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.red,fontFamily: 'Poppins',letterSpacing: 1.5,overflow: TextOverflow.ellipsis),)),
                                          ],
                                        ),
                                        // Image(image: AssetImage('assets/images/outgoing_arrow.png'),width: 20,color: Colors.greenAccent),
                                      ],
                                    ),

                                    SizedBox(
                                      height: 10,
                                    ),

                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        //Image(image: AssetImage('assets/images/history_icon.png'),width: 60),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                width: 300,
                                                child: Text('Rs ${snapshot.data![index].amount} including GST',maxLines: 4, style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.green,fontFamily: 'Poppins',letterSpacing: 1.5,overflow: TextOverflow.ellipsis),)),
                                          ],
                                        ),
                                        // Image(image: AssetImage('assets/images/outgoing_arrow.png'),width: 20,color: Colors.greenAccent),
                                      ],
                                    ),

                                  ],
                                ),
                              )
                          ),
                        ),
                      );

                    },
                  );
                }
              },
            ),
          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Submit for New Document'),
        icon: Icon(Icons.add),
        onPressed: () async {

          final responce = await http.get(Uri.parse("https://verifyserve.social/WebService4.asmx/show_store_count_document?number=${_TenanttNumber.toString()}"));

          print(responce.body);

          if (responce.body == '[{"logg":1}]') {

            fetchData_Tenant();
            final result_Tenant = await fetchData_Tenant();

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Tenant_AutoFill_Form(id: '${result_Tenant.first.id.toString()}',),
              ),
            );


            // Successful login
          } else {
            // Failed login

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Owner_FullDeytails_Form(),
              ),
            );
            /*Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const Owner_Document()));*/

          }

          /* Navigator.of(context).push(
            MaterialPageRoute(
              settings: RouteSettings(name: "/Page1"),
              builder: (context) => Add_Property(),
            ),
          );*/


          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => Add_Property()));
        },
      ),

    );
  }

  void _loaduserdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _TenanttNumber = prefs.getString('_Tenant_No_Document') ?? '';
      Subid = prefs.getString('_buildingid') ?? '';
    });


  }
}
