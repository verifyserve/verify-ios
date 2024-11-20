import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:verify/UI/realEstate/real_estateDeatail.dart';

import '../../data/model/realestateModel.dart';
import '../../utils/constant.dart';
import 'RealEstate_History.dart';
import 'Residential_filter.dart';
import 'filter/Commercial_property_Filter.dart';
import 'filter/Filter_Options.dart';
import 'filter/See_All_Pager.dart';


class Catid {
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
  final String Ownername;
  final String Owner_number;
  final String Caretaker_name;
  final String Caretaker_number;

  Catid(
      {required this.id, required this.Building_Name, required this.Building_Address, required this.Building_Location, required this.Building_image, required this.Longitude, required this.Latitude, required this.Rent, required this.Verify_price, required this.BHK, required this.sqft, required this.tyope, required this.floor_, required this.maintence, required this.buy_Rent,
        required this.Building_information,required this.balcony,required this.Parking,required this.facility,required this.Furnished,required this.kitchen,required this.Baathroom,required this.Ownername,required this.Owner_number,
        required this.Caretaker_name,required this.Caretaker_number});

  factory Catid.FromJson(Map<String, dynamic>json){
    return Catid(id: json['PVR_id'],
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
        Ownername: json['Ownername'],
        Owner_number: json['Owner_number'],
        Caretaker_name: json['Water_geyser'],
        Caretaker_number: json['CareTaker_number']);
  }
}


class SliverListExample extends StatefulWidget {
  @override
  _SliverListExampleState createState() => _SliverListExampleState();
}

class _SliverListExampleState extends State<SliverListExample> {


