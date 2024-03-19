import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

import '../../utils/constant.dart';

class Detail_model {
  //final int id;
  final String Imagesh;
  final String Tital;
  final String locationh;
  final String priceh;
  final String Rname;
  final String Rtype;
  final String filterlocation;
  final String bhk;
  final String shortdis;
  final String furnished;
  final String speci;
  final String details;

  Detail_model(
      {required this.Imagesh, required this.Tital, required this.locationh, required this.priceh,
        required this.Rname, required this.Rtype, required this.filterlocation, required this.bhk,
        required this.shortdis, required this.furnished, required this.speci, required this.details});

  factory Detail_model.FromJson(Map<String, dynamic>json){
    return Detail_model(Imagesh: json['Imagesh'],
        Tital: json['Tital'],
        locationh: json['locationh'],
        priceh: json['priceh'],
        Rname: json['Rname'],
        Rtype: json['Rtype'],
        filterlocation: json['filterlocation'],
        bhk: json['bhk'],
        shortdis: json['shortdis'],
        furnished: json['furnished'],
        speci: json['speci'],
        details: json['details']);
  }
}

class HistoryClick_Details extends StatefulWidget {
  final int iidd;
  const HistoryClick_Details({Key? key, required this.iidd}) : super(key: key);

  @override
  State<HistoryClick_Details> createState() => _HistoryClick_DetailsState();
}

class _HistoryClick_DetailsState extends State<HistoryClick_Details> {

  //late TabController _tabController;

  Future<List<Detail_model>> fetchData(id) async {
    var url = Uri.parse('https://verifyserve.social/WebService1.asmx/Show_realestate_detail?id=$id');
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      List listresponce = json.decode(responce.body);
      return listresponce.map((data) => Detail_model.FromJson(data)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  @override
  void initState() {
    super.initState();
   // _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Image.asset(AppImages.verify, height: 55),
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

        body: FutureBuilder<List<Detail_model>>(
            future: fetchData(widget.iidd),
            builder: (context,abc) {
            return ListView.builder(
              //itemCount: abc.data!.length,
                itemCount: 1,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context,int len) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                            "http://www.verifyserve.social/upload/${abc.data![len].Imagesh}",
                            width: 1.sw,
                            height: 0.3.sh,
                            fit: BoxFit.fill,
                            placeholder: (context, url) => Image.asset(
                              AppImages.loading,
                              width: 1.sw,
                              height: 0.3.sh,
                              fit: BoxFit.fill,
                            ),
                            errorWidget: (context, error, stack) =>
                                Image.asset(
                                  AppImages.imageNotFound,
                                  width: 1.sw,
                                  height: 0.3.sh,
                                  fit: BoxFit.fill,
                                ),
                          ),
                          /*Image.network(
                                    "http://www.verifyserve.social/upload/${bloc.buyRentDetailsData.first.imagesh}",
                                    width: 1.sw,
                                    height: 0.3.sh,
                                    fit: BoxFit.fill,
                                  ),*/
                          Positioned(
                              top: 20,
                              left: 10,
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: Colors.black,
                                    ),
                                  ))),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              abc.data![len].Tital,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "${abc.data![len].locationh} ${abc.data![len].filterlocation}" ??
                                      "",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              abc.data![len].shortdis ?? "",
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Facilities",
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 50,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white.withOpacity(0.1),
                                      ),
                                      padding: EdgeInsets.all(10),
                                      child: InkWell(
                                        onTap: () {},
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              PhosphorIcons.house_fill,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              abc.data![len].Rtype ?? "",
                                              style:
                                              TextStyle(color: Colors.white),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white.withOpacity(0.1),
                                      ),
                                      padding: EdgeInsets.all(10),
                                      child: InkWell(
                                        onTap: () {},
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              PhosphorIcons.bed_fill,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              abc.data![len].bhk ?? "",
                                              style:
                                              TextStyle(color: Colors.white),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white.withOpacity(0.1),
                                      ),
                                      padding: EdgeInsets.all(10),
                                      child: InkWell(
                                        onTap: () {},
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              PhosphorIcons.armchair_fill,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              abc.data![len].furnished ?? "",
                                              style:
                                              TextStyle(color: Colors.white),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 10,
                            ),
                            /*SizedBox(
                              height: 40,
                              child: TabBar(
                                //controller: _tabController,
                                tabs: [
                                  Text("Specifications",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18)),
                                  Text("Details",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18)),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 0.5.sw,
                              child: TabBarView(
                                //controller: _tabController,
                                children: [
                                  SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10.0,left: 10,top: 10,bottom: 10),
                                      child: Text(
                                        abc.data![len].speci ?? "",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10.0,left: 10,top: 10,bottom: 10),
                                      child: Text(
                                        abc.data![len].details ?? "",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),*/
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
            );
          }
        ),

      ),
    );
  }
}
