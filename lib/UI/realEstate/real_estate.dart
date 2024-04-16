import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:verify/UI/realEstate/RealEstate_History.dart';
import 'package:verify/UI/realEstate/commercialDetail.dart';
import 'package:verify/UI/realEstate/pgDetail.dart';
import 'package:verify/UI/realEstate/realEstateCommercialList.dart';
import 'package:verify/UI/realEstate/real_estateDeatail.dart';
import 'package:verify/UI/realEstate/real_estateList.dart';
import 'package:verify/bloc/realEstateBloc.dart';
import 'package:verify/data/model/commercialDetail.dart';
import 'package:verify/data/model/realestateFilter.dart';
import 'package:verify/data/model/realstateLocation.dart';
import 'package:verify/data/repository/RealEstateRepository.dart';
import 'package:verify/main.dart';
import 'package:verify/utils/constant.dart';
import 'package:verify/utils/message_handler.dart';
import '../../data/model/realestateModel.dart';
import 'package:http/http.dart' as http;
import '../vehicle/parking_notification.dart';

class RealEstateHomepage extends StatefulWidget {
  const RealEstateHomepage({super.key});

  @override
  State<RealEstateHomepage> createState() => _RealEstateHomepageState();
}

class _RealEstateHomepageState extends State<RealEstateHomepage> {

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

  late RealEstateBloc bloc;

  int? pageIndex;
  int? bhkIndex = 0;
  int? pageIndex2 = 0;
  int lookingIndex = 0;
  int? propertyIndex = 0;
  int FurnishingIndex = 0;
  int genderIndex = 0;
  int foodTypeIndex = 0;
  int facilityIndex = 0;
  int foodIndex = 0;
  List<String> items = [
    'Sultanpur',
    'Saket',
    'Hauz Khas',
    'Sarol',
    'M. G. Road',
  ];
  List<String> tittle = ["Buy", "Rent", "Commercial", "PG"];
  List<String> staticImages = [
    AppImages.static1,
    AppImages.static2,
    AppImages.static3,
  ];
  List<String> iconsTittle = [
    "Flat",
    "Showroom",
    "Warehouse",
    "shop",
    "House",
    "Plots",
    "Farms",
    "Basement",
    "Roof",
    "Office",
    "Appartment",
    "Villa",
  ];
  List<String> bhk = ["1 BHK", "2 BHK", "3 BHK", "4 BHK", "5 BHK", "6 BHK"];
  List<String> lookingTittle = ["Buy", "Lease"];
  List<String> furnishingTittle = ["Fully Furnished", "Semi Furnished", "Unfurnished"];
  List<String> genderTittle = ["Male", "Female", "Other"];
  List<String> foodTypeTittle = ["Veg", "Non-Veg"];
  List<String> facilityTittle = ["AC", "Non-AC"];
  List<String> foodTittle = ["Yes", "No"];
  List<String> propertyTittle = [
    "Showroom",
    "Commercial",
    "Plot",
    "Warehouse",
    "Office"
  ];

