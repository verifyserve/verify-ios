import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verify/UI/documents/Document/ServantTab.dart';
import 'package:verify/UI/documents/addProperty.dart';
import 'package:verify/UI/documents/employe%20menus/employee_list.dart';
import 'package:verify/UI/documents/property%20menus/Main/OwnerDetails_Page.dart';
import 'package:verify/UI/documents/property%20menus/flat_list.dart';
import 'package:verify/UI/home/home_screen.dart';
import 'package:verify/bloc/documentaionBloc.dart';
import 'package:verify/data/model/showEmployeeType.dart';
import 'package:verify/data/repository/DocumentationRepository.dart';
import 'package:verify/utils/constant.dart';
import 'package:verify/utils/message_handler.dart';
import 'package:http/http.dart' as http;

import '../../data/model/docpropertySlider.dart';
import '../realEstate/View_All_Details_Realestate.dart';
import 'Document/documenttab.dart';

class Catid{
  final int id;
  final String Owner_Name;
  final String Owner_Number;
  final String Owner_Email;
  final String Tenant_num;
  final String Subid;
  Catid({required this.id,required this.Owner_Name,required this.Owner_Number,required this.Owner_Email,required this.Tenant_num,required this.Subid});
  factory Catid.FromJson(Map<String,dynamic>json){
    return Catid(id: json['TUP_id'],Owner_Name: json['Owner_Name'],Owner_Number: json['Owner_Number'],Owner_Email: json['PropertyAddress'],Tenant_num: json['Tenant_Number'],Subid: json['Subid']);

  }
}

class Catido {
  final int id;
  final String Building_Name;
  final String Building_Address;
  final String Building_Location;
  final String Building_image;
  final String Longitude;
  final String Latitude;
  final String Rent;
  final String Verify_price;
  final String BHK;
  final String sqft;
  final String tyope;
  final String floor_ ;
  final String maintence ;
  final String buy_Rent ;
  final String Building_information;
  final String Parking;
  final String balcony;
  final String facility;
  final String Furnished;
  final String kitchen;
  final String Baathroom;
  final String date;

  Catido(
      {required this.id, required this.Building_Name, required this.Building_Address, required this.Building_Location, required this.Building_image, required this.Longitude, required this.Latitude, required this.Rent, required this.Verify_price, required this.BHK, required this.sqft, required this.tyope, required this.floor_, required this.maintence, required this.buy_Rent,
        required this.Building_information,required this.balcony,required this.Parking,required this.facility,required this.Furnished,required this.kitchen,required this.Baathroom,required this.date});

