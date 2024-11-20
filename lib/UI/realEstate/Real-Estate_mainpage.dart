import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../Comingsoon.dart';
import '../../data/model/realestateModel.dart';
import '../../utils/constant.dart';
import '../documents/property menus/Add/servant.dart';
import '../documents/property menus/Add/tenant.dart';
import '../documents/property menus/Main/TenantDetails.dart';
import 'History_Clickdetails.dart';
import 'RealEstate_History.dart';
import 'Residential_filter.dart';
import 'demo.dart';

class aaa {
  final String name;
  final String img;

  aaa(
      {required this.name, required this.img});

  factory aaa.FromJson(Map<String, dynamic>json){
    return aaa(name: json['name'],
        img: json['img']);
  }
}

class Catid{
  final String Typeofproperty;
  final String balcony;
  final String Place_;
  final String Price;
  Catid({required this.Typeofproperty,required this.balcony,required this.Place_,required this.Price});
  factory Catid.FromJson(Map<String,dynamic>json){
    return Catid(Typeofproperty: json['Typeofproperty'],balcony: json['balcony'],Place_: json['Place_'],Price: json['Price']);

  }
}

class Item {
  final String Typeofproperty;
  final String balcony;
  final String Place_;
  final String Price;
  Item({required this.Typeofproperty,required this.balcony,required this.Place_,required this.Price});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(Typeofproperty: json['Typeofproperty'],balcony: json['balcony'],Place_: json['Place_'],Price: json['Price']
    );
  }
}

Future<List<Item>> fetchItems() async {
  final response = await http.get(Uri.parse('https://verifyserve.social/WebService4.asmx/Show_proprty_by_typeproperty?Typeofproperty=Flat'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((item) => Item.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load items');
  }
}

class realestate_mainpage extends StatefulWidget {
  const realestate_mainpage({super.key});

  @override
  State<realestate_mainpage> createState() => _realestate_mainpageState();
}

class _realestate_mainpageState extends State<realestate_mainpage> {


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

  Future<List<aaa>> health() async {
    var url = Uri.parse('https://verifyserve.social/WebService3_ServiceWork.asmx/health_insu');
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      List listresponce = json.decode(responce.body);
      return listresponce.map((data) => aaa.FromJson(data)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }


/*  Future<List<aaaa>> fetchData() async {
    var url = Uri.parse('https://verifyserve.social/WebService4.asmx/Show_Verify_AddTenant_Under_Property_Table?TUP_id=4');
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      List listresponce = json.decode(responce.body);
      return listresponce.map((data) => aaaa.FromJson(data)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }*/

  Future<List<Catid>> fetchData() async{

    var url = Uri.parse('https://verifyserve.social/WebService4.asmx/Show_proprty_by_typeproperty?Typeofproperty=Flat');
    final responce = await http.get(url);
    print("Hello"+responce.body);
    if (responce.statusCode == 200) {
      List listresponce = json.decode(responce.body);
      return listresponce.map((data) => Catid.FromJson(data)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<Catid>> fetchData2() async {
    var url = Uri.parse("https://verifyserve.social/WebService4.asmx/show_RealEstate_by_subid_ownernumber?Owner_Number=8447714676&Subid=1");
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      List listresponce = json.decode(responce.body);
      return listresponce.map((data) => Catid.FromJson(data)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }
  late Future<List<Item>> futureItems;

  @override
  void initState() {
    super.initState();
    futureItems = fetchItems();
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
          length: 3,
          child: Padding(
            padding: const EdgeInsets.only(left: 5,right: 5,top: 5),
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
                      Tab(text: 'Residential'),
                      Tab(text: 'Plots'),
                      Tab(text: 'Commercial'),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(children: [
                    Residential_filter(),
                    Residential_filter(),
                    Residential_filter()
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
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              FutureBuilder<List<RealstateModel>>(
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
                    );
                  }
                },
              ),

              const SizedBox(
                height: 20,
              ),

              Container(
                height: 45,
                width: 1.sw,
                margin: const EdgeInsets.symmetric(horizontal: 0,vertical: 0),
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
              ),

              const SizedBox(
                height: 20,
              ),

              /*Column(
                children: [
                  HorizontalListView()
                ],
              ),*/
              //HorizontalListView(),

              Container(
                child: Column(
                  children: [
                    Text('Health Insurance',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',
                      letterSpacing: 0,
                      //decoration: TextDecoration.underline,decorationColor: Colors.blue,
                      decorationStyle: TextDecorationStyle.solid,
                      decorationThickness: 2.0,
                    ),),

                    SizedBox(height: 20,),

                    Expanded(
                      child: FutureBuilder<List<Catid>>(
                          future: fetchData(),
                          builder: (context, abc) {
                            if(abc.hasData){
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: abc.data!.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int len) {
                                  return GestureDetector(

                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => coming()),
                                      );
                                    },

                                    child: Container(
                                      width: 300,
                                      margin: EdgeInsets.only(
                                          bottom: 10, top: 10, left: 10, right: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.white, borderRadius: BorderRadius.circular(10)),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 170,
                                            width: 1.sw,
                                            child:  ClipRRect(
                                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                                              child:  CachedNetworkImage(
                                                imageUrl:
                                                //"http://www.verifyserve.social/upload/${widget.data[index].img}",
                                                "https://www.verifyserve.social/upload/drycleanner.JPG",
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
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(""+abc.data![len].Typeofproperty,style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13
                                                ),),
                                                const SizedBox(width: 10,),
                                                Text("For Rent"+abc.data![len].balcony,
                                                  style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500,fontSize: 13),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 7),
                                            width: 310,
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.location_on,
                                                  size: 20,
                                                  color: Colors.blue,
                                                ),
                                                Text(""+abc.data![len].Place_,style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                ),),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 12),
                                            child: Text(
                                              "₹ "+abc.data![len].Price,
                                              style: const TextStyle(color: Colors.green,fontWeight: FontWeight.w500,fontSize: 14),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                            else if(abc.hasError){
                              return Text(abc.error.toString());

                            }
                            else if((abc.connectionState == ConnectionState.waiting)){
                              LinearProgressIndicator(
                                color: Colors.black87,
                              );
                            }
                            return LinearProgressIndicator(
                              color: Colors.black87,
                            );

                            //demo



                          }
                      ),
                    ),

                  ],
                ),
              ),






              const SizedBox(
                height: 20,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("For Office",style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,),),
                  )
                ],
              ),

              Container(
                width: 300,
                margin: EdgeInsets.only(
                    bottom: 10, top: 10, left: 10, right: 10),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 170,
                      width: 1.sw,
                      child:  ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        child:  CachedNetworkImage(
                          imageUrl:
                          //"http://www.verifyserve.social/upload/${widget.data[index].img}",
                          "https://www.verifyserve.social/upload/drycleanner.JPG",
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
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text("widget.data[index].title ??",style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13
                          ),)),
                          const SizedBox(width: 10,),
                          Text("For Rent",
                            style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500,fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      width: 310,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 20,
                            color: Colors.blue,
                          ),
                          Text("widget.data[index].location??",style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        "₹ {widget.data[index].price}",
                        style: const TextStyle(color: Colors.green,fontWeight: FontWeight.w500,fontSize: 14),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("For Shops",style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,),),
                  )
                ],
              ),

              Container(
                width: 300,
                margin: EdgeInsets.only(
                    bottom: 10, top: 10, left: 10, right: 10),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 170,
                      width: 1.sw,
                      child:  ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        child:  CachedNetworkImage(
                          imageUrl:
                          //"http://www.verifyserve.social/upload/${widget.data[index].img}",
                          "https://www.verifyserve.social/upload/drycleanner.JPG",
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
                        /* FadeInImage.assetNetwork(
                          image: "http://www.verifyserve.social/upload/${widget.data[index].imagesh}",
                          // height: 60.h,
                          // width: 120.w,
                          fit: BoxFit.cover,
                          placeholder: AppImages.loading,
                          imageErrorBuilder: (context, error, stack) => Image.asset(
                            AppImages.imageNotFound,
                            fit: BoxFit.cover,
                            // height: 60.h,
                            // width: 120.w,
                          ),
                        ),*/
                      ),
                    ),
                    /*ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          child: Image.network(
                            "http://www.verifyserve.social/upload/${data[index].imagesh}",
                            fit: BoxFit.cover,
                          ))),*/
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text("widget.data[index].title ??",style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13
                          ),)),
                          const SizedBox(width: 10,),
                          Text("For Rent",
                            style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500,fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      width: 310,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 20,
                            color: Colors.blue,
                          ),
                          Text("widget.data[index].location??",style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        "₹ {widget.data[index].price}",
                        style: const TextStyle(color: Colors.green,fontWeight: FontWeight.w500,fontSize: 14),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("For Commercial Space",style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,),),
                  )
                ],
              ),

              Container(
                width: 300,
                margin: EdgeInsets.only(
                    bottom: 10, top: 10, left: 10, right: 10),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 170,
                      width: 1.sw,
                      child:  ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        child:  CachedNetworkImage(
                          imageUrl:
                          //"http://www.verifyserve.social/upload/${widget.data[index].img}",
                          "https://www.verifyserve.social/upload/drycleanner.JPG",
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
                        /* FadeInImage.assetNetwork(
                          image: "http://www.verifyserve.social/upload/${widget.data[index].imagesh}",
                          // height: 60.h,
                          // width: 120.w,
                          fit: BoxFit.cover,
                          placeholder: AppImages.loading,
                          imageErrorBuilder: (context, error, stack) => Image.asset(
                            AppImages.imageNotFound,
                            fit: BoxFit.cover,
                            // height: 60.h,
                            // width: 120.w,
                          ),
                        ),*/
                      ),
                    ),
                    /*ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          child: Image.network(
                            "http://www.verifyserve.social/upload/${data[index].imagesh}",
                            fit: BoxFit.cover,
                          ))),*/
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text("widget.data[index].title ??",style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13
                          ),)),
                          const SizedBox(width: 10,),
                          Text("For Rent",
                            style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500,fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      width: 310,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 20,
                            color: Colors.blue,
                          ),
                          Text("widget.data[index].location??",style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        "₹ {widget.data[index].price}",
                        style: const TextStyle(color: Colors.green,fontWeight: FontWeight.w500,fontSize: 14),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("For Villa",style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,),),
                  )
                ],
              ),

              Container(
                width: 300,
                margin: EdgeInsets.only(
                    bottom: 10, top: 10, left: 10, right: 10),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 170,
                      width: 1.sw,
                      child:  ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        child:  CachedNetworkImage(
                          imageUrl:
                          //"http://www.verifyserve.social/upload/${widget.data[index].img}",
                          "https://www.verifyserve.social/upload/drycleanner.JPG",
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
                        /* FadeInImage.assetNetwork(
                          image: "http://www.verifyserve.social/upload/${widget.data[index].imagesh}",
                          // height: 60.h,
                          // width: 120.w,
                          fit: BoxFit.cover,
                          placeholder: AppImages.loading,
                          imageErrorBuilder: (context, error, stack) => Image.asset(
                            AppImages.imageNotFound,
                            fit: BoxFit.cover,
                            // height: 60.h,
                            // width: 120.w,
                          ),
                        ),*/
                      ),
                    ),
                    /*ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          child: Image.network(
                            "http://www.verifyserve.social/upload/${data[index].imagesh}",
                            fit: BoxFit.cover,
                          ))),*/
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text("widget.data[index].title ??",style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13
                          ),)),
                          const SizedBox(width: 10,),
                          Text("For Rent",
                            style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500,fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      width: 310,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 20,
                            color: Colors.blue,
                          ),
                          Text("widget.data[index].location??",style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        "₹ {widget.data[index].price}",
                        style: const TextStyle(color: Colors.green,fontWeight: FontWeight.w500,fontSize: 14),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("For Farms",style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,),),
                  )
                ],
              ),

              Container(
                width: 300,
                margin: EdgeInsets.only(
                    bottom: 10, top: 10, left: 10, right: 10),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 170,
                      width: 1.sw,
                      child:  ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        child:  CachedNetworkImage(
                          imageUrl:
                          //"http://www.verifyserve.social/upload/${widget.data[index].img}",
                          "https://www.verifyserve.social/upload/drycleanner.JPG",
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
                        /* FadeInImage.assetNetwork(
                          image: "http://www.verifyserve.social/upload/${widget.data[index].imagesh}",
                          // height: 60.h,
                          // width: 120.w,
                          fit: BoxFit.cover,
                          placeholder: AppImages.loading,
                          imageErrorBuilder: (context, error, stack) => Image.asset(
                            AppImages.imageNotFound,
                            fit: BoxFit.cover,
                            // height: 60.h,
                            // width: 120.w,
                          ),
                        ),*/
                      ),
                    ),
                    /*ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          child: Image.network(
                            "http://www.verifyserve.social/upload/${data[index].imagesh}",
                            fit: BoxFit.cover,
                          ))),*/
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text("widget.data[index].title ??",style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13
                          ),)),
                          const SizedBox(width: 10,),
                          Text("For Rent",
                            style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500,fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      width: 310,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 20,
                            color: Colors.blue,
                          ),
                          Text("widget.data[index].location??",style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        "₹ {widget.data[index].price}",
                        style: const TextStyle(color: Colors.green,fontWeight: FontWeight.w500,fontSize: 14),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("For Plots",style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,),),
                  )
                ],
              ),

              Container(
                width: 300,
                margin: EdgeInsets.only(
                    bottom: 10, top: 10, left: 10, right: 10),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 170,
                      width: 1.sw,
                      child:  ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        child:  CachedNetworkImage(
                          imageUrl:
                          //"http://www.verifyserve.social/upload/${widget.data[index].img}",
                          "https://www.verifyserve.social/upload/drycleanner.JPG",
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
                        /* FadeInImage.assetNetwork(
                          image: "http://www.verifyserve.social/upload/${widget.data[index].imagesh}",
                          // height: 60.h,
                          // width: 120.w,
                          fit: BoxFit.cover,
                          placeholder: AppImages.loading,
                          imageErrorBuilder: (context, error, stack) => Image.asset(
                            AppImages.imageNotFound,
                            fit: BoxFit.cover,
                            // height: 60.h,
                            // width: 120.w,
                          ),
                        ),*/
                      ),
                    ),
                    /*ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          child: Image.network(
                            "http://www.verifyserve.social/upload/${data[index].imagesh}",
                            fit: BoxFit.cover,
                          ))),*/
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text("widget.data[index].title ??",style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13
                          ),)),
                          const SizedBox(width: 10,),
                          Text("For Rent",
                            style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500,fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      width: 310,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 20,
                            color: Colors.blue,
                          ),
                          Text("widget.data[index].location??",style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        "₹ {widget.data[index].price}",
                        style: const TextStyle(color: Colors.green,fontWeight: FontWeight.w500,fontSize: 14),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),

            ],
          )
      ),
    );
  }
}
class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  GradientButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Makes the button match parent width
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange, Colors.pink],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 2.0,
          ),
        ),
      ),
    );
  }
}