  @override
  void initState() {
    bloc = RealEstateBloc(context.read<RealEstateRepository>());
    super.initState();
    bloc.topListList();
    bloc.buyRent();
    bloc.getLocation();
    bloc.msgController!.stream.listen((event) {
      AppMessageHandler().showSnackBar(context, event);
    });
    bloc.realEstateStreamController.stream.listen((event) {
      if (event == "success") {
        if (bloc.realStateList.isNotEmpty) {
          Future.delayed(Duration(seconds: 0)).then((value) => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Provider.value(value: bloc,child: RealEstateList(
                index: pageIndex,
                data: bloc.realStateList,
              ),))));
        }
      }
      if(event == "successPG"){
        Future.delayed(Duration(seconds: 0)).then((value) => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Provider.value(value: bloc,child: CommercialPGList(
              type: "pg",
              data: bloc.PGListData,
            ),))));
      }
      if(event == "successCommercial"){
        Future.delayed(Duration(seconds: 0)).then((value) => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Provider.value(value: bloc,child: CommercialPGList(
              data: bloc.commercialListData,
            ),))));
      }
    });
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Column(
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

              ValueListenableBuilder(
                  valueListenable: bloc.topListLoader,
                  builder: (context, bool loading, _) {
                    if (loading) {
                      return const Center(
                        child:SizedBox(),
                      );
                    }
                    return SizedBox(
                      height: 40,
                      child: ListView.builder(
                        itemCount: bloc.topList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              pageIndex = index;
                              bloc.path.value = bloc.topList[index].rRname;
                              // if(pageIndex==2){
                              //   bloc.path.value = "Rent";
                              // }
                              if (pageIndex == 1 || pageIndex ==0) {
                                bloc.buyRent();
                              }
                              /*if(pageIndex == 2 || pageIndex == 3){
                                bloc.location.value = null;
                                bloc.showCommercial();
                              }*/
                              if(pageIndex == 2){
                                bloc.location.value = null;
                                bloc.showCommercial(lookingTittle[lookingIndex]);
                              }
                              if(pageIndex == 3){
                                bloc.location.value = null;
                                bloc.getPGData();
                              }
                              // print(bloc.path.value);
                              setState(() {});
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  color: pageIndex == index
                                      ? Colors.red
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                bloc.topList[index].rRname ?? "",
                                style: TextStyle(
                                    color: pageIndex == index
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),
              if (pageIndex == 0 || pageIndex == 1 || pageIndex==2)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(pageIndex == 2)const SizedBox(
                      height: 20,
                    ),
                    if(pageIndex == 2)Align(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Looking To",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    if(pageIndex == 2)const SizedBox(
                      height: 10,
                    ),
                    if(pageIndex == 2)SizedBox(
                      height: 40,
                      child: ListView.builder(
                        itemCount: 2,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              lookingIndex = index;
                              bloc.showCommercial(lookingTittle[lookingIndex]);
                              setState(() {});
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              margin: EdgeInsets.only(left: 45.w, right: 45.w),
                              decoration: BoxDecoration(
                                  color: lookingIndex == index
                                      ? const Color.fromARGB(255, 242, 216, 184)
                                      : Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: lookingIndex == index
                                          ? const Color.fromARGB(
                                          255, 242, 216, 184)
                                          : Colors.white,
                                      width: 1)),
                              child: Text(
                                lookingTittle[index],
                                style: TextStyle(
                                    color: lookingIndex == index
                                        ? Colors.black
                                        : Colors.white),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        height: 40,
                        child: ListView.builder(
                          itemCount: 12,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                pageIndex2 = index;
                                bloc.type.value = iconsTittle[index];
                                setState(() {});
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                    color: pageIndex2 == index
                                        ? Colors.white
                                        : Colors.grey,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: [
                                    // const Icon(
                                    //   Icons.abc,
                                    //   color: Colors.black,
                                    // ),
                                    // const SizedBox(
                                    //   width: 10,
                                    // ),
                                    Text(
                                      iconsTittle[index],
                                      style: TextStyle(
                                          fontWeight: pageIndex2 == index
                                              ? FontWeight.w500
                                              : FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ValueListenableBuilder(valueListenable: bloc.locationLoader, builder: (context, bool loading, child) {
                      if(loading){
                        return CircularProgressIndicator();
                      }
                      return Container(
                        // height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: DropdownButtonFormField(
                          dropdownColor: Colors.grey.shade500,
                          items: bloc.locationData.map((realstateLocation items) {
                            return DropdownMenuItem(
                              value: items.locationh,
                              child: Text(
                                items.locationh ?? "",
                                style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w500),
                              ),
                            );
                          }).toList(),
                          onChanged: (v) {
                            bloc.location.value = v;
                          },
                          // style: TextStyle(color: Colors.white),
                          hint: const Text(
                            "Select Location",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Select BHK",
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        itemCount: bhk.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              bhkIndex = index;
                              bloc.bhk.value = bhk[index];
                              setState(() {});
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: bhkIndex == index
                                          ? Colors.red
                                          : Colors.white,
                                      width: 2)),
                              child: Text(bhk[index]),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        if(pageIndex == 0 || pageIndex == 1){
                          bloc.getListByFilter();
                        }
                        if(pageIndex == 2){
                          bloc.getCommercialListByFilter(lookingType: lookingTittle[lookingIndex],);
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red),
                        child: ValueListenableBuilder(
                            valueListenable: bloc.buttonLoader,
                            builder: (context, bool loading, _) {
                              if (loading) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                );
                              }
                              return const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Icon(Icons.comment),
                                  // SizedBox(
                                  //   width: 5,
                                  // ),
                                  Text(
                                    "SUBMIT",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Colors.white),
                                  )
                                ],
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              // if (pageIndex == 2)
              //   Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       const SizedBox(
              //         height: 20,
              //       ),
              //       Align(
              //         alignment: Alignment.centerLeft,
              //         child: const Text(
              //           "Looking To",
              //           style: TextStyle(color: Colors.white),
              //         ),
              //       ),
              //       const SizedBox(
              //         height: 10,
              //       ),
              //       SizedBox(
              //         height: 40,
              //         child: ListView.builder(
              //           itemCount: 2,
              //           physics: const NeverScrollableScrollPhysics(),
              //           scrollDirection: Axis.horizontal,
              //           itemBuilder: (context, index) {
              //             return GestureDetector(
              //               onTap: () {
              //                 lookingIndex = index;
              //                 setState(() {});
              //               },
              //               child: Container(
              //                 padding: const EdgeInsets.symmetric(
              //                     horizontal: 30, vertical: 10),
              //                 margin: EdgeInsets.only(left: 45.w, right: 45.w),
              //                 decoration: BoxDecoration(
              //                     color: lookingIndex == index
              //                         ? const Color.fromARGB(255, 242, 216, 184)
              //                         : Colors.black,
              //                     borderRadius: BorderRadius.circular(10),
              //                     border: Border.all(
              //                         color: lookingIndex == index
              //                             ? const Color.fromARGB(
              //                                 255, 242, 216, 184)
              //                             : Colors.white,
              //                         width: 1)),
              //                 child: Text(
              //                   lookingTittle[index],
              //                   style: TextStyle(
              //                       color: lookingIndex == index
              //                           ? Colors.black
              //                           : Colors.white),
              //                 ),
              //               ),
              //             );
              //           },
              //         ),
              //       ),
              //       const SizedBox(
              //         height: 10,
              //       ),
              //       ValueListenableBuilder(valueListenable: bloc.locationLoader, builder: (context, bool loading, child) {
              //         if(loading){
              //           return CircularProgressIndicator();
              //         }
              //         return Container(
              //           // height: 40,
              //           decoration: BoxDecoration(
              //             color: Colors.white.withOpacity(0.2),
              //             borderRadius: BorderRadius.circular(10),
              //           ),
              //           padding: const EdgeInsets.symmetric(horizontal: 10),
              //           child: DropdownButtonFormField(
              //             dropdownColor: Colors.grey.shade500,
              //             items: bloc.locationData.map((realstateLocation items) {
              //               return DropdownMenuItem(
              //                 value: items.locationh,
              //                 child: Text(
              //                   items.locationh ?? "",
              //                   style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w500),
              //                 ),
              //               );
              //             }).toList(),
              //             onChanged: (v) {
              //               bloc.location.value = v;
              //             },
              //             // style: TextStyle(color: Colors.white),
              //             hint: const Text(
              //               "Select Location",
              //               style: TextStyle(color: Colors.white),
              //             ),
              //           ),
              //         );
              //       },),
              //       const SizedBox(
              //         height: 10,
              //       ),
              //       const Align(
              //         alignment: Alignment.centerLeft,
              //         child: Text(
              //           "Property Type",
              //           style: TextStyle(color: Colors.white),
              //         ),
              //       ),
              //       const SizedBox(
              //         height: 10,
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 10),
              //         child: SizedBox(
              //           height: 40,
              //           child: ListView.builder(
              //             itemCount: 5,
              //             scrollDirection: Axis.horizontal,
              //             itemBuilder: (context, index) {
              //               return GestureDetector(
              //                 onTap: () {
              //                   propertyIndex = index;
              //                   setState(() {});
              //                 },
              //                 child: Container(
              //                   padding: const EdgeInsets.symmetric(
              //                       horizontal: 10, vertical: 10),
              //                   margin: const EdgeInsets.only(right: 10),
              //                   decoration: BoxDecoration(
              //                       color: propertyIndex == index
              //                           ? Colors.white
              //                           : Colors.grey,
              //                       borderRadius: BorderRadius.circular(10)),
              //                   child: Row(
              //                     children: [
              //                       Text(
              //                         propertyTittle[index],
              //                         style: TextStyle(
              //                             fontWeight: propertyIndex == index
              //                                 ? FontWeight.w600
              //                                 : FontWeight.w400),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               );
              //             },
              //           ),
              //         ),
              //       ),
              //       const SizedBox(
              //         height: 10,
              //       ),
              //       const Text(
              //         "Select BHK",
              //         style: TextStyle(color: Colors.white),
              //       ),
              //       const SizedBox(
              //         height: 10,
              //       ),
              //       SizedBox(
              //         height: 40,
              //         child: ListView.builder(
              //           itemCount: bhk.length,
              //           scrollDirection: Axis.horizontal,
              //           itemBuilder: (context, index) {
              //             return GestureDetector(
              //               onTap: () {
              //                 bhkIndex = index;
              //                 bloc.bhk.value = bhk[index];
              //                 setState(() {});
              //               },
              //               child: Container(
              //                 padding: const EdgeInsets.symmetric(
              //                     horizontal: 10, vertical: 10),
              //                 margin: const EdgeInsets.only(right: 10),
              //                 decoration: BoxDecoration(
              //                     color: Colors.white,
              //                     borderRadius: BorderRadius.circular(10),
              //                     border: Border.all(
              //                         color: bhkIndex == index
              //                             ? Colors.red
              //                             : Colors.white,
              //                         width: 2)),
              //                 child: Text(bhk[index]),
              //               ),
              //             );
              //           },
              //         ),
              //       ),
              //       /*Container(
              //         // height: 40,
              //         decoration: BoxDecoration(
              //           color: Colors.white,
              //           borderRadius: BorderRadius.circular(10),
              //         ),
              //         padding: const EdgeInsets.symmetric(horizontal: 10),
              //         child: DropdownButtonFormField(
              //           dropdownColor: Colors.white,
              //           items: bhk.map((String items) {
              //             return DropdownMenuItem(
              //               value: items,
              //               child: Text(
              //                 items,
              //                 style: const TextStyle(color: Colors.black),
              //               ),
              //             );
              //           }).toList(),
              //           onChanged: (v) {},
              //           // style: TextStyle(color: Colors.white),
              //           hint: const Text(
              //             "Select the BHK",
              //             style: TextStyle(color: Colors.black),
              //           ),
              //         ),
              //       ),*/
              //       const SizedBox(
              //         height: 10,
              //       ),
              //       GestureDetector(
              //         onTap: () {
              //
              //         },
              //         child: Container(
              //           margin: const EdgeInsets.symmetric(horizontal: 20),
              //           padding: const EdgeInsets.symmetric(
              //               horizontal: 10, vertical: 10),
              //           decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(10),
              //               color: Colors.red),
              //           child: const Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Text(
              //                 "SUBMIT",
              //                 style: TextStyle(
              //                     fontWeight: FontWeight.w500,
              //                     fontSize: 16,
              //                     color: Colors.white),
              //               )
              //             ],
              //           ),
              //         ),
              //       ),
              //       const SizedBox(height: 10,),
              //       ValueListenableBuilder(valueListenable: bloc.commercialLoader, builder:
              //           (context, bool loading, child) {
              //         if(loading){
              //           return const Column(
              //             children: [
              //               SizedBox(height: 30,),
              //               CircularProgressIndicator(color: Colors.white,),
              //             ],
              //           );
              //         }
              //         return const Column(
              //           children: [
              //             SizedBox()
              //           ],
              //         );
              //       },)
              //     ],
              //   ),
              if (pageIndex == 3)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Food Availability",
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        itemCount: 2,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              foodIndex = index;
                              setState(() {});
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              margin: EdgeInsets.only(left: 45.w, right: 45.w),
                              decoration: BoxDecoration(
                                  color: foodIndex == index
                                      ? const Color.fromARGB(255, 242, 216, 184)
                                      : Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: foodIndex == index
                                          ? const Color.fromARGB(
                                              255, 242, 216, 184)
                                          : Colors.white,
                                      width: 1)),
                              child: Text(
                                foodTittle[index],
                                style: TextStyle(
                                    color: foodIndex == index
                                        ? Colors.black
                                        : Colors.white),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ValueListenableBuilder(valueListenable: bloc.locationLoader, builder: (context, bool loading, child) {
                      if(loading){
                        return CircularProgressIndicator();
                      }
                      return Container(
                        // height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: DropdownButtonFormField(
                          dropdownColor: Colors.grey.shade500,
                          items: bloc.locationData.map((realstateLocation items) {
                            return DropdownMenuItem(
                              value: items.locationh,
                              child: Text(
                                items.locationh ?? "",
                                style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w500),
                              ),
                            );
                          }).toList(),
                          onChanged: (v) {
                            bloc.location.value = v;
                          },
                          // style: TextStyle(color: Colors.white),
                          hint: const Text(
                            "Select Location",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },),
                    //
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Furnishing Type",
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              FurnishingIndex = index;
                              setState(() {});
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: FurnishingIndex == index
                                          ? Colors.red
                                          : Colors.white,
                                      width: 2)),
                              child: Text(furnishingTittle[index]),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Gender",
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              genderIndex = index;
                              setState(() {});
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: genderIndex == index
                                          ? Colors.red
                                          : Colors.white,
                                      width: 2)),
                              child: Text(genderTittle[index]),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Food Type",
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        itemCount: 2,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              foodTypeIndex = index;
                              setState(() {});
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: foodTypeIndex == index
                                          ? Colors.red
                                          : Colors.white,
                                      width: 2)),
                              child: Text(foodTypeTittle[index]),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Facility",
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        itemCount: 2,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              facilityIndex = index;
                              setState(() {});
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: facilityIndex == index
                                          ? Colors.red
                                          : Colors.white,
                                      width: 2)),
                              child: Text(facilityTittle[index]),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        bloc.getPGListByFilter(AC: facilityTittle[facilityIndex],food: foodTittle[foodIndex],foodType: foodTypeTittle[foodTypeIndex],furnished: furnishingTittle[FurnishingIndex],gender: genderTittle[genderIndex],);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Icon(Icons.comment),
                            // SizedBox(
                            //   width: 5,
                            // ),
                            Text(
                              "SUBMIT",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              if (pageIndex == null || pageIndex == 0 || pageIndex == 1)
                ValueListenableBuilder(
                  valueListenable: bloc.buyRentLoader,
                  builder: (context, bool loading,_) {
                    if(loading){
                      return const Column(
                        children: [
                          SizedBox(height: 30,),
                          CircularProgressIndicator(color: Colors.white,),
                        ],

                      );
                    }
                    return Column(
                      children: [
                        ValueListenableBuilder(
                            valueListenable: bloc.buyFlatList,
                            builder: (context, List<RealStateFilters> data, _) {
                              if (data.isEmpty) {
                                return const SizedBox();
                              }
                              return Provider.value(value: bloc,child: ContentList(
                                index: pageIndex,
                                data: data,
                                type: "For Flat",
                              ));
                            }),
                        ValueListenableBuilder(
                            valueListenable: bloc.buyShowroomList,
                            builder: (context, List<RealStateFilters> data, _) {
                              if (data.isEmpty) {
                                return const SizedBox();
                              }
                              return Provider.value(value: bloc,child: ContentList(
                                index: pageIndex,
                                data: data,
                                type: "For Showroom",
                              ));
                            }),
                        ValueListenableBuilder(
                            valueListenable: bloc.buyWarehouseList,
                            builder: (context, List<RealStateFilters> data, _) {
                              if (data.isEmpty) {
                                return const SizedBox();
                              }
                              return Provider.value(value: bloc,child: ContentList(
                                index: pageIndex,
                                data: data,
                                type: "For Warehouse",
                              ));
                            }),
                        ValueListenableBuilder(
                            valueListenable: bloc.buyShopList,
                            builder: (context, List<RealStateFilters> data, _) {
                              if (data.isEmpty) {
                                return const SizedBox();
                              }
                              return Provider.value(value: bloc,child: ContentList(
                                index: pageIndex,
                                data: data,
                                type: "For Shop",
                              ));
                            }),
                        ValueListenableBuilder(
                            valueListenable: bloc.buyHouseList,
                            builder: (context, List<RealStateFilters> data, _) {
                              if (data.isEmpty) {
                                return const SizedBox();
                              }
                              return Provider.value(value: bloc,child: ContentList(
                                index: pageIndex,
                                data: data,
                                type: "For House",
                              ));
                            }),
                        ValueListenableBuilder(
                            valueListenable: bloc.buyPlotsList,
                            builder: (context, List<RealStateFilters> data, _) {
                              if (data.isEmpty) {
                                return const SizedBox();
                              }
                              return Provider.value(value: bloc,child: ContentList(
                                index: pageIndex,
                                data: data,
                                type: "For Plots",
                              ));
                            }),
                        ValueListenableBuilder(
                            valueListenable: bloc.buyFarmsList,
                            builder: (context, List<RealStateFilters> data, _) {
                              if (data.isEmpty) {
                                return const SizedBox();
                              }
                              return Provider.value(value: bloc,child: ContentList(
                                index: pageIndex,
                                data: data,
                                type: "For Farms",
                              ));
                            }),
                        ValueListenableBuilder(
                            valueListenable: bloc.buyBasementList,
                            builder: (context, List<RealStateFilters> data, _) {
                              if (data.isEmpty) {
                                return const SizedBox();
                              }
                              return Provider.value(value: bloc,child: ContentList(
                                index: pageIndex,
                                data: data,
                                type: "For Basements",
                              ));
                            }),
                        ValueListenableBuilder(
                            valueListenable: bloc.buyRoofList,
                            builder: (context, List<RealStateFilters> data, _) {
                              if (data.isEmpty) {
                                return const SizedBox();
                              }
                              return Provider.value(value: bloc,child: ContentList(
                                index: pageIndex,
                                data: data,
                                type: "For Roof",
                              ));
                            }),
                        ValueListenableBuilder(
                            valueListenable: bloc.buyOfficeList,
                            builder: (context, List<RealStateFilters> data, _) {
                              if (data.isEmpty) {
                                return const SizedBox();
                              }
                              return Provider.value(value: bloc,child: ContentList(
                                index: pageIndex,
                                data: data,
                                type: "For Office",
                              ));
                            }),
                        ValueListenableBuilder(
                            valueListenable: bloc.buyAppartmentList,
                            builder: (context, List<RealStateFilters> data, _) {
                              if (data.isEmpty) {
                                return const SizedBox();
                              }
                              return Provider.value(value: bloc,child: ContentList(
                                index: pageIndex,
                                data: data,
                                type: "For Apartment",
                              ));
                            }),
                        ValueListenableBuilder(
                            valueListenable: bloc.buyVillaList,
                            builder: (context, List<RealStateFilters> data, _) {
                              if (data.isEmpty) {
                                return const SizedBox();
                              }
                              return Provider.value(value: bloc,child: ContentList(
                                index: pageIndex,
                                data: data,
                                type: "For Villa",
                              ));
                            }),
                      ],
                    );
                  }
                ),
              if(pageIndex == 2)
              ValueListenableBuilder(
                  valueListenable: bloc.commercialLoader,
                  builder: (context, bool loading,_) {
                    if(loading){
                      return const Column(
                        children: [
                          SizedBox(height: 30,),
                          CircularProgressIndicator(color: Colors.white,),
                        ],

                      );
                    }
                    return Column(
                      children: [
                        ValueListenableBuilder(
                            valueListenable: bloc.commercialFlatList,
                            builder: (context, List<commercialPGDetail> data, _) {
                              if (data.isEmpty) {
                                return const SizedBox();
                              }
                              return Provider.value(value: bloc,child: CommercialList(
                                data: data,
                                type: "For Flat",
                              ));
                            }),
                        ValueListenableBuilder(
                            valueListenable: bloc.commercialShowroomList,
                            builder: (context, List<commercialPGDetail> data, _) {
                              if (data.isEmpty) {
                                return const SizedBox();
                              }
                              return Provider.value(value: bloc,child: CommercialList(
                                data: data,
                                type: "For Showroom",
                              ));
                            }),
                        ValueListenableBuilder(
                            valueListenable: bloc.commercialWarehouseList,
                            builder: (context, List<commercialPGDetail> data, _) {
                              if (data.isEmpty) {
                                return const SizedBox();
                              }
                              return Provider.value(value: bloc,child: CommercialList(
                                data: data,
                                type: "For Warehouse",
                              ));
                            }),
                        ValueListenableBuilder(
                            valueListenable: bloc.commercialShopList,
                            builder: (context, List<commercialPGDetail> data, _) {
                              if (data.isEmpty) {
                                return const SizedBox();
                              }
                              return Provider.value(value: bloc,child: CommercialList(
                                data: data,
                                type: "For Shop",
                              ));
                            }),
                        ValueListenableBuilder(
                            valueListenable: bloc.commercialHouseList,
                            builder: (context, List<commercialPGDetail> data, _) {
                              if (data.isEmpty) {
                                return const SizedBox();
                              }
                              return Provider.value(value: bloc,child: CommercialList(
                                data: data,
                                type: "For House",
                              ));
                            }),
                        ValueListenableBuilder(
                            valueListenable: bloc.commercialPlotsList,
                            builder: (context, List<commercialPGDetail> data, _) {
                              if (data.isEmpty) {
                                return const SizedBox();
                              }
                              return Provider.value(value: bloc,child: CommercialList(
                                data: data,
                                type: "For Plots",
                              ));
                            }),
                        ValueListenableBuilder(
                            valueListenable: bloc.commercialFarmsList,
                            builder: (context, List<commercialPGDetail> data, _) {
                              if (data.isEmpty) {
                                return const SizedBox();
                              }
                              return Provider.value(value: bloc,child: CommercialList(
                                data: data,
                                type: "For Farms",
                              ));
                            }),
                        ValueListenableBuilder(
                            valueListenable: bloc.commercialBasementsList,
                            builder: (context, List<commercialPGDetail> data, _) {
                              if (data.isEmpty) {
                                return const SizedBox();
                              }
                              return Provider.value(value: bloc,child: CommercialList(
                                data: data,
                                type: "For Basement",
                              ));
                            }),
                        ValueListenableBuilder(
                            valueListenable: bloc.commercialRoofList,
                            builder: (context, List<commercialPGDetail> data, _) {
                              if (data.isEmpty) {
                                return const SizedBox();
                              }
                              return Provider.value(value: bloc,child: CommercialList(
                                data: data,
                                type: "For Roof",
                              ));
                            }),
                        ValueListenableBuilder(
                            valueListenable: bloc.commercialOfficeList,
                            builder: (context, List<commercialPGDetail> data, _) {
                              if (data.isEmpty) {
                                return const SizedBox();
                              }
                              return Provider.value(value: bloc,child: CommercialList(
                                data: data,
                                type: "For Office",
                              ));
                            }),
                        ValueListenableBuilder(
                            valueListenable: bloc.commercialApartmentList,
                            builder: (context, List<commercialPGDetail> data, _) {
                              if (data.isEmpty) {
                                return const SizedBox();
                              }
                              return Provider.value(value: bloc,child: CommercialList(
                                data: data,
                                type: "For Apartment",
                              ));
                            }),
                        ValueListenableBuilder(
                            valueListenable: bloc.commercialVillaList,
                            builder: (context, List<commercialPGDetail> data, _) {
                              if (data.isEmpty) {
                                return const SizedBox();
                              }
                              return Provider.value(value: bloc,child: CommercialList(
                                data: data,
                                type: "For Villa",
                              ));
                            }),
                      ],
                    );
                  }
              ),
              if(pageIndex==3)
              ValueListenableBuilder(
                valueListenable: bloc.PGLoader,
                builder: (context, bool loading,_) {
                  if (loading) {
                    return const Column(
                      children: [
                        SizedBox(height: 30,),
                        CircularProgressIndicator(color: Colors.white,),
                      ],

                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Provider.value(value: bloc,child: RealEstateCommercialList(
                                type:"pg",
                                data:bloc.PGData,
                              ),)));
                        },
                        child: Row(
                          children: [
                            Text(
                              "PG's",
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "see all",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 290,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: bloc.PGData.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                  return Provider.value(value: bloc,child: PGDetail(id: '${bloc.PGData[index].id}',),);
                                },));
                              },
                              child: Container(
                                width: 0.78.sw,
                                margin: EdgeInsets.only(
                                    bottom: 10, top: index == 0 ? 10 : 10, left:5, right: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 170,
                                      width: 1.sw,
                                      child:ClipRRect(
                                        borderRadius: const BorderRadius.only(topLeft:Radius.circular(5),topRight: Radius.circular(5)),
                                        child:  CachedNetworkImage(
                                          imageUrl:
                                          "http://www.verifyserve.social/upload/${bloc.PGData[index].img}",
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
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              child: Text(
                                                bloc.PGData[index].title ??
                                                    "",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13
                                                ),
                                              )),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text(
                                            "Available",
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
                                          Text(
                                            bloc.PGData[index].location??
                                                "",style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400,
                                          ),),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                      child: Text(
                                        "₹ ${bloc.PGData[index].price}",
                                        style: const TextStyle(color: Colors.green,fontWeight: FontWeight.w500,fontSize: 14),
                                      ),
                                    ),
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
                }),
            ],
          ),
        ),
      ),
    );
  }
}

