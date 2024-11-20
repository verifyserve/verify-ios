import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../utils/constant.dart';
import 'Add/AddTenant_Documaintation.dart';
import 'View_All_Details_Owner.dart';
import 'View_All_Details_Tenant.dart';

class Catid {
  final int tup_id;
  final String Reelestate_Image;
  final String Address_;
  final String Place_;
  final String floor_ ;
  final String flat_;
  final String Tenant_Rented_Amount;
  final String Tenant_Rented_Date;
  final String Owner_number;
  final String Tenant_number;
  final String maintence;
  final String Bhk_Squarefit;
  final String Subid;

  Catid(
      {required this.tup_id,required this.Reelestate_Image,required this.Address_,required this.Place_,required this.floor_,required this.flat_,
        required this.Tenant_Rented_Amount,required this.Tenant_Rented_Date,required this.Owner_number,required this.Tenant_number,required this.maintence,required this.Bhk_Squarefit,required this.Subid});

  factory Catid.FromJson(Map<String, dynamic>json){
    return Catid(tup_id: json['TUP_id'],Address_: json['Property_Number'],
        Reelestate_Image: json['Property_Image'],Place_: json['PropertyAddress'],
        floor_: json['FLoorr'], flat_: json['Flat'],
        Tenant_Rented_Amount: json['Tenant_Rented_Amount'], Tenant_Rented_Date: json['Tenant_Rented_Date'],
        Owner_number: json['Owner_Number'], Tenant_number: json['Tenant_Number'],maintence: json['Looking_Prop_'],
        Bhk_Squarefit: json['About_tenant'], Subid: json['Subid']);
  }
}

class FlatList extends StatefulWidget {
  const FlatList({super.key});

  @override
  State<FlatList> createState() => _FlatListState();
}

class _FlatListState extends State<FlatList> {

  String _data = '';
  String _number = '';
  String _name = '';

  final TextEditingController _nnoo = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late SharedPreferences preferences;
  ValueNotifier<String>number=ValueNotifier("");

  @override
  void initState() {
    super.initState();
    init();
    _loaduserdata();
  }

  init()async {
    preferences = await SharedPreferences.getInstance();
    number.value = preferences.getString("phone") ?? '';
  }

