import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:verify/UI/IT&Designing/it_design_screen.dart';
import 'package:verify/UI/IT&Designing/consultant.dart';

import '../../bloc/consultantBloc.dart';
import '../../bloc/itAndDesignBloc.dart';
import '../../bloc/vehicleBLoc.dart';
import '../../data/model/carImageSlider.dart';
import '../../data/model/itlawyerSlider.dart';
import '../../data/repository/ItAndDesignRepossitory.dart';
import '../../data/repository/consultantRepository.dart';
import '../../data/repository/vehicleRepository.dart';
import '../../utils/constant.dart';
import '../vehicle/VehicalSerices.dart';
import 'package:http/http.dart' as http;

import '../widgets/comingSoon.dart';

class ITLawyer extends StatefulWidget {
  const ITLawyer({Key? key}) : super(key: key);

  @override
  State<ITLawyer> createState() => _ITLawyerState();
}

class _ITLawyerState extends State<ITLawyer> with SingleTickerProviderStateMixin {

  late ConsultantBloc bloc;

 // late TabController _tabController;

  //For It&Lawyer Slider
  Future<List<ItLawyer_Model>> fetchCarouselData() async {
    final response = await http.get(Uri.parse('https://verifyserve.social/WebService1.asmx/ShowItlawyerimg'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) {
        return ItLawyer_Model(
          iimage: item['iimage'],
        );
      }).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    bloc = ConsultantBloc(context.read<ConsultantRepository>());
  //  _tabController = TabController(length: 2, vsync: this);
    super.initState();
    bloc.mainPageGrid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar:AppBar(
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30,),

            FutureBuilder<List<ItLawyer_Model>>(
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
                                "https://www.verifyserve.social/upload/${item.iimage}",
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

            ValueListenableBuilder(
                valueListenable: bloc.mainGridLoader,
                builder: (context,bool loading,_) {
                  if(loading){
                    return const Center(child: CircularProgressIndicator(color: Colors.white,),);
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                    child: Column(
                      children: [
                        /*Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        controller: TextEditingController(),
                        decoration: const InputDecoration(
                          icon: Icon(
                            PhosphorIcons.magnifying_glass,
                            color: Colors.grey,
                            size: 20,
                          ),
                          contentPadding: EdgeInsets.only(top: 0, bottom: 9),
                          border: InputBorder.none,
                          hintText: "Search Here...",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      )),*/
                        const SizedBox(height: 10,),
                        ListView.builder(
                            physics:const ScrollPhysics(),
                            itemCount: bloc.mailList.value.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  // if(index == 0){
                                  //   Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (context) => LawyerList()));
                                  // }
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const ComingSoon(isLeading: true)));
                                },
                                child: Container(
                                  width: 1.sw,
                                  padding: const EdgeInsets.all(5),
                                  margin: const EdgeInsets.only(bottom: 15),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.2),
                                    border: Border.all(color: Colors.white.withOpacity(0.8)),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Row(
                                    children: [
                                      /* Container(
                                  height: 65.h,
                                  width: 120.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.network(
                                        "http://www.verifyserve.social/upload/${bloc.mailList.value[index].aimage}",
                                        fit: BoxFit.cover,
                                      )),
                                ),*/
                                      ClipRRect(
                                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                          "http://www.verifyserve.social/upload/${bloc.mailList.value[index].aimage}",
                                          height: 60.h,
                                          width: 120.w,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => Image.asset(
                                            AppImages.loading,
                                            height: 60.h,
                                            fit: BoxFit.cover,
                                            width: 120.w,
                                          ),
                                          errorWidget: (context, error, stack) =>
                                              Image.asset(
                                                AppImages.imageNotFound,
                                                height: 60.h,
                                                fit: BoxFit.cover,
                                                width: 120.w,
                                              ),
                                        ),
                                        /*FadeInImage.assetNetwork(
                                    image: "http://www.verifyserve.social/upload/${bloc.mailList.value[index].aimage}",
                                    height: 60.h,
                                    width: 120.w,
                                    fit: BoxFit.cover,
                                    placeholder: AppImages.loading,
                                    imageErrorBuilder: (context, error, stack) => Image.asset(
                                      AppImages.imageNotFound,
                                      height: 60.h,
                                      width: 120.w,
                                    ),
                                  ),*/
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          bloc.mailList.value[index].aname ?? "",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.start,
                                          style: const TextStyle
                                            (color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            // fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                      ),
                                      const Icon(PhosphorIcons.caret_right_bold,color: Colors.white,size: 30,)
                                    ],
                                  ),
                                ),
                              );
                            })
                      ],
                    ),
                  );
                }
            ),
            
            // Expanded(
            //     child: Container(
            //       height: 1.sh,
            //       decoration: BoxDecoration(
            //           borderRadius: const BorderRadius.only(topLeft:Radius.circular(40),topRight: Radius.circular(40)),
            //           color: Colors.white
            //       ),
            //       child: Column(
            //         children: [
            //           SizedBox(
            //             height: 55,
            //             child: TabBar(
            //               indicatorColor: Colors.red,
            //               isScrollable: true,
            //               unselectedLabelColor: Colors.black,
            //               labelColor: Colors.red,
            //               labelStyle: const TextStyle(
            //                   fontWeight: FontWeight.w600,
            //                   fontSize: 18
            //               ),
            //               unselectedLabelStyle:  const TextStyle(
            //                   fontWeight: FontWeight.w400,
            //                   fontSize: 17
            //               ),
            //               controller: _tabController, tabs: const [
            //               Padding(
            //                 padding: EdgeInsets.only(right: 50,left: 50),
            //                 child: Text("Lawyer"),
            //               ),
            //               Padding(
            //                 padding: EdgeInsets.only(left: 50,right: 50),
            //                 child: Text("Tech"),
            //               ),
            //             ],
            //             ),
            //           ),
            //           Expanded(
            //             child: SizedBox(
            //               height: 1.sh,
            //               child: TabBarView(
            //                 controller: _tabController,
            //                 children:  const [
            //                   Consultant(),
            //                   ITDesign(),
            //                 ],
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     )
            // ),
          ],
        ),
      ),
    );
  }
}