class ContentList extends StatefulWidget {
  final List<RealStateFilters> data;
  final String type;
  final int? index;
  const ContentList({super.key, required this.data, required this.type,required this.index});

  @override
  State<ContentList> createState() => _ContentListState();
}

class _ContentListState extends State<ContentList> {
  late RealEstateBloc bloc;

  @override
  void initState() {
    bloc = context.read<RealEstateBloc>();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Provider.value(value: bloc,child: RealEstateList(
                  data:widget.data,
                  index: widget.index,
                ),)));
          },
          child: Row(
            children: [
              Text(
                widget.type,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w500
                ),
              ),
              const Spacer(),
              Text(
                "see all",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 290,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: widget.data.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return Provider.value(value: bloc,child: RealEstateDetail(id: '${widget.data[index].tPid}',),);
                  },));
                },
                child: Container(
                  width: 0.78.sw,
                  margin: EdgeInsets.only(
                      bottom: 10, top: index == 0 ? 10 : 10, left:5, right: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: 170,
                          width: 1.sw,
                          child:ClipRRect(
                            borderRadius: const BorderRadius.only(topLeft:Radius.circular(5),topRight: Radius.circular(5)),
                            child:  CachedNetworkImage(
                              imageUrl:
                              "http://www.verifyserve.social/upload/${widget.data[index].imagesh}",
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
                            /*FadeInImage.assetNetwork(
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
                          /* ClipRRect(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Text(
                              widget.data[index].tital ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                        fontWeight: FontWeight.w500,
                            fontSize: 13
                        ),
                            )),
                            const SizedBox(
                              width: 10,
                            ),
                             Text(
                             widget.index == 1 ? "For Sale" : "For Rent",
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
                            Text(widget.data[index].locationh??"",style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "₹ ${widget.data[index].priceh}",
                          style: const TextStyle(color: Colors.green,fontWeight: FontWeight.w500,fontSize: 14),
                        ),
                      ),
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
}

class CommercialList extends StatefulWidget {
  final List<commercialPGDetail> data;
  final String type;
  const CommercialList({super.key, required this.data, required this.type});

  @override
  State<CommercialList> createState() => _CommercialListState();
}

class _CommercialListState extends State<CommercialList> {
  late RealEstateBloc bloc;

  @override
  void initState() {
    bloc = context.read<RealEstateBloc>();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Provider.value(value: bloc,child: RealEstateCommercialList(
                  data:widget.data,
                ),)));
          },
          child: Row(
            children: [
              Text(
                widget.type,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500
                ),
              ),
              const Spacer(),
              Text(
                "see all",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 290,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: widget.data.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return Provider.value(value: bloc,child: CommercialDetail(id: '${widget.data[index].id}',),);
                  },));
                },
                child: Container(
                  width: 0.78.sw,
                  margin: EdgeInsets.only(
                      bottom: 10, top: index == 0 ? 10 : 10, left:5, right: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 170,
                        width: 1.sw,
                        child:ClipRRect(
                          borderRadius: const BorderRadius.only(topLeft:Radius.circular(5),topRight: Radius.circular(5)),
                          child:  CachedNetworkImage(
                            imageUrl:
                            "http://www.verifyserve.social/upload/${widget.data[index].img}",
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
                          /*FadeInImage.assetNetwork(
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
                      /* ClipRRect(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Text(
                                  widget.data[index].title ??
                                      "",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13
                                  ),
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "Available",
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
                            Text(
                              widget.data[index].location??
                                "",style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "₹ ${widget.data[index].price}",
                          style: const TextStyle(color: Colors.green,fontWeight: FontWeight.w500,fontSize: 14),
                        ),
                      ),
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
}
