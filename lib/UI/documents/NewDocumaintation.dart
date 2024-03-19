import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:verify/UI/documents/addProperty.dart';
import 'package:verify/UI/documents/property%20menus/add_tenant.dart';
import 'package:verify/UI/documents/property%20menus/flat_details.dart';
import 'package:verify/bloc/documentaionBloc.dart';
import 'package:verify/data/model/showAddedTenant.dart';

import '../../../utils/constant.dart';

class FlatList extends StatefulWidget {
  final List<ShowTenant> data;
  final String type;
  final bool? show;
  const FlatList({Key? key, required this.data, required this.type, this.show}) : super(key: key);

  @override
  State<FlatList> createState() => _FlatListState();
}

class _FlatListState extends State<FlatList> {
  late DocumentationBloc bloc;
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
      backgroundColor: widget.show != null ? Colors.black : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            /* SizedBox(
              height: 100,
            ),*/
            /*Container(
              height:100,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    children: [

                    ],
                  )
                ],
              ),
            ),*/
            /*ListView.builder(
              itemCount: 10,
                physics: ScrollPhysics(),
                itemBuilder: (context,index){
                  return
                }
            )*/

            ListView.builder(
                reverse: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.data.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      /* Navigator.push(
                        context,
                      //  MaterialPageRoute(builder: (context) => Provider.value(value: bloc,child: FlatDetails(data: widget.data[index]))),
                      );*/
                    },
                    child: Container(
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
                          //       borderRadius: const BorderRadius.all(Radius.circular(5)),
                          //       child:  CachedNetworkImage(
                          //         imageUrl:
                          //         "http://www.verifyserve.social/upload/${widget.data[index].propertyImage}",
                          //         height: 65.h,
                          //         width: 120.w,
                          //         fit: BoxFit.cover,
                          //         placeholder: (context, url) => Image.asset(
                          //           AppImages.loading,
                          //           height: 65.h,
                          //           width: 120.w,
                          //           fit: BoxFit.cover,
                          //         ),
                          //         errorWidget: (context, error, stack) =>
                          //             Image.asset(
                          //               AppImages.imageNotFound,
                          //               height: 65.h,
                          //               width: 120.w,
                          //               fit: BoxFit.cover,
                          //             ),
                          //       ),
                          //     ),
                          //     const SizedBox(
                          //       width: 10,
                          //     ),
                          //      Expanded(
                          //       child: Column(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         mainAxisAlignment: MainAxisAlignment.start,
                          //         children: [
                          //           SizedBox(
                          //             height: 10,
                          //           ),
                          //           Text(
                          //             widget.data[index].daddres ?? "",
                          //             style: TextStyle(
                          //                 fontSize: 11,
                          //                 fontWeight: FontWeight.w500),
                          //           ),
                          //           SizedBox(
                          //             height: 5,
                          //           ),
                          //           Text(
                          //             "${widget.data[index].dfloor ?? " "}st Floor",
                          //             style: TextStyle(
                          //               fontSize: 10,
                          //               // fontWeight: FontWeight.w500
                          //             ),
                          //           ),
                          //           SizedBox(
                          //             height: 5,
                          //           ),
                          //           Text(
                          //             "${widget.data[index].hometownlocation ??""} ${widget.data[index].dstate ??""}",
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
                              color: Colors.black.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Property',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 25,
                                    ),
                                    SizedBox(
                                      width: 140,
                                      child: Text(
                                        widget.data[index].daddres ?? "",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      width: 140,
                                      child: Text(
                                        " ${widget.data[index].dfloor ??""}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                          // fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      " ${widget.data[index].hometownlocation}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        // fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      " ${widget.data[index].dstate}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        // fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    SizedBox(height: 5,)
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  children: [
                                    SizedBox(height: 20,),
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                                      child:  CachedNetworkImage(
                                        imageUrl:
                                        "http://www.verifyserve.social/upload/${widget.data[index].tenantImage}",
                                        height: 70.h,
                                        width: 80.w,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Image.asset(
                                          AppImages.loading,
                                          height: 65.h,
                                          width: 80.w,
                                          fit: BoxFit.cover,
                                        ),
                                        errorWidget: (context, error, stack) =>
                                            Image.asset(
                                              AppImages.imageNotFound,
                                              height: 65.h,
                                              width: 80.w,
                                              fit: BoxFit.cover,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
      floatingActionButton: widget.show != null ? const SizedBox(): Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 10,horizontal: 10)),

                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Provider.value(
                            value: bloc,
                            child: AddProperty(
                              id: 0,
                            ),
                          ),
                    ),
                  );
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (context) => Provider.value(value: bloc,child: AddTenant(type: widget.type),)));
                },
                child:  Row(
                  children: [
                    const Icon(Icons.add_circle),
                    const SizedBox(width: 5,),
                    Text("Add ",style: const TextStyle(fontSize: 15),),
                  ],
                ),),
            ],
          ),
          const SizedBox(height: 30,)
        ],
      ),
    );
  }
}