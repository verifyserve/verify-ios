import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:verify/bloc/documentaionBloc.dart';
import 'package:verify/data/model/showAddedTenant.dart';
import 'package:verify/data/model/yourInfo.dart';

import '../../../utils/constant.dart';
import 'documents/property menus/Add/add_tenant_servant.dart';

class Flatki_Details extends StatefulWidget {
  final ShowTenant data;
  const Flatki_Details({Key? key, required this.data}) : super(key: key);

  @override
  State<Flatki_Details> createState() => _Flatki_DetailsState();
}

class _Flatki_DetailsState extends State<Flatki_Details> {
  late DocumentationBloc bloc;
  List<String> tittle = ["Show Tenant", "Show Servant"];
  int? pageIndex=0;
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

  @override
  void initState() {
    bloc = context.read<DocumentationBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Column(
        children: [
          SizedBox(height: 15,),
          CarouselSlider(
            options: CarouselOptions(
              height: 180.0,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 2),
            ),
            items: [
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTIZccfNPnqalhrWev-Xo7uBhkor57_rKbkw&usqp=CAU",
              "https://wallpaperaccess.com/full/2637581.jpg"
            ].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 320.w,
                    // decoration: BoxDecoration(
                    //   color: Colors.amber,
                    //   borderRadius:
                    //   const BorderRadius.all(Radius.circular(15)),
                    //   image:DecorationImage(
                    //       image: NetworkImage(i),
                    //       fit: BoxFit.fill
                    //   ),
                    // ),
                    child: ClipRRect(
                      borderRadius:
                      const BorderRadius.all(Radius.circular(15)),
                      child:
                      CachedNetworkImage(
                        imageUrl:
                        i,
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
          const SizedBox(height: 20,),
          SizedBox(
            height: 40,
            child: ListView.builder(
              itemCount: tittle.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    pageIndex = index;
                    if(pageIndex == 1){
                      //bloc.yourInfo(widget.data.dTPid);
                      bloc.yourInfo(widget.data.DPS_id);
                    }
                    setState(() {});
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    margin: const EdgeInsets.only(left: 10,),
                    decoration: BoxDecoration(
                        color:
                        pageIndex == index ? Colors.teal : Colors.white,
                        borderRadius: BorderRadius.circular(100)),
                    child: Text(
                      tittle[index],
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: pageIndex == index
                              ? Colors.white
                              : Colors.black),
                    ),
                  ),
                );
              },
            ),
          ),
          if(pageIndex == 0)Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10,),
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        padding: const EdgeInsets.only(
                            top: 5, left: 5, right: 5, bottom: 5),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [

                            Container(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 10, right: 10, bottom: 10),
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
                                        height: 10,
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          "Naman Raj",
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
                                      Text(
                                        "!st Floor",
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
                                        width: 130,
                                        child: Text(
                                          "From 16/09/22",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.white,
                                            // fontWeight: FontWeight.w500
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                        width: 130,
                                        child: Text(
                                          "₹ 15,000",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.red,
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
                                        'Tenant',
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

                      // Container(
                      //   margin:
                      //       const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      //   padding:
                      //       const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(10),
                      //     border: Border.all(color: Colors.white),
                      //   ),
                      //   child: const Row(
                      //     children: [
                      //       Icon(
                      //         Icons.lock,
                      //         color: Colors.white,
                      //       ),
                      //       SizedBox(
                      //         width: 5,
                      //       ),
                      //       Text(
                      //         "Aadhar Card",
                      //         style: TextStyle(color: Colors.white),
                      //       )
                      //     ],
                      //   ),
                      // )
                    ],
                  )
                ],
              ),
            ),
          ),
          if(pageIndex == 1)const SizedBox(height: 10,),
          if(pageIndex == 1)Expanded(
              child: ValueListenableBuilder(
                  valueListenable: bloc.yourInfoLoader,
                  builder: (context,bool loading,_) {
                    if (loading) {
                      return const Column(
                        children: [
                          SizedBox(height: 30,),
                          CircularProgressIndicator(color: Colors.white,),
                        ],

                      );
                    }
                    return ValueListenableBuilder(valueListenable: bloc.yourInfoData, builder: (context, List<YourInfo> data, child) {
                      if(data.isEmpty){
                        return Column(
                          children: [
                            SizedBox(height: 20,),
                            Text("No Data Found!",style: TextStyle(color: Colors.white),),
                          ],
                        );
                      }
                      return Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            padding: const EdgeInsets.only(
                                top: 5, left: 5, right: 5, bottom: 5),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                // Row(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   mainAxisAlignment: MainAxisAlignment.start,
                                //   children: [
                                //     ClipRRect(
                                //       borderRadius: BorderRadius.circular(5),
                                //       child: Image(
                                //         image: AssetImage('assets/images/image_not_found.png'),
                                //         height: 65.h,
                                //         width: 120.w,
                                //         fit: BoxFit.cover,
                                //       ),
                                //     ),
                                //     SizedBox(
                                //       width: 10,
                                //     ),
                                //     Expanded(
                                //       child: Column(
                                //         crossAxisAlignment: CrossAxisAlignment.start,
                                //         mainAxisAlignment: MainAxisAlignment.start,
                                //         children: [
                                //           SizedBox(
                                //             height: 10,
                                //           ),
                                //           Text(
                                //             'RZ - 12 Som Bazar Road, Sultanp',
                                //             style: TextStyle(
                                //                 fontSize: 11,
                                //                 fontWeight: FontWeight.w500),
                                //           ),
                                //           SizedBox(
                                //             height: 5,
                                //           ),
                                //           Text(
                                //             "1st floorst Floor",
                                //             style: TextStyle(
                                //               fontSize: 10,
                                //               // fontWeight: FontWeight.w500
                                //             ),
                                //           ),
                                //           SizedBox(
                                //             height: 5,
                                //           ),
                                //           Text(
                                //             "Haryana, India New Delhi",
                                //             style: TextStyle(
                                //               fontSize: 10,
                                //               // fontWeight: FontWeight.w500
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //     )
                                //   ],
                                // ),
                                // const SizedBox(height: 5,),
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 10, right: 10, bottom: 10),
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
                                            width: 100,
                                            child: Text(
                                              "Ramu Singh",
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
                                          Text(
                                            "8976563456",
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
                                            width: 130,
                                            child: Text(
                                              "8 A.M to 10 A.M",
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
                                            'Chef',
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

                          // Container(
                          //   margin:
                          //       const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          //   padding:
                          //       const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(10),
                          //     border: Border.all(color: Colors.white),
                          //   ),
                          //   child: const Row(
                          //     children: [
                          //       Icon(
                          //         Icons.lock,
                          //         color: Colors.white,
                          //       ),
                          //       SizedBox(
                          //         width: 5,
                          //       ),
                          //       Text(
                          //         "Aadhar Card",
                          //         style: TextStyle(color: Colors.white),
                          //       )
                          //     ],
                          //   ),
                          // )
                        ],
                      );
                      // return SingleChildScrollView(
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      //     child: Column(
                      //       children: [
                      //         GestureDetector(
                      //           onTap: ()async {
                      //             final imageProvider =
                      //                 Image.network("http://www.verifyserve.social/upload/${data.first.addharcard}").image;
                      //             showImageViewer(context, imageProvider,
                      //                 onViewerDismissed: () {
                      //                   print("dismissed");
                      //                 });
                      //           },
                      //           child: ClipRRect(
                      //             borderRadius: BorderRadius.circular(10),
                      //             child: CachedNetworkImage(
                      //               imageUrl:
                      //               "http://www.verifyserve.social/upload/${data.first.addharcard}",
                      //
                      //               height: 170.h,
                      //               width: 1.sw,
                      //               fit: BoxFit.cover,
                      //               placeholder: (context, url) => Image.asset(
                      //                 AppImages.loading,
                      //                 height: 170.h,
                      //                 width: 1.sw,
                      //                 fit: BoxFit.cover,
                      //               ),
                      //               errorWidget: (context, error, stack) =>
                      //                   Image.asset(
                      //                     AppImages.imageNotFound,
                      //                     height: 170.h,
                      //                     width: 1.sw,
                      //                     fit: BoxFit.cover,
                      //                   ),
                      //             ),
                      //           ),
                      //         ),
                      //         SizedBox(height: 20,),
                      //         GestureDetector(
                      //           onTap: () async{
                      //             final imageProvider =
                      //                 Image.network("http://www.verifyserve.social/upload/${data.first.policeVerificatuion}").image;
                      //             showImageViewer(context, imageProvider,
                      //                 onViewerDismissed: () {
                      //                   print("dismissed");
                      //                 });
                      //           },
                      //           child: ClipRRect(
                      //             borderRadius: BorderRadius.circular(10),
                      //             child: CachedNetworkImage(
                      //               imageUrl:
                      //               "http://www.verifyserve.social/upload/${data.first.policeVerificatuion}",
                      //
                      //               height: 170.h,
                      //               width: 1.sw,
                      //               fit: BoxFit.cover,
                      //               placeholder: (context, url) => Image.asset(
                      //                 AppImages.loading,
                      //                 height: 170.h,
                      //                 width: 120.w,
                      //                 fit: BoxFit.cover,
                      //               ),
                      //               errorWidget: (context, error, stack) =>
                      //                   Image.asset(
                      //                     AppImages.imageNotFound,
                      //                     height: 170.h,
                      //                     width: 1.sw,
                      //                     fit: BoxFit.cover,
                      //                   ),
                      //             ),
                      //           ),
                      //         ),
                      //         SizedBox(height: 20,),
                      //         GestureDetector(
                      //           onTap: ()async  {
                      //             final imageProvider =
                      //                 Image.network("http://www.verifyserve.social/upload/${data.first.rentAggrement}").image;
                      //             showImageViewer(context, imageProvider,
                      //                 onViewerDismissed: () {
                      //                   print("dismissed");
                      //                 },
                      //
                      //                 );
                      //
                      //           },
                      //           child: ClipRRect(
                      //             borderRadius: BorderRadius.circular(10),
                      //             child: CachedNetworkImage(
                      //               imageUrl:
                      //               "http://www.verifyserve.social/upload/${data.first.rentAggrement}",
                      //               height: 170.h,
                      //               width: 1.sw,
                      //               fit: BoxFit.cover,
                      //               placeholder: (context, url) => Image.asset(
                      //                 AppImages.loading,
                      //                 height: 170.h,
                      //                 width: 1.sw,
                      //                 fit: BoxFit.cover,
                      //               ),
                      //               errorWidget: (context, error, stack) =>
                      //                   Image.asset(
                      //                     AppImages.imageNotFound,
                      //                     height: 170.h,
                      //                     width: 120.w,
                      //                     fit: BoxFit.cover,
                      //                   ),
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // );
                    },);
                  }
              )
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Add'),
        icon: Icon(Icons.add),
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Add_Tenant_Servant()));
        },
      ),
    );
  }

}