  Future<List<Catid>> fetchData(numbe) async {
    var url = Uri.parse("https://verifyserve.social/WebService4.asmx/Show_Tenant_Table_by_Owner_Number_?Owner_Number=$numbe");
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      List listresponce = json.decode(responce.body);
      return listresponce.map((data) => Catid.FromJson(data)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<Catid>> fetchData_tenat(numbe) async {
    var url = Uri.parse("https://verifyserve.social/WebService4.asmx/Show_Tenant_Table_by_tenant_Number_?Tenant_Number=$numbe");
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      List listresponce = json.decode(responce.body);
      return listresponce.map((data) => Catid.FromJson(data)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(centerTitle: true,
      backgroundColor: Colors.black,
      title: Image.asset(AppImages.verify, height: 55),),*/
      backgroundColor: Colors.black,
        body: ValueListenableBuilder(
            valueListenable: number,
            builder: (context, String num,__) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: FutureBuilder<List<Catid>>(
                        future: fetchData(num),
                        builder: (context,abc){
                          if(abc.connectionState == ConnectionState.waiting){
                            return Center(child: CircularProgressIndicator());
                          }
                          else if(abc.hasError){
                            return Text('${abc.error}');
                          }
                          else if (abc.data == null || abc.data!.isEmpty) {
                            // If the list is empty, show an empty image
                            return Center(
                              child: Column(
                                children: [
                                  // Lottie.asset("assets/images/no data.json",width: 450),
                                  Text("No Data Found!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                                ],
                              ),
                            );
                          }
                          else{
                            return ListView.builder(
                                itemCount: abc.data!.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context,int len){
                                  return GestureDetector(
                                    onTap: () async {
                                      //  int itemId = abc.data![len].id;
                                      //int iiid = abc.data![len].PropertyAddress
                                      /*Navigator.push(
                                          context,
                                          MaterialPageRoute
                                            (builder: (context) => ShowProperty(iidd: abc.data![len].id.toString()))
                                      );*/
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute
                                            (builder: (context) => View_Details(iidd: '${abc.data![len].tup_id.toString()}', SUbid: '${abc.data![len].Subid.toString()}', T_num: '${abc.data![len].Tenant_number.toString()}', O_Num: '${abc.data![len].Owner_number.toString()}',))
                                      );
                                    },
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 20),
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(15),
                                              ),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                            const BorderRadius.all(Radius.circular(10)),
                                                            child: Container(
                                                              height: 100,
                                                              width: 120,
                                                              child: CachedNetworkImage(
                                                                imageUrl:
                                                                "https://verifyserve.social/"+abc.data![len].Reelestate_Image,
                                                                fit: BoxFit.cover,
                                                                placeholder: (context, url) => Image.asset(
                                                                  AppImages.loading,
                                                                  fit: BoxFit.cover,
                                                                ),
                                                                errorWidget: (context, error, stack) =>
                                                                    Image.asset(
                                                                      AppImages.imageNotFound,
                                                                      fit: BoxFit.cover,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),

                                                        ],
                                                      ),
                                                      SizedBox(width: 5,),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Row(
                                                            children: [

                                                              SizedBox(
                                                                width: 5,
                                                              ),

                                                              Container(
                                                                padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(5),
                                                                  border: Border.all(width: 1, color: Colors.purple),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                        color: Colors.purple.withOpacity(0.5),
                                                                        blurRadius: 10,
                                                                        offset: Offset(0, 0),
                                                                        blurStyle: BlurStyle.outer
                                                                    ),
                                                                  ],
                                                                ),
                                                                child: Row(
                                                                  children: [
                                                                    // Icon(Iconsax.sort_copy,size: 15,),
                                                                    //SizedBox(width: 10,),
                                                                    Text(""+abc.data![len].floor_/*+abc.data![len].Building_Name.toUpperCase()*/,
                                                                      style: TextStyle(
                                                                          fontSize: 12,
                                                                          color: Colors.black,
                                                                          fontWeight: FontWeight.w500,
                                                                          letterSpacing: 0.5
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),

                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Container(
                                                                padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(5),
                                                                  border: Border.all(width: 1, color: Colors.orange),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                        color: Colors.orange.withOpacity(0.5),
                                                                        blurRadius: 10,
                                                                        offset: Offset(0, 0),
                                                                        blurStyle: BlurStyle.outer
                                                                    ),
                                                                  ],
                                                                ),
                                                                child: Row(
                                                                  children: [
                                                                    // Icon(Iconsax.sort_copy,size: 15,),
                                                                    //SizedBox(width: 10,),
                                                                    Text(""+abc.data![len].Bhk_Squarefit/*+abc.data![len].Building_Name.toUpperCase()*/,
                                                                      style: TextStyle(
                                                                          fontSize: 12,
                                                                          color: Colors.black,
                                                                          fontWeight: FontWeight.w500,
                                                                          letterSpacing: 0.5
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),

                                                          Row(
                                                            children: [
                                                              Icon(Iconsax.location_copy,size: 12,color: Colors.red,),
                                                              SizedBox(width: 2,),
                                                              Text("Property Address",
                                                                overflow: TextOverflow.ellipsis,
                                                                maxLines: 2,
                                                                style: TextStyle(
                                                                    fontSize: 11,
                                                                    color: Colors.black,
                                                                    fontWeight: FontWeight.w600),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width: 150,
                                                            child: Text("    "+abc.data![len].Address_,
                                                              overflow: TextOverflow.ellipsis,
                                                              maxLines: 2,
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.w400),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),

                                                          Row(
                                                            children: [
                                                              Icon(PhosphorIcons.push_pin,size: 12,color: Colors.red,),
                                                              SizedBox(width: 2,),
                                                              Text("Rent And Maintaince",
                                                                style: TextStyle(
                                                                    fontSize: 11,
                                                                    color: Colors.black,
                                                                    fontWeight: FontWeight.w600),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width: 180,
                                                            child: Text("   "+abc.data![len].Tenant_Rented_Amount+"  |   "+abc.data![len].maintence
                                                              ,
                                                              overflow: TextOverflow.ellipsis,
                                                              maxLines: 2,
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.w400
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),

                                                        ],
                                                      ),
                                                    ],
                                                  ),

                                                  SizedBox(
                                                    height: 10,
                                                  ),

                                                  Row(
                                                    children: [

                                                      Container(
                                                        padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5),
                                                          border: Border.all(width: 1, color: Colors.red),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: Colors.red.withOpacity(0.5),
                                                                blurRadius: 10,
                                                                offset: Offset(0, 0),
                                                                blurStyle: BlurStyle.outer
                                                            ),
                                                          ],
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            // Icon(Iconsax.sort_copy,size: 15,),
                                                            //SizedBox(width: 10,),
                                                            Text(""+abc.data![len].flat_/*+abc.data![len].flat_*//*+abc.data![len].Building_Name.toUpperCase()*/,
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.w500,
                                                                  letterSpacing: 0.5
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),

                                                      SizedBox(
                                                        width: 10,
                                                      ),

                                                      Container(
                                                        padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5),
                                                          border: Border.all(width: 1, color: Colors.blue),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: Colors.blue.withOpacity(0.5),
                                                                blurRadius: 10,
                                                                offset: Offset(0, 0),
                                                                blurStyle: BlurStyle.outer
                                                            ),
                                                          ],
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            // Icon(Iconsax.sort_copy,size: 15,),
                                                            //SizedBox(width: 10,),
                                                            Text(""+abc.data![len].Place_/*+abc.data![len].flat_*//*+abc.data![len].Building_Name.toUpperCase()*/,
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.w500,
                                                                  letterSpacing: 0.5
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),

                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5),
                                                          border: Border.all(width: 1, color: Colors.green),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: Colors.green.withOpacity(0.5),
                                                                blurRadius: 10,
                                                                offset: Offset(0, 0),
                                                                blurStyle: BlurStyle.outer
                                                            ),
                                                          ],
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            // Icon(Iconsax.sort_copy,size: 15,),
                                                            //SizedBox(width: 10,),
                                                            Text(""+abc.data![len].Tenant_Rented_Date/*+abc.data![len].floor_*//*+abc.data![len].Building_Name.toUpperCase()*/,
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.w500,
                                                                  letterSpacing: 0.5
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          }


                        }

                    ),


                  ),

                  Container(
                    child: FutureBuilder<List<Catid>>(
                        future: fetchData_tenat(num),
                        builder: (context,abc){
                          if(abc.connectionState == ConnectionState.waiting){
                            return Center(child: CircularProgressIndicator());
                          }
                          else if(abc.hasError){
                            return Text('${abc.error}');
                          }
                          else if (abc.data == null || abc.data!.isEmpty) {
                            // If the list is empty, show an empty image
                            return Center(
                              child: Column(
                                children: [
                                  // Lottie.asset("assets/images/no data.json",width: 450),
                                  Text("No Data Found!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                                ],
                              ),
                            );
                          }
                          else{
                            return ListView.builder(
                                itemCount: abc.data!.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context,int len){
                                  return GestureDetector(
                                    onTap: () async {
                                      //  int itemId = abc.data![len].id;
                                      //int iiid = abc.data![len].PropertyAddress
                                      /*Navigator.push(
                                          context,
                                          MaterialPageRoute
                                            (builder: (context) => ShowProperty(iidd: abc.data![len].id.toString()))
                                      );*/
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute
                                            (builder: (context) => View_Details_Tenant(iidd: '${abc.data![len].tup_id.toString()}', SUbid: '${abc.data![len].Subid.toString()}', T_num: '${abc.data![len].Tenant_number.toString()}', O_Num: '${abc.data![len].Owner_number.toString()}',))
                                      );
                                    },
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 20),
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(15),
                                              ),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                            const BorderRadius.all(Radius.circular(10)),
                                                            child: Container(
                                                              height: 100,
                                                              width: 120,
                                                              child: CachedNetworkImage(
                                                                imageUrl:
                                                                "https://verifyserve.social/"+abc.data![len].Reelestate_Image,
                                                                fit: BoxFit.cover,
                                                                placeholder: (context, url) => Image.asset(
                                                                  AppImages.loading,
                                                                  fit: BoxFit.cover,
                                                                ),
                                                                errorWidget: (context, error, stack) =>
                                                                    Image.asset(
                                                                      AppImages.imageNotFound,
                                                                      fit: BoxFit.cover,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),

                                                        ],
                                                      ),
                                                      SizedBox(width: 5,),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Row(
                                                            children: [

                                                              SizedBox(
                                                                width: 5,
                                                              ),

                                                              Container(
                                                                padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(5),
                                                                  border: Border.all(width: 1, color: Colors.purple),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                        color: Colors.purple.withOpacity(0.5),
                                                                        blurRadius: 10,
                                                                        offset: Offset(0, 0),
                                                                        blurStyle: BlurStyle.outer
                                                                    ),
                                                                  ],
                                                                ),
                                                                child: Row(
                                                                  children: [
                                                                    // Icon(Iconsax.sort_copy,size: 15,),
                                                                    //SizedBox(width: 10,),
                                                                    Text(""+abc.data![len].floor_/*+abc.data![len].Building_Name.toUpperCase()*/,
                                                                      style: TextStyle(
                                                                          fontSize: 12,
                                                                          color: Colors.black,
                                                                          fontWeight: FontWeight.w500,
                                                                          letterSpacing: 0.5
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),

                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Container(
                                                                padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(5),
                                                                  border: Border.all(width: 1, color: Colors.orange),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                        color: Colors.orange.withOpacity(0.5),
                                                                        blurRadius: 10,
                                                                        offset: Offset(0, 0),
                                                                        blurStyle: BlurStyle.outer
                                                                    ),
                                                                  ],
                                                                ),
                                                                child: Row(
                                                                  children: [
                                                                    // Icon(Iconsax.sort_copy,size: 15,),
                                                                    //SizedBox(width: 10,),
                                                                    Text(""+abc.data![len].Bhk_Squarefit/*+abc.data![len].Building_Name.toUpperCase()*/,
                                                                      style: TextStyle(
                                                                          fontSize: 12,
                                                                          color: Colors.black,
                                                                          fontWeight: FontWeight.w500,
                                                                          letterSpacing: 0.5
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),

                                                          Row(
                                                            children: [
                                                              Icon(Iconsax.location_copy,size: 12,color: Colors.red,),
                                                              SizedBox(width: 2,),
                                                              Text("Property Address",
                                                                overflow: TextOverflow.ellipsis,
                                                                maxLines: 2,
                                                                style: TextStyle(
                                                                    fontSize: 11,
                                                                    color: Colors.black,
                                                                    fontWeight: FontWeight.w600),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width: 150,
                                                            child: Text("    "+abc.data![len].Address_,
                                                              overflow: TextOverflow.ellipsis,
                                                              maxLines: 2,
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.w400),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),

                                                          Row(
                                                            children: [
                                                              Icon(PhosphorIcons.push_pin,size: 12,color: Colors.red,),
                                                              SizedBox(width: 2,),
                                                              Text("Rent And Maintaince",
                                                                style: TextStyle(
                                                                    fontSize: 11,
                                                                    color: Colors.black,
                                                                    fontWeight: FontWeight.w600),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width: 180,
                                                            child: Text("   "+abc.data![len].Tenant_Rented_Amount+"  |   "+abc.data![len].maintence
                                                              ,
                                                              overflow: TextOverflow.ellipsis,
                                                              maxLines: 2,
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.w400
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),

                                                        ],
                                                      ),
                                                    ],
                                                  ),

                                                  SizedBox(
                                                    height: 10,
                                                  ),

                                                  Row(
                                                    children: [

                                                      Container(
                                                        padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5),
                                                          border: Border.all(width: 1, color: Colors.red),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: Colors.red.withOpacity(0.5),
                                                                blurRadius: 10,
                                                                offset: Offset(0, 0),
                                                                blurStyle: BlurStyle.outer
                                                            ),
                                                          ],
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            // Icon(Iconsax.sort_copy,size: 15,),
                                                            //SizedBox(width: 10,),
                                                            Text(""+abc.data![len].flat_/*+abc.data![len].flat_*//*+abc.data![len].Building_Name.toUpperCase()*/,
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.w500,
                                                                  letterSpacing: 0.5
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),

                                                      SizedBox(
                                                        width: 10,
                                                      ),

                                                      Container(
                                                        padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5),
                                                          border: Border.all(width: 1, color: Colors.blue),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: Colors.blue.withOpacity(0.5),
                                                                blurRadius: 10,
                                                                offset: Offset(0, 0),
                                                                blurStyle: BlurStyle.outer
                                                            ),
                                                          ],
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            // Icon(Iconsax.sort_copy,size: 15,),
                                                            //SizedBox(width: 10,),
                                                            Text(""+abc.data![len].Place_/*+abc.data![len].flat_*//*+abc.data![len].Building_Name.toUpperCase()*/,
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.w500,
                                                                  letterSpacing: 0.5
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),

                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5),
                                                          border: Border.all(width: 1, color: Colors.green),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: Colors.green.withOpacity(0.5),
                                                                blurRadius: 10,
                                                                offset: Offset(0, 0),
                                                                blurStyle: BlurStyle.outer
                                                            ),
                                                          ],
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            // Icon(Iconsax.sort_copy,size: 15,),
                                                            //SizedBox(width: 10,),
                                                            Text(""+abc.data![len].Tenant_Rented_Date/*+abc.data![len].floor_*//*+abc.data![len].Building_Name.toUpperCase()*/,
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.w500,
                                                                  letterSpacing: 0.5
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          }


                        }

                    ),


                  ),
                ],
              ),
            );
          }
        ),



      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Add Property'),
        icon: Icon(Icons.add),
        onPressed: (){

          Navigator.of(context).push(
            MaterialPageRoute(
              settings: RouteSettings(name: "/Page1"),
              builder: (context) => Add_Property(),
            ),
          );


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
      _data = prefs.getString('login_number') ?? '';
    });


  }
}
