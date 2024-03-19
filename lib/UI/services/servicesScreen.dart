import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:verify/UI/services/addServiceScreen.dart';
import 'package:verify/UI/services/servicesContentScreen.dart';
import 'package:verify/bloc/servicesBloc.dart';
import 'package:verify/data/repository/servicesRepository.dart';
import 'package:verify/utils/constant.dart';

import '../../data/model/serviceSlider.dart';
import '../../utils/message_handler.dart';
import 'package:http/http.dart' as http;

import 'Service_History.dart';
import 'monthly.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> with SingleTickerProviderStateMixin{

  //For Service Slider
  Future<List<ServiceModel>> fetchCarouselData() async {
    final response = await http.get(Uri.parse('https://verifyserve.social/WebService1.asmx/ShowServiceimg'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) {
        return ServiceModel(
          simage: item['Simage'],
        );
      }).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  late ServiceBloc bloc;

  late TabController _tabController;

  List<String> gridImages = [
    AppImages.documents,
    AppImages.notification,
    AppImages.realEstate,
    AppImages.vehicle,
    AppImages.insurance,
    AppImages.services,
    AppImages.jobs,
    AppImages.itAndDesigner,
    AppImages.consultantAndLowers,
    AppImages.hotels,
    AppImages.eventsAndWeeding,
    AppImages.trucksAndJcb,
  ];
  List<String> gridTittle = [
    'Web Designers',
    'Home Designers',
    'Interior Designers',
    'Application Developers',
    'Marketing',
    'Services',
    'Jobs',
    'IT & Designer',
    'Consultant & Lawyers',
    'Hotels',
    'Events & Weeding',
    'Truck & JCBs',
  ];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    bloc = ServiceBloc(context.read<ServiceRepository>());
    super.initState();
    bloc.serviceStreamController.stream.listen((event) {
      if(event=="POPS"){
        Navigator.pop(context);
        bloc.mainPageGrid();
      }
    });
    bloc.msgController?.stream.listen((event) {
      AppMessageHandler().showSnackBar(context, event);
    });
    bloc.mainPageGrid();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            style: const ButtonStyle(
              padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 10,horizontal: 10)),
              
            ),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const AddServicesScreen()));
            },
          child: const Row(
            children: [
              Icon(Icons.add_circle),
              SizedBox(width: 10,),
              Text("Post Services",style: TextStyle(fontSize: 15),),
            ],
          ),),
        ],
      ),
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
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Service_history()));
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
        child: ValueListenableBuilder(
          valueListenable: bloc.mainGridLoader,
          builder: (context,bool loading,_) {
            if(loading){
              return const Center(child: CircularProgressIndicator(color: Colors.white,),);
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Container(
                  //       height: 40,
                  //       padding: const EdgeInsets.symmetric(horizontal: 10),
                  //       decoration: BoxDecoration(
                  //         color: Colors.white,
                  //         borderRadius: BorderRadius.circular(5),
                  //       ),
                  //       child: TextFormField(
                  //         controller: TextEditingController(),
                  //         decoration: const InputDecoration(
                  //           icon: Icon(
                  //             PhosphorIcons.magnifying_glass,
                  //             color: Colors.grey,
                  //             size: 20,
                  //           ),
                  //           contentPadding: EdgeInsets.only(top: 0, bottom: 9),
                  //           border: InputBorder.none,
                  //           hintText: "Search Here...",
                  //           hintStyle: TextStyle(
                  //             color: Colors.grey,
                  //           ),
                  //         ),
                  //       )),
                  // ),
                  const SizedBox(height: 30,),
                  FutureBuilder<List<ServiceModel>>(
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
                                      "https://www.verifyserve.social/upload/${item.simage}",
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
                  ListView.builder(
                    physics:const ScrollPhysics(),
                      itemCount: bloc.mailList.value.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Provider.value(
                                    value: bloc,
                                  child: ServicesContentsScreen(bloc.mailList.value[index]),
                                )
                            ));
                          },
                          child: Container(
                            width: 1.sw,
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              border:
                                  Border.all(color: Colors.white.withOpacity(0.8)),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                    "http://www.verifyserve.social/upload/${bloc.mailList.value[index].scimg}",
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
                                    image: "http://www.verifyserve.social/upload/${bloc.mailList.value[index].scimg}",
                                    height: 60.h,
                                    width: 120.w,
                                    fit: BoxFit.cover,
                                    placeholder: AppImages.loading,
                                    imageErrorBuilder: (context, error, stack) => Image.asset(
                                      AppImages.imageNotFound,
                                      fit: BoxFit.cover,
                                      height: 60.h,
                                      width: 120.w,
                                    ),
                                  ),*/
                                ),
                               /* Container(
                                  height: 65.h,
                                  width: 120.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.network(
                                        "http://www.verifyserve.social/upload/${bloc.mailList.value[index].scimg}",
                                        fit: BoxFit.cover,
                                      )),
                                ),*/
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                      bloc.mailList.value[index].scname ?? "",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        // fontStyle: FontStyle.italic
                                    ),
                                  ),
                                ),
                                const Icon(
                                  PhosphorIcons.caret_right_bold,
                                  color: Colors.white,
                                  size: 30,
                                )
                              ],
                            ),
                          ),
                        );
                      })

                  // Expanded(
                  //   child: Container(
                  //     height: 1.sh,
                  //     decoration: BoxDecoration(
                  //         borderRadius: const BorderRadius.only(topLeft:Radius.circular(40),topRight: Radius.circular(40)),
                  //         color: Colors.white
                  //     ),
                  //     child: Column(
                  //       children: [
                  //         SizedBox(
                  //           height: 55,
                  //           child: TabBar(
                  //             indicatorColor: Colors.red,
                  //             isScrollable: true,
                  //             unselectedLabelColor: Colors.black,
                  //             labelColor: Colors.red,
                  //             labelStyle: const TextStyle(
                  //                 fontWeight: FontWeight.w600,
                  //                 fontSize: 18
                  //             ),
                  //             unselectedLabelStyle:  const TextStyle(
                  //                 fontWeight: FontWeight.w400,
                  //                 fontSize: 17
                  //             ),
                  //             controller: _tabController, tabs: const [
                  //             Padding(
                  //               padding: EdgeInsets.only(right: 25,left: 25),
                  //               child: Text("Daily Need"),
                  //             ),
                  //             Padding(
                  //               padding: EdgeInsets.only(left: 25,right: 25),
                  //               child: Text("Monthly Need"),
                  //             ),
                  //           ],
                  //           ),
                  //         ),
                  //         Expanded(
                  //           child: SizedBox(
                  //             height: 1.sh,
                  //             child: TabBarView(
                  //               controller: _tabController,
                  //               children: [
                  //                 Container(
                  //                   padding: EdgeInsets.only(right: 5,left: 5,top: 10),
                  //                   color: Colors.black,
                  //                   child: Column(
                  //                     children: [
                  //                       Expanded(
                  //                         child: ListView.builder(
                  //                             physics:const ScrollPhysics(),
                  //                             itemCount: bloc.mailList.value.length,
                  //                             shrinkWrap: true,
                  //                             itemBuilder: (context, index) {
                  //                               return GestureDetector(
                  //                                 onTap: () {
                  //                                   Navigator.of(context).push(MaterialPageRoute(
                  //                                       builder: (context) => Provider.value(
                  //                                           value: bloc,
                  //                                         child: ServicesContentsScreen(bloc.mailList.value[index]),
                  //                                       )
                  //                                   ));
                  //                                 },
                  //                                 child: Container(
                  //                                   width: 1.sw,
                  //                                   padding: const EdgeInsets.all(5),
                  //                                   margin: const EdgeInsets.only(bottom: 15),
                  //                                   decoration: BoxDecoration(
                  //                                     color: Colors.grey.withOpacity(0.2),
                  //                                     border:
                  //                                         Border.all(color: Colors.white.withOpacity(0.8)),
                  //                                     borderRadius: BorderRadius.circular(10.0),
                  //                                   ),
                  //                                   child: Row(
                  //                                     children: [
                  //                                       ClipRRect(
                  //                                         borderRadius: const BorderRadius.all(Radius.circular(5)),
                  //                                         child: CachedNetworkImage(
                  //                                           imageUrl:
                  //                                           "http://www.verifyserve.social/upload/${bloc.mailList.value[index].scimg}",
                  //                                           height: 60.h,
                  //                                           width: 120.w,
                  //                                           fit: BoxFit.cover,
                  //                                           placeholder: (context, url) => Image.asset(
                  //                                             AppImages.loading,
                  //                                             height: 60.h,
                  //                                             fit: BoxFit.cover,
                  //                                             width: 120.w,
                  //                                           ),
                  //                                           errorWidget: (context, error, stack) =>
                  //                                               Image.asset(
                  //                                                 AppImages.imageNotFound,
                  //                                                 height: 60.h,
                  //                                                 fit: BoxFit.cover,
                  //                                                 width: 120.w,
                  //                                               ),
                  //                                         ),
                  //                                         /*FadeInImage.assetNetwork(
                  //                                           image: "http://www.verifyserve.social/upload/${bloc.mailList.value[index].scimg}",
                  //                                           height: 60.h,
                  //                                           width: 120.w,
                  //                                           fit: BoxFit.cover,
                  //                                           placeholder: AppImages.loading,
                  //                                           imageErrorBuilder: (context, error, stack) => Image.asset(
                  //                                             AppImages.imageNotFound,
                  //                                             fit: BoxFit.cover,
                  //                                             height: 60.h,
                  //                                             width: 120.w,
                  //                                           ),
                  //                                         ),*/
                  //                                       ),
                  //                                      /* Container(
                  //                                         height: 65.h,
                  //                                         width: 120.w,
                  //                                         decoration: BoxDecoration(
                  //                                           borderRadius: BorderRadius.circular(10.0),
                  //                                         ),
                  //                                         child: ClipRRect(
                  //                                             borderRadius: BorderRadius.circular(5),
                  //                                             child: Image.network(
                  //                                               "http://www.verifyserve.social/upload/${bloc.mailList.value[index].scimg}",
                  //                                               fit: BoxFit.cover,
                  //                                             )),
                  //                                       ),*/
                  //                                       const SizedBox(
                  //                                         width: 10,
                  //                                       ),
                  //                                       Expanded(
                  //                                         child: Text(
                  //                                             bloc.mailList.value[index].scname ?? "",
                  //                                           maxLines: 2,
                  //                                           overflow: TextOverflow.ellipsis,
                  //                                           textAlign: TextAlign.start,
                  //                                           style: const TextStyle(
                  //                                               color: Colors.white,
                  //                                               fontSize: 16,
                  //                                               fontWeight: FontWeight.w400,
                  //                                               // fontStyle: FontStyle.italic
                  //                                           ),
                  //                                         ),
                  //                                       ),
                  //                                       const Icon(
                  //                                         PhosphorIcons.caret_right_bold,
                  //                                         color: Colors.white,
                  //                                         size: 30,
                  //                                       )
                  //                                     ],
                  //                                   ),
                  //                                 ),
                  //                               );
                  //                             }),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}