  Future<List<Catid>> fetchData1() async {
    var url = Uri.parse('https://verifyserve.social/WebService4.asmx/Show_typeofproperty_lookingproperty?Typeofproperty=Flat&Looking_Property_=Flat');
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      List listresponce = json.decode(responce.body);
      listresponce.sort((a, b) => b['PVR_id'].compareTo(a['PVR_id']));
      return listresponce.map((data) => Catid.FromJson(data)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<Catid>> fetchData_Shop() async {
    var url = Uri.parse('https://verifyserve.social/WebService4.asmx/Show_typeofproperty_lookingproperty?Typeofproperty=Shop&Looking_Property_=Flat');
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      List listresponce = json.decode(responce.body);
      listresponce.sort((a, b) => b['PVR_id'].compareTo(a['PVR_id']));
      return listresponce.map((data) => Catid.FromJson(data)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<Catid>> fetchData_Office() async {
    var url = Uri.parse('https://verifyserve.social/WebService4.asmx/Show_typeofproperty_lookingproperty?Typeofproperty=Office&Looking_Property_=Flat');
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      List listresponce = json.decode(responce.body);
      listresponce.sort((a, b) => b['PVR_id'].compareTo(a['PVR_id']));
      return listresponce.map((data) => Catid.FromJson(data)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<Catid>> fetchData_Plots() async {
    var url = Uri.parse('https://verifyserve.social/WebService4.asmx/Show_typeofproperty_lookingproperty?Typeofproperty=Plots&Looking_Property_=Flat');
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      List listresponce = json.decode(responce.body);
      listresponce.sort((a, b) => b['PVR_id'].compareTo(a['PVR_id']));
      return listresponce.map((data) => Catid.FromJson(data)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<Catid>> fetchData_FarmsVilla() async {
    var url = Uri.parse('https://verifyserve.social/WebService4.asmx/Show_typeofproperty_lookingproperty?Typeofproperty=Farms&Looking_Property_=Flat');
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      List listresponce = json.decode(responce.body);
      listresponce.sort((a, b) => b['PVR_id'].compareTo(a['PVR_id']));
      return listresponce.map((data) => Catid.FromJson(data)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<Catid>> fetchData_Godown() async {
    var url = Uri.parse('https://verifyserve.social/WebService4.asmx/Show_typeofproperty_lookingproperty?Typeofproperty=Godown&Looking_Property_=Flat');
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      List listresponce = json.decode(responce.body);
      listresponce.sort((a, b) => b['PVR_id'].compareTo(a['PVR_id']));
      return listresponce.map((data) => Catid.FromJson(data)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  //For Real Estate Slider
  Future<List<RealstateModel>> fetchCarouselData() async {
    final response = await http.get(Uri.parse('https://verifyserve.social/WebService1.asmx/ShowRealestateimg'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) {
        return RealstateModel(
          rimage: item['Rimage'],
        );
      }).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  void _showBottomSheet(BuildContext context) {

    List<String> timing = [
      "Residential",
      "Plots",
      "Commercial",
    ];
    ValueNotifier<int> timingIndex = ValueNotifier(0);

    String displayedData = "Press a button to display data";

    void updateData(String newData) {
      setState(() {
        displayedData = newData;
      });
    }

    showModalBottomSheet(
      backgroundColor: Colors.black,
      context: context,
      builder: (BuildContext context) {
        return  DefaultTabController(
          length: 2,
          child: Padding(
            padding: EdgeInsets.only(left: 5,right: 5,top: 0, bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5,),
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  padding: EdgeInsets.all(3),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), color: Colors.grey),
                  child: TabBar(
                    indicator: BoxDecoration(
                      color: Colors.red[500],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // ignore: prefer_const_literals_to_create_immutables
                    tabs: [
                      Tab(text: 'Residential'),
                      Tab(text: 'Commercial'),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(children: [
                    Filter_Options(),
                    Commercial_Filter()
                  ]),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Image.asset(AppImages.verify, height: 75),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context, true);

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
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Realestate_history()));
            },
            child: const Icon(
              PhosphorIcons.timer,
              size: 25,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [

          /*SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return FutureBuilder<List<RealstateModel>>(
                  future: fetchCarouselData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData) {
                      return Center(child: Text('No data available.'));
                    } else {
                      return Container(
                        margin: EdgeInsets.only(top: 20),
                        child: CarouselSlider(
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
                                  width: 320,
                                  child: ClipRRect(
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                      "https://www.verifyserve.social/upload/${item.rimage}",
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
                        ),
                      );
                    }
                  },
                );
              },
              childCount: 1, // Number of categories
            ),
          ),*/

          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return Container(
                  height: 45,
                  width: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 0,vertical: 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.pink, Colors.red],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: (){
                      _showBottomSheet(context);
                    },
                    child: Text(
                      "Find Property",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                );
              },
              childCount: 1, // Number of categories
            ),
          ),

          SliverList(

            delegate: SliverChildBuilderDelegate(
                  (context, index) {

                return FutureBuilder<List<Catid>>(
                  future: fetchData1(),
                  builder: (context, abc) {
                    if (abc.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (abc.hasError) {
                      return Center(child: Text('Error: ${abc.error}'));
                    } else if (!abc.hasData || abc.data!.isEmpty) {
                      return Center(child: Text('No data available'));
                    } else {
                      final data = abc.data!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'For Flat',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Show_See_All(iid: 'Flat',)));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Text(
                                      'See All',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.red
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 350,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: data.length,
                              itemBuilder: (BuildContext context,int len) {
                                return GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute
                                          (builder: (context) => RealEstateDetaill(iid: '${abc.data![len].id}',))
                                    );
                                  },
                                  child: Container(
                                    width: 310,
                                    margin: EdgeInsets.only(
                                        bottom: 10, top: index == 0 ? 10 : 10, left:5, right: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 200,
                                          width: 310,
                                          child:ClipRRect(
                                            borderRadius: const BorderRadius.only(topLeft:Radius.circular(5),topRight: Radius.circular(5)),
                                            child:  CachedNetworkImage(
                                              imageUrl:
                                              "https://www.verifyserve.social/${abc.data![len].Building_image}",
                                              // height: 60.h,
                                              // width: 120.w,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) => Image.asset(
                                                AppImages.loading,
                                                // height: 60.h,
                                                // width: 120.w,
                                                fit: BoxFit.cover,
                                              ),
                                              errorWidget: (context, error, stack) =>
                                                  Image.asset(
                                                    AppImages.imageNotFound,
                                                    // height: 60.h,
                                                    // width: 120.w,
                                                    fit: BoxFit.cover,
                                                  ),
                                            ),
                                          ),
                                        ),

                                        const SizedBox(
                                          height: 10,
                                        ),

                                        Row(
                                          children: [

                                            SizedBox(
                                              width: 5,
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
                                                  Text(""+abc.data![len].tyope.toUpperCase()/*+abc.data![len].Building_Name.toUpperCase()*/,
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
                                                children: <Widget> [
                                                  // Icon(Iconsax.sort_copy,size: 15,),
                                                  //SizedBox(width: 10,),
                                                  /*if (abc.data![len].Rent != "Rent") Text("For Rent".toUpperCase(),
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w500,
                                                        letterSpacing: 0.5
                                                    ),
                                                  ),

                                                  if (abc.data![len].Rent != "Buy") Text("For Sell".toUpperCase(),
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w500,
                                                        letterSpacing: 0.5
                                                    ),
                                                  ),*/

                                                    Text(""+abc.data![len].buy_Rent.toUpperCase(),
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
                                                border: Border.all(width: 1, color: Colors.pink),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.pink
                                                          .withOpacity(0.5),
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
                                                  Text(""+abc.data![len].BHK.toUpperCase()/*+abc.data![len].Building_Name.toUpperCase()*/,
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
                                                border: Border.all(width: 1, color: Colors.yellow),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.yellow.withOpacity(0.5),
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
                                                  Text(""+abc.data![len].floor_.toUpperCase()/*+abc.data![len].Building_Name.toUpperCase()*/,
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
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                              children: [

                                                SizedBox(width: 5,),
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
                                                      Text(""+abc.data![len].Building_Location, maxLines: 2,
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.w500,
                                                          letterSpacing: 0.5,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 12),
                                              child: Text(
                                                "₹ ${abc.data![len].Rent}${abc.data![len].Verify_price}",
                                                style: const TextStyle(color: Colors.green,fontWeight: FontWeight.w500,fontSize: 22),
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                          height: 10,
                                        ),

                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal:5),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Icon(
                                                Icons.location_city_rounded,
                                                size: 20,
                                                color: Colors.blue,
                                              ),
                                              Expanded(

                                                  child: Text("${abc.data![len].Building_information}" ,
                                                    maxLines: 5,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 10,
                                                        color: Colors.black
                                                    ),
                                                  )
                                              ),

                                            ],
                                          ),
                                        ),

                                        SizedBox(height: 10,),



                                        // const SizedBox(
                                        //   height: 10,
                                        // )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  },
                );
              },
              childCount: 1, // Number of categories
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return FutureBuilder<List<Catid>>(
                  future: fetchData_Shop(),
                  builder: (context, abc) {
                    if (abc.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (abc.hasError) {
                      return Center(child: Text('Error: ${abc.error}'));
                    } else if (!abc.hasData || abc.data!.isEmpty) {
                      return Center(child: Text('No data available'));
                    } else {
                      final data = abc.data!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'For Shops',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Show_See_All(iid: 'Shop',)));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Text(
                                      'See All',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.red
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),

                          SizedBox(
                            height: 350,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: data.length,
                              itemBuilder: (BuildContext context,int len) {
                                return GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute
                                          (builder: (context) => RealEstateDetaill(iid: '${abc.data![len].id}',))
                                    );
                                  },
                                  child: Container(
                                    width: 310,
                                    margin: EdgeInsets.only(
                                        bottom: 10, top: index == 0 ? 10 : 10, left:5, right: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 200,
                                          width: 310,
                                          child:ClipRRect(
                                            borderRadius: const BorderRadius.only(topLeft:Radius.circular(5),topRight: Radius.circular(5)),
                                            child:  CachedNetworkImage(
                                              imageUrl:
                                              "https://www.verifyserve.social/${abc.data![len].Building_image}",
                                              // height: 60.h,
                                              // width: 120.w,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) => Image.asset(
                                                AppImages.loading,
                                                // height: 60.h,
                                                // width: 120.w,
                                                fit: BoxFit.cover,
                                              ),
                                              errorWidget: (context, error, stack) =>
                                                  Image.asset(
                                                    AppImages.imageNotFound,
                                                    // height: 60.h,
                                                    // width: 120.w,
                                                    fit: BoxFit.cover,
                                                  ),
                                            ),
                                          ),
                                        ),

                                        const SizedBox(
                                          height: 10,
                                        ),

                                        Row(
                                          children: [

                                            SizedBox(
                                              width: 5,
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
                                                  Text(""+abc.data![len].tyope.toUpperCase()/*+abc.data![len].Building_Name.toUpperCase()*/,
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
                                                children: <Widget> [
                                                  // Icon(Iconsax.sort_copy,size: 15,),
                                                  //SizedBox(width: 10,),
                                                  /*if (abc.data![len].Rent != "Rent") Text("For Rent".toUpperCase(),
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w500,
                                                        letterSpacing: 0.5
                                                    ),
                                                  ),

                                                  if (abc.data![len].Rent != "Buy") Text("For Sell".toUpperCase(),
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w500,
                                                        letterSpacing: 0.5
                                                    ),
                                                  ),*/

                                                  Text(""+abc.data![len].buy_Rent.toUpperCase(),
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
                                                border: Border.all(width: 1, color: Colors.yellow),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.yellow.withOpacity(0.5),
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
                                                  Text(""+abc.data![len].floor_.toUpperCase()/*+abc.data![len].Building_Name.toUpperCase()*/,
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
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                              children: [

                                                SizedBox(width: 5,),
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
                                                      Text(""+abc.data![len].Building_Location, maxLines: 2,
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.w500,
                                                          letterSpacing: 0.5,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 12),
                                              child: Text(
                                                "₹ ${abc.data![len].Rent}${abc.data![len].Verify_price}",
                                                style: const TextStyle(color: Colors.green,fontWeight: FontWeight.w500,fontSize: 22),
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                          height: 10,
                                        ),

                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal:5),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Icon(
                                                Icons.location_city_rounded,
                                                size: 20,
                                                color: Colors.blue,
                                              ),
                                              Expanded(

                                                  child: Text("${abc.data![len].Building_information}" ,
                                                    maxLines: 5,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 10,
                                                        color: Colors.black
                                                    ),
                                                  )
                                              ),

                                            ],
                                          ),
                                        ),

                                        SizedBox(height: 10,),



                                        // const SizedBox(
                                        //   height: 10,
                                        // )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  },
                );
              },
              childCount: 1, // Number of categories
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return FutureBuilder<List<Catid>>(
                  future: fetchData_Office(),
                  builder: (context, abc) {
                    if (abc.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (abc.hasError) {
                      return Center(child: Text('Error: ${abc.error}'));
                    } else if (!abc.hasData || abc.data!.isEmpty) {
                      return Center(child: Text('No data available'));
                    } else {
                      final data = abc.data!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'For Office',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Show_See_All(iid: 'Office',)));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Text(
                                      'See All',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.red
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 350,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: data.length,
                              itemBuilder: (BuildContext context,int len) {
                                return GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute
                                          (builder: (context) => RealEstateDetaill(iid: '${abc.data![len].id}',))
                                    );
                                  },
                                  child: Container(
                                    width: 310,
                                    margin: EdgeInsets.only(
                                        bottom: 10, top: index == 0 ? 10 : 10, left:5, right: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 200,
                                          width: 310,
                                          child:ClipRRect(
                                            borderRadius: const BorderRadius.only(topLeft:Radius.circular(5),topRight: Radius.circular(5)),
                                            child:  CachedNetworkImage(
                                              imageUrl:
                                              "https://www.verifyserve.social/${abc.data![len].Building_image}",
                                              // height: 60.h,
                                              // width: 120.w,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) => Image.asset(
                                                AppImages.loading,
                                                // height: 60.h,
                                                // width: 120.w,
                                                fit: BoxFit.cover,
                                              ),
                                              errorWidget: (context, error, stack) =>
                                                  Image.asset(
                                                    AppImages.imageNotFound,
                                                    // height: 60.h,
                                                    // width: 120.w,
                                                    fit: BoxFit.cover,
                                                  ),
                                            ),
                                          ),
                                        ),

                                        const SizedBox(
                                          height: 10,
                                        ),

                                        Row(
                                          children: [

                                            SizedBox(
                                              width: 5,
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
                                                  Text(""+abc.data![len].tyope.toUpperCase()/*+abc.data![len].Building_Name.toUpperCase()*/,
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
                                                children: <Widget> [
                                                  // Icon(Iconsax.sort_copy,size: 15,),
                                                  //SizedBox(width: 10,),
                                                  /*if (abc.data![len].Rent != "Rent") Text("For Rent".toUpperCase(),
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w500,
                                                        letterSpacing: 0.5
                                                    ),
                                                  ),

                                                  if (abc.data![len].Rent != "Buy") Text("For Sell".toUpperCase(),
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w500,
                                                        letterSpacing: 0.5
                                                    ),
                                                  ),*/

                                                  Text(""+abc.data![len].buy_Rent.toUpperCase(),
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
                                                border: Border.all(width: 1, color: Colors.yellow),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.yellow.withOpacity(0.5),
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
                                                  Text(""+abc.data![len].floor_.toUpperCase()/*+abc.data![len].Building_Name.toUpperCase()*/,
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
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                              children: [

                                                SizedBox(width: 5,),
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
                                                      Text(""+abc.data![len].Building_Location, maxLines: 2,
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.w500,
                                                          letterSpacing: 0.5,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 12),
                                              child: Text(
                                                "₹ ${abc.data![len].Rent}${abc.data![len].Verify_price}",
                                                style: const TextStyle(color: Colors.green,fontWeight: FontWeight.w500,fontSize: 22),
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                          height: 10,
                                        ),

                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal:5),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Icon(
                                                Icons.location_city_rounded,
                                                size: 20,
                                                color: Colors.blue,
                                              ),
                                              Expanded(

                                                  child: Text("${abc.data![len].Building_information}" ,
                                                    maxLines: 5,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 10,
                                                        color: Colors.black
                                                    ),
                                                  )
                                              ),

                                            ],
                                          ),
                                        ),

                                        SizedBox(height: 10,),



                                        // const SizedBox(
                                        //   height: 10,
                                        // )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  },
                );
              },
              childCount: 1, // Number of categories
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return FutureBuilder<List<Catid>>(
                  future: fetchData_FarmsVilla(),
                  builder: (context, abc) {
                    if (abc.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (abc.hasError) {
                      return Center(child: Text('Error: ${abc.error}'));
                    } else if (!abc.hasData || abc.data!.isEmpty) {
                      return Center(child: Text('No data available'));
                    } else {
                      final data = abc.data!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'For Farms',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 360,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: data.length,
                              itemBuilder: (BuildContext context,int len) {
                                return GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute
                                          (builder: (context) => RealEstateDetaill(iid: '${abc.data![len].id}',))
                                    );
                                  },
                                  child: Container(
                                    width: 310,
                                    margin: EdgeInsets.only(
                                        bottom: 10, top: index == 0 ? 10 : 10, left:5, right: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 200,
                                          width: 310,
                                          child:ClipRRect(
                                            borderRadius: const BorderRadius.only(topLeft:Radius.circular(5),topRight: Radius.circular(5)),
                                            child:  CachedNetworkImage(
                                              imageUrl:
                                              "https://www.verifyserve.social/${abc.data![len].Building_image}",
                                              // height: 60.h,
                                              // width: 120.w,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) => Image.asset(
                                                AppImages.loading,
                                                // height: 60.h,
                                                // width: 120.w,
                                                fit: BoxFit.cover,
                                              ),
                                              errorWidget: (context, error, stack) =>
                                                  Image.asset(
                                                    AppImages.imageNotFound,
                                                    // height: 60.h,
                                                    // width: 120.w,
                                                    fit: BoxFit.cover,
                                                  ),
                                            ),
                                          ),
                                        ),

                                        const SizedBox(
                                          height: 10,
                                        ),

                                        Row(
                                          children: [

                                            SizedBox(
                                              width: 5,
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
                                                  Text(""+abc.data![len].tyope.toUpperCase()/*+abc.data![len].Building_Name.toUpperCase()*/,
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
                                                children: <Widget> [
                                                  // Icon(Iconsax.sort_copy,size: 15,),
                                                  //SizedBox(width: 10,),
                                                  /*if (abc.data![len].Rent != "Rent") Text("For Rent".toUpperCase(),
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w500,
                                                        letterSpacing: 0.5
                                                    ),
                                                  ),

                                                  if (abc.data![len].Rent != "Buy") Text("For Sell".toUpperCase(),
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w500,
                                                        letterSpacing: 0.5
                                                    ),
                                                  ),*/

                                                  Text(""+abc.data![len].buy_Rent.toUpperCase(),
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
                                                border: Border.all(width: 1, color: Colors.yellow),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.yellow.withOpacity(0.5),
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
                                                  Text(""+abc.data![len].floor_.toUpperCase()/*+abc.data![len].Building_Name.toUpperCase()*/,
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
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                              children: [

                                                SizedBox(width: 5,),
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
                                                      Text(""+abc.data![len].Building_Location, maxLines: 2,
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.w500,
                                                          letterSpacing: 0.5,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 12),
                                              child: Text(
                                                "₹ ${abc.data![len].Rent}${abc.data![len].Verify_price}",
                                                style: const TextStyle(color: Colors.green,fontWeight: FontWeight.w500,fontSize: 22),
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                          height: 10,
                                        ),

                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal:5),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Icon(
                                                Icons.location_city_rounded,
                                                size: 20,
                                                color: Colors.blue,
                                              ),
                                              Expanded(

                                                  child: Text("${abc.data![len].Building_information}" ,
                                                    maxLines: 5,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 10,
                                                        color: Colors.black
                                                    ),
                                                  )
                                              ),

                                            ],
                                          ),
                                        ),

                                        SizedBox(height: 10,),



                                        // const SizedBox(
                                        //   height: 10,
                                        // )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  },
                );
              },
              childCount: 1, // Number of categories
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return FutureBuilder<List<Catid>>(
                  future: fetchData_Godown(),
                  builder: (context, abc) {
                    if (abc.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (abc.hasError) {
                      return Center(child: Text('Error: ${abc.error}'));
                    } else if (!abc.hasData || abc.data!.isEmpty) {
                      return Center(child: Text('No data available'));
                    } else {
                      final data = abc.data!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'For Godown',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Show_See_All(iid: 'Godown',)));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Text(
                                      'See All',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.red
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 350,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: data.length,
                              itemBuilder: (BuildContext context,int len) {
                                return GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute
                                          (builder: (context) => RealEstateDetaill(iid: '${abc.data![len].id}',))
                                    );
                                  },
                                  child: Container(
                                    width: 310,
                                    margin: EdgeInsets.only(
                                        bottom: 10, top: index == 0 ? 10 : 10, left:5, right: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 200,
                                          width: 310,
                                          child:ClipRRect(
                                            borderRadius: const BorderRadius.only(topLeft:Radius.circular(5),topRight: Radius.circular(5)),
                                            child:  CachedNetworkImage(
                                              imageUrl:
                                              "https://www.verifyserve.social/${abc.data![len].Building_image}",
                                              // height: 60.h,
                                              // width: 120.w,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) => Image.asset(
                                                AppImages.loading,
                                                // height: 60.h,
                                                // width: 120.w,
                                                fit: BoxFit.cover,
                                              ),
                                              errorWidget: (context, error, stack) =>
                                                  Image.asset(
                                                    AppImages.imageNotFound,
                                                    // height: 60.h,
                                                    // width: 120.w,
                                                    fit: BoxFit.cover,
                                                  ),
                                            ),
                                          ),
                                        ),

                                        const SizedBox(
                                          height: 10,
                                        ),

                                        Row(
                                          children: [

                                            SizedBox(
                                              width: 5,
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
                                                  Text(""+abc.data![len].tyope.toUpperCase()/*+abc.data![len].Building_Name.toUpperCase()*/,
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
                                                children: <Widget> [
                                                  // Icon(Iconsax.sort_copy,size: 15,),
                                                  //SizedBox(width: 10,),
                                                  /*if (abc.data![len].Rent != "Rent") Text("For Rent".toUpperCase(),
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w500,
                                                        letterSpacing: 0.5
                                                    ),
                                                  ),

                                                  if (abc.data![len].Rent != "Buy") Text("For Sell".toUpperCase(),
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w500,
                                                        letterSpacing: 0.5
                                                    ),
                                                  ),*/

                                                  Text(""+abc.data![len].buy_Rent.toUpperCase(),
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
                                                border: Border.all(width: 1, color: Colors.yellow),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.yellow.withOpacity(0.5),
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
                                                  Text(""+abc.data![len].floor_.toUpperCase()/*+abc.data![len].Building_Name.toUpperCase()*/,
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
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                              children: [

                                                SizedBox(width: 5,),
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
                                                      Text(""+abc.data![len].Building_Location, maxLines: 2,
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.w500,
                                                          letterSpacing: 0.5,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 12),
                                              child: Text(
                                                "₹ ${abc.data![len].Rent}${abc.data![len].Verify_price}",
                                                style: const TextStyle(color: Colors.green,fontWeight: FontWeight.w500,fontSize: 22),
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                          height: 10,
                                        ),

                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal:5),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Icon(
                                                Icons.location_city_rounded,
                                                size: 20,
                                                color: Colors.blue,
                                              ),
                                              Expanded(

                                                  child: Text("${abc.data![len].Building_information}" ,
                                                    maxLines: 5,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 10,
                                                        color: Colors.black
                                                    ),
                                                  )
                                              ),

                                            ],
                                          ),
                                        ),

                                        SizedBox(height: 10,),



                                        // const SizedBox(
                                        //   height: 10,
                                        // )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  },
                );
              },
              childCount: 1, // Number of categories
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return FutureBuilder<List<Catid>>(
                  future: fetchData_Plots(),
                  builder: (context, abc) {
                    if (abc.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (abc.hasError) {
                      return Center(child: Text('Error: ${abc.error}'));
                    } else if (!abc.hasData || abc.data!.isEmpty) {
                      return Center(child: Text('No data available'));
                    } else {
                      final data = abc.data!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'For Plots',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 350,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: data.length,
                              itemBuilder: (BuildContext context,int len) {
                                return GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute
                                          (builder: (context) => RealEstateDetaill(iid: '${abc.data![len].id}',))
                                    );
                                  },
                                  child: Container(
                                    width: 310,
                                    margin: EdgeInsets.only(
                                        bottom: 10, top: index == 0 ? 10 : 10, left:5, right: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 200,
                                          width: 310,
                                          child:ClipRRect(
                                            borderRadius: const BorderRadius.only(topLeft:Radius.circular(5),topRight: Radius.circular(5)),
                                            child:  CachedNetworkImage(
                                              imageUrl:
                                              "https://www.verifyserve.social/${abc.data![len].Building_image}",
                                              // height: 60.h,
                                              // width: 120.w,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) => Image.asset(
                                                AppImages.loading,
                                                // height: 60.h,
                                                // width: 120.w,
                                                fit: BoxFit.cover,
                                              ),
                                              errorWidget: (context, error, stack) =>
                                                  Image.asset(
                                                    AppImages.imageNotFound,
                                                    // height: 60.h,
                                                    // width: 120.w,
                                                    fit: BoxFit.cover,
                                                  ),
                                            ),
                                          ),
                                        ),

                                        const SizedBox(
                                          height: 10,
                                        ),

                                        Row(
                                          children: [

                                            SizedBox(
                                              width: 5,
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
                                                  Text(""+abc.data![len].tyope.toUpperCase()/*+abc.data![len].Building_Name.toUpperCase()*/,
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
                                                children: <Widget> [
                                                  // Icon(Iconsax.sort_copy,size: 15,),
                                                  //SizedBox(width: 10,),
                                                  /*if (abc.data![len].Rent != "Rent") Text("For Rent".toUpperCase(),
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w500,
                                                        letterSpacing: 0.5
                                                    ),
                                                  ),

                                                  if (abc.data![len].Rent != "Buy") Text("For Sell".toUpperCase(),
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w500,
                                                        letterSpacing: 0.5
                                                    ),
                                                  ),*/

                                                  Text(""+abc.data![len].buy_Rent.toUpperCase(),
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
                                                border: Border.all(width: 1, color: Colors.pink),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.pink
                                                          .withOpacity(0.5),
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
                                                  Text(""+abc.data![len].BHK.toUpperCase()/*+abc.data![len].Building_Name.toUpperCase()*/,
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
                                                border: Border.all(width: 1, color: Colors.yellow),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.yellow.withOpacity(0.5),
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
                                                  Text(""+abc.data![len].floor_.toUpperCase()/*+abc.data![len].Building_Name.toUpperCase()*/,
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
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                              children: [

                                                SizedBox(width: 5,),
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
                                                      Text(""+abc.data![len].Building_Location, maxLines: 2,
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.w500,
                                                          letterSpacing: 0.5,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 12),
                                              child: Text(
                                                "₹ ${abc.data![len].Rent}${abc.data![len].Verify_price}",
                                                style: const TextStyle(color: Colors.green,fontWeight: FontWeight.w500,fontSize: 22),
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                          height: 10,
                                        ),

                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal:5),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Icon(
                                                Icons.location_city_rounded,
                                                size: 20,
                                                color: Colors.blue,
                                              ),
                                              Expanded(

                                                  child: Text("${abc.data![len].Building_information}" ,
                                                    maxLines: 5,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 10,
                                                        color: Colors.black
                                                    ),
                                                  )
                                              ),

                                            ],
                                          ),
                                        ),

                                        SizedBox(height: 10,),



                                        // const SizedBox(
                                        //   height: 10,
                                        // )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  },
                );
              },
              childCount: 1, // Number of categories
            ),
          ),

        ],
      ),

    );
  }
}