  factory Catido.FromJson(Map<String, dynamic>json){
    return Catido(id: json['PVR_id'],
        Building_Name: json['Building_information'],
        Building_Address: json['Address_'],
        Building_Location: json['Place_'],
        Building_image: json['Realstate_image'],
        Longitude: json['Longtitude'],
        Latitude: json['Latitude'],
        Rent: json['Property_Number'],
        Verify_price: json['Gas_meter'],
        BHK: json['Bhk_Squarefit'],
        sqft: json['City'],
        tyope: json['Typeofproperty'],
        floor_: json['floor_'],
        maintence: json['maintenance'],
        buy_Rent: json['Buy_Rent'],
        Building_information: json['Building_information'],
        balcony: json['balcony'],
        Parking: json['Parking'],
        facility: json['Lift'],
        Furnished: json['Furnished'],
        kitchen: json['kitchen'],
        Baathroom: json['Baathroom'],
        date: json['date_']);
  }
}

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({Key? key}) : super(key: key);

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {

  late DocumentationBloc bloc;

  int pageIndex = 0;
  // List<String> status = [
    // 'FLAT',
    // 'SHOP',
    // 'SHOWROOM',
    // 'WAREHOUSE',
    // 'FLOOR',
    // 'BASEMENT',
    // 'ROOFS',
    // 'HOMES',
  // ];

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late SharedPreferences preferences;
  ValueNotifier<String>number=ValueNotifier("");

  init()async {
    preferences = await SharedPreferences.getInstance();
    number.value = preferences.getString("phone") ?? '';
  }

  Future<List<Catido>> fetchData1(id) async {
    var url = Uri.parse("https://verifyserve.social/WebService4.asmx/show_propertyverifycation_by_lookingproperty_ownernumber?Looking_Property_=Flat&Owner_number=$id");
    final responce = await http.get(url);
    if (responce.statusCode == 200) {

      List listresponce = json.decode(responce.body);
      listresponce.sort((a, b) => b['PVR_id'].compareTo(a['PVR_id']));
      return listresponce.map((data) => Catido.FromJson(data)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  @override
  void initState() {
    bloc = DocumentationBloc(context.read<DocumentationRepository>());
    super.initState();
    bloc.DocumentationStream.stream.listen((event) {
      if(event=="POP"){
        Navigator.pop(context);
        // bloc.init();
        // bloc.showDocument();
        // bloc.showTenant(bloc.status.value.first);
      }
    });
    bloc.msgController?.stream.listen((event) {
      AppMessageHandler().showSnackBar(context, event);
    });
    bloc.topListList();
    bloc.showDocument();
    bloc.showEmployeeData();
    // bloc.init();
    init();
    _loaduserdata();
  }

  String _data = '';

  List ownerdata = [];

  Future<List<Catid>> fetchData(id) async{
    var url=Uri.parse("https://verifyserve.social/WebService4.asmx/show_RealEstate_by_Tanantnumber?Tenant_Number=${id}");
    final responce=await http.get(url);
    if(responce.statusCode==200){
      ownerdata=json.decode(responce.body);
      return ownerdata.map((data) => Catid.FromJson(data)).toList();
    }
    else{
      throw Exception('Unexpected error occured!');
    }
  }

  //For Documentation Main Slider
  Future<List<DocumentMainModel>> fetchCarouselData() async {
    final response = await http.get(Uri.parse('https://verifyserve.social/WebService1.asmx/ShowDocumentimg'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) {
        return DocumentMainModel(
          dimage: item['Dimage'],
        );
      }).toList();
    } else {
      throw Exception('Failed to load data');
    }
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

            // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>
            //     HomeScreen()),(Route<dynamic> route) => false);

            Navigator.pop(context,true);
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
      body: ValueListenableBuilder(
          valueListenable: number,
          builder: (context, String num,__) {
            return ValueListenableBuilder(
                valueListenable: bloc.topListLoader,
                builder: (context, bool loading, _) {
                  if (loading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  }
                return Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),

                    FutureBuilder<List<DocumentMainModel>>(
                      future: fetchCarouselData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData) {
                          return Center(child: Text('No data available.'));
                        } else {
                          return CarouselSlider(
                            options: CarouselOptions(
                              height: 180.0,
                              enlargeCenterPage: true,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 2),
                            ),
                            items: snapshot.data!.map((item) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return  Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    width: 320.w,
                                    child: ClipRRect(
                                      borderRadius:
                                      const BorderRadius.all(Radius.circular(15)),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                        "https://www.verifyserve.social/upload/${item.dimage}",
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
                                  );
                                },
                              );
                            }).toList(),
                          );
                        }
                      },
                    ),

                   const SizedBox(height: 20,),

                 SizedBox(
                          height: 40,
                          child: ListView.builder(
                            itemCount: bloc.topList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async{
                                  pageIndex = index;
                                  print("${pageIndex} ${bloc.type.value}");
                                  if(index == 1){
                                    if(bloc.showEmployeeLists.value.isNotEmpty){
                                      bloc.type.value = bloc.showEmployeeLists.value.first.pname?? "";
                                      bloc.showEmployeeIndex.value = 0;
                                      print("objectss ${bloc.showEmployeeLists.value.first.pname}");
                                      print(bloc.type.value);
                                      await bloc.showEmployee(bloc.showEmployeeLists.value.first.pname ?? "");
                                    }
                                  }

                                    /*Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => FlatDetails(iidd: abc.data![len].id.toString()))

                                    );*/

                                    setState(() {});
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        margin: const EdgeInsets.only(left: 10),
                                        decoration: BoxDecoration(
                                            color:
                                                pageIndex == index ? Colors.red : Colors.grey,
                                            borderRadius: BorderRadius.circular(10)),
                                        child: Text(
                                          bloc.topList[index].stCname ?? "",
                                          style: TextStyle(
                                              color: pageIndex == index
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),

                   if (pageIndex == 2)
                      const SizedBox(
                        height: 10,
                      ),
                    if (pageIndex == 2)
                          Container(
                            child: ValueListenableBuilder(
                                valueListenable: number,
                                builder: (context, String num,__) {
                                return FutureBuilder<List<Catid>>(
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
                                        return  Expanded(
                                          child: ListView.builder(
                                            //itemCount: abc.data!.length,
                                              itemCount: abc.data!.length,
                                              scrollDirection: Axis.vertical,
                                              itemBuilder: (BuildContext context,int len){
                                                return GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context) => Owner_details(iidd: abc.data![len].id.toString(), Tenant_num: abc.data![len].Tenant_num.toString(), Owner_Num: abc.data![len].Owner_Number.toString(), B_Subid: abc.data![len].Subid.toString(),))
                                                    );
                                                  },
                                                  child: Container(
                                                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                                    padding: const EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey.withOpacity(0.6),
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                                                          decoration: BoxDecoration(
                                                            color: Colors.black.withOpacity(0.7),
                                                            borderRadius: BorderRadius.circular(10),
                                                          ),
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius: BorderRadius.circular(5),
                                                                child: Image(
                                                                  image: AssetImage('assets/images/image_not_found.png'),
                                                                  height: 75.h,
                                                                  width: 120.w,
                                                                  fit: BoxFit.cover,
                                                                ),
                                                              ),
                                                              const Spacer(),
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                children: [
                                                                  SizedBox(
                                                                    height: 15,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 140,
                                                                    child: Text(" Name:- "+
                                                                        abc.data![len].Owner_Name,
                                                                      overflow: TextOverflow.ellipsis,
                                                                      style: TextStyle(
                                                                          fontSize: 12,
                                                                          color: Colors.white,
                                                                          fontWeight: FontWeight.w500),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Text(" Number:- "+
                                                                      abc.data![len].Owner_Number,
                                                                    style: TextStyle(
                                                                      fontSize: 11,
                                                                      color: Colors.white,
                                                                      // fontWeight: FontWeight.w500
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 140,
                                                                    child: Text(" Email:- "+
                                                                        abc.data![len].Owner_Email,
                                                                      overflow: TextOverflow.ellipsis,
                                                                      style: TextStyle(
                                                                        fontSize: 11,
                                                                        color: Colors.white,
                                                                        // fontWeight: FontWeight.w500
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const Spacer(),
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                children: [
                                                                  Text(
                                                                    'Owner',
                                                                    style: TextStyle(
                                                                        fontSize: 13,
                                                                        color: Colors.white,
                                                                        fontWeight: FontWeight.w700),),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),


                                                );

                                              }),

                                        );
                                      }
                                    }
                                    );
                              }
                            ),
                          ),

                    if (pageIndex == 0)
                      const SizedBox(
                        height: 20,
                      ),
                    if (pageIndex == 0)
                      Expanded(
                        child: Column(
                          children: [

                            ValueListenableBuilder(
                              valueListenable: bloc.status,
                              builder: (context,List<String> loading,_) {
                                return Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        height: 5,
                                        decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(40),
                                                topRight: Radius.circular(40)),
                                            color: Colors.black),
                                        child: ListView.builder(
                                          itemCount: loading.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    bloc.showPropertyIndex.value = index;
                                                    bloc.type.value = loading[index] ?? "";
                                                    await bloc.showTenant(loading[index]);
                                                  },
                                                  child: Container(
                                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                                      margin: const EdgeInsets.only(right: 20),
                                                      child:
                                                      ValueListenableBuilder(
                                                        valueListenable: bloc.showPropertyIndex,
                                                        builder: (context, int? propertyIndex, child) {
                                                          return Text(loading[index] ?? "",
                                                          style: TextStyle(
                                                              color:propertyIndex == index ? Colors.red : Colors.black,
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w500));
                                                          },),
                                                ),),
                                              ],
                                            );
                                          },
                                        ),
                                      );
                              }
                            ),
                            ValueListenableBuilder(valueListenable: bloc.tenantLoader, builder: (context, bool loading, child) {
                             if(loading){
                               return Expanded(child: Container(
                                 width: 1.sw,
                                 color: Colors.white,
                                 child: const Center(child: CircularProgressIndicator(color: Colors.black,)),
                               ));
                             }
                              return Expanded(
                                child: Provider.value(value: bloc,
                                  child:
                                  FlatList()
                                  ,),
                              );
                            },),
                          ],
                        ),
                      ),


                    if (pageIndex == 1)
                      const SizedBox(
                        height: 20,
                      ),
                    if (pageIndex == 1)
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ValueListenableBuilder(
                                  valueListenable: number,
                                  builder: (context, String num,__) {
                                  return Container(
                                    child: FutureBuilder<List<Catido>>(
                                        future: fetchData1(num),
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
                                                scrollDirection: Axis.vertical,
                                                itemBuilder: (BuildContext context,int len){
                                                  return GestureDetector(
                                                    onTap: () async {
                                                      //  int itemId = abc.data![len].id;
                                                      //int iiid = abc.data![len].PropertyAddress
                                                      /*SharedPreferences prefs = await SharedPreferences.getInstance();
                                    prefs.setString('id_Document', abc.data![len].id.toString());*/
                                                     /* SharedPreferences prefs = await SharedPreferences.getInstance();
                                                      prefs.setInt('id_Building', abc.data![len].id);
                                                      prefs.setString('id_Longitude', abc.data![len].Longitude.toString());
                                                      prefs.setString('id_Latitude', abc.data![len].Latitude.toString());
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute
                                                            (builder: (context) => FileUploadPage())
                                                      );*/

                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute
                                                            (builder: (context) => View_Details_Realestate(iidd: '${abc.data![len].id.toString()}',))
                                                      );

                                                    },
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
                                                          child: Container(
                                                            padding: const EdgeInsets.all(10),
                                                            decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius: BorderRadius.circular(10),
                                                            ),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                                                            height: 200,
                                                                            width: 120,
                                                                            child: CachedNetworkImage(
                                                                              imageUrl:
                                                                              "https://verifyserve.social/"+abc.data![len].Building_image,
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
                                                                        SizedBox(
                                                                          height: 10,
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
                                                                            SizedBox(width: 10,),
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
                                                                                  //w SizedBox(width: 10,),
                                                                                  Text(""+abc.data![len].BHK/*+abc.data![len].Building_Name.toUpperCase()*/,
                                                                                    style: TextStyle(
                                                                                        fontSize: 13,
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
                                                                                border: Border.all(width: 1, color: Colors.tealAccent),
                                                                                boxShadow: [
                                                                                  BoxShadow(
                                                                                      color: Colors.tealAccent.withOpacity(0.5),
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
                                                                                  Text(""+abc.data![len].floor_/*+abc.data![len].Building_Name.toUpperCase()*/,
                                                                                    style: TextStyle(
                                                                                        fontSize: 13,
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
                                                                          height: 10,
                                                                        ),

                                                                        Row(
                                                                          children: [
                                                                            Icon(Iconsax.location_copy,size: 12,color: Colors.red,),
                                                                            SizedBox(width: 2,),
                                                                            Text("Building Sell | Rent & Maintaince",
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
                                                                          height: 5,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            SizedBox(
                                                                              width: 10,
                                                                            ),
                                                                            SizedBox(
                                                                              width: 180,
                                                                              child: Text(""+abc.data![len].Verify_price+"  |  "+abc.data![len].Rent+"  |  "+abc.data![len].maintence,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                maxLines: 2,
                                                                                style: TextStyle(
                                                                                    fontSize: 14,

                                                                                    color: Colors.green,
                                                                                    fontWeight: FontWeight.w700),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          height: 5,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Icon(Iconsax.home_1_copy,size: 12,color: Colors.red,),
                                                                            SizedBox(width: 2,),
                                                                            Text("Sqft | Balcony & Parking",
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
                                                                          height: 5,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            SizedBox(
                                                                              width: 10,
                                                                            ),
                                                                            SizedBox(
                                                                              width: 180,
                                                                              child: Text(""+abc.data![len].sqft+"  |  "+abc.data![len].balcony+"  |  "+abc.data![len].Parking+" Parking" ,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                maxLines: 2,
                                                                                style: TextStyle(
                                                                                    fontSize: 10,
                                                                                    color: Colors.black,
                                                                                    fontWeight: FontWeight.w500
                                                                                ),
                                                                              ),
                                                                            ),

                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          height: 5,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Icon(PhosphorIcons.push_pin,size: 12,color: Colors.red,),
                                                                            SizedBox(width: 2,),
                                                                            Text("Building facilities",
                                                                              style: TextStyle(
                                                                                  fontSize: 11,
                                                                                  color: Colors.black,
                                                                                  fontWeight: FontWeight.w600),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          height: 5,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            SizedBox(
                                                                              width: 10,
                                                                            ),
                                                                            SizedBox(
                                                                              width: 180,
                                                                              child: Text(""+abc.data![len].facility,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                maxLines: 2,
                                                                                style: TextStyle(
                                                                                    fontSize: 10,
                                                                                    color: Colors.black,
                                                                                    fontWeight: FontWeight.w400
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),

                                                                        SizedBox(
                                                                          height: 5,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Icon(PhosphorIcons.address_book,size: 12,color: Colors.red,),
                                                                            SizedBox(width: 2,),
                                                                            Text("Building Information & facilitys",
                                                                              style: TextStyle(
                                                                                  fontSize: 11,
                                                                                  color: Colors.black,
                                                                                  fontWeight: FontWeight.w600),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          height: 5,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            SizedBox(
                                                                              width: 10,
                                                                            ),
                                                                            SizedBox(
                                                                              width: 180,
                                                                              child: Text(""+abc.data![len].Building_information,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                maxLines: 2,
                                                                                style: TextStyle(
                                                                                    fontSize: 10,
                                                                                    color: Colors.black,
                                                                                    fontWeight: FontWeight.w400
                                                                                ),
                                                                              ),
                                                                            ),

                                                                          ],
                                                                        ),

                                                                        SizedBox(
                                                                          height: 5,
                                                                        ),




                                                                      ],
                                                                    ),




                                                                  ],
                                                                ),

                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [

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
                                                                          Text(""+abc.data![len].tyope/*+abc.data![len].Building_Name.toUpperCase()*/,
                                                                            style: TextStyle(
                                                                                fontSize: 13,
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
                                                                        border: Border.all(width: 1, color: Colors.purpleAccent),
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                              color: Colors.purpleAccent.withOpacity(0.5),
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
                                                                          Text(""+abc.data![len].Building_Location/*+abc.data![len].Building_Name.toUpperCase()*/,
                                                                            style: TextStyle(
                                                                                fontSize: 13,
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
                                                                          //w SizedBox(width: 10,),
                                                                          Text(""+abc.data![len].buy_Rent/*+abc.data![len].Building_Name.toUpperCase()*/,
                                                                            style: TextStyle(
                                                                                fontSize: 13,
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
                                                                        border: Border.all(width: 1, color: Colors.indigoAccent),
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                              color: Colors.indigoAccent.withOpacity(0.5),
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
                                                                          Text(""+abc.data![len].date/*+abc.data![len].Building_Name.toUpperCase()*/,
                                                                            style: TextStyle(
                                                                                fontSize: 13,
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
                                                  );
                                                });
                                          }


                                        }

                                    ),



                                    /*FutureBuilder<List<Catid>>(
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

              ),*/


                                  );
                                }
                              ),

                            ],
                          ),
                        ),

                        /*DefaultTabController(
                          length: 2,
                          child: Scaffold(
                            backgroundColor: Colors.black,
                            body: Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 5,),
                                  Container(
                                    padding: EdgeInsets.all(3),
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20), color: Colors.grey),
                                    child: TabBar(
                                      indicator: BoxDecoration(
                                        color: Colors.red[500],
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      // ignore: prefer_const_literals_to_create_immutables
                                      tabs: [
                                        Tab(text: 'Documents'),
                                        Tab(text: 'Servant'),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: TabBarView(children: [
                                      DocumentTab(),
                                      ServantTab()
                                    ]
                                      ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )*/

                      ),

                  ],
                );
              }
            );
        }
      ),
      /*floatingActionButton:Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if(pageIndex == 1||pageIndex == 0)FloatingActionButton(

            onPressed: () async{
                Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  AddProperty(id: pageIndex,)),
              );
              },
              backgroundColor: const  Color(0xFF009FE3),
            child: const Icon(
              PhosphorIcons.plus,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 30,)
        ],
      ),*/
    );
  }

  void _loaduserdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _data = prefs.getString('login_number') ?? '';
    });


  }

}
