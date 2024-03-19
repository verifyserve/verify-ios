import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../utils/constant.dart';
import 'Add/AddTenant_Documaintation.dart';
import 'Main/ShowPropertyTenant.dart';
import 'add_tenant.dart';

class Catid{
  final int id;
  final String PropertyAddress;
  final String Society;
  final String Place;
  final String City;
  final String type;
  final String no;
  Catid({required this.id,required this.PropertyAddress,required this.Society,required this.Place,required this.City,required this.no,required this.type});
  factory Catid.FromJson(Map<String,dynamic>json){
    return Catid(id: json['DPS_id'],PropertyAddress: json['PropertyAddress'],Society: json['Society'],Place: json['Place'],City: json['City'],no: json['Owner_Number'],type: json['Property_type']);
  }
}

class FlatList extends StatefulWidget {
  const FlatList({super.key});

  @override
  State<FlatList> createState() => _FlatListState();
}

class _FlatListState extends State<FlatList> {

  String _data = '';

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

  Future<List<Catid>> fetchData(id) async{
    var url=Uri.parse("https://verifyserve.social/WebService2.asmx/Show_Property_Documaintation?number=$_data&property_type=Flat");
    final responce=await http.get(url);
    if(responce.statusCode==200){
      List listresponce=json.decode(responce.body);
      return listresponce.map((data) => Catid.FromJson(data)).toList();
    }
    else{
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
        body: Container(
          child: FutureBuilder<List<Catid>>(
              future: fetchData(""+1.toString()),
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
                      itemBuilder: (BuildContext context,int len){
                        return GestureDetector(
                          onTap: () async {
                            //  int itemId = abc.data![len].id;
                            //int iiid = abc.data![len].PropertyAddress
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString('id_Document', abc.data![len].id.toString());
                            Navigator.push(
                                context,
                                MaterialPageRoute
                                  (builder: (context) => ShowProperty(iidd: abc.data![len].id.toString()))
                            );
                          },
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 10),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                                            child:  Container(
                                              child: Image.asset(AppImages.propertysale,width: 120,fit: BoxFit.fill),
                                            ),
                                          ),
                                          SizedBox(height: 5,),
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
                                                //w SizedBox(width: 10,),
                                                Text(""+abc.data![len].type.toUpperCase(),
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
                                      SizedBox(width: 5,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
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
                                            width: 180,
                                            child: Text(""+abc.data![len].PropertyAddress,
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
                                              Icon(Iconsax.home_1_copy,size: 12,color: Colors.red,),
                                              SizedBox(width: 2,),
                                              Text("Society",
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
                                            width: 180,
                                            child: Text(""+abc.data![len].Society,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Icon(PhosphorIcons.push_pin,size: 12,color: Colors.red,),
                                              SizedBox(width: 2,),
                                              Text("Place",
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 180,
                                            child: Text(""+abc.data![len].Place,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(Iconsax.building_3_copy,size: 14,color: Colors.red,),
                                              SizedBox(width: 3,),
                                              Text(""+abc.data![len].City.toUpperCase(),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey.shade600,
                                                    fontWeight: FontWeight.w500
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      });
                }


              }

          ),


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
