import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:verify/UI/vehicle/CategoryView.dart';
import 'package:verify/bloc/vehicleBLoc.dart';
import 'package:verify/data/model/newLaunchesDetalilPage.dart';
import 'package:verify/data/model/secoundHandCars.dart';
import 'package:verify/data/model/showBrand.dart';
import 'package:verify/utils/constant.dart';

import '../documents/property menus/Add/AddTenant_Documaintation.dart';
import '../documents/property menus/Add/AddTenant_Documaintation.dart';
import '../documents/property menus/add_tenant.dart';
import '../documents/property menus/flat_details.dart';

class VehicleServices extends StatefulWidget {
  final String? data;
  const VehicleServices({super.key, required this.data});

  @override
  State<VehicleServices> createState() => _VehicleServicesState();
}

class _VehicleServicesState extends State<VehicleServices> {
  late VehicleBloc bloc;

@override
  void initState() {
    bloc = context.read<VehicleBloc>();
    super.initState();
    init();
  }

  init()async{
    if(widget.data == "Second Hand Cars"){
      await bloc.showBrand();
      await bloc.allSecoundCars();
    }
    if(widget.data == "Second Hand Bikes"){
      await bloc.showBrandBike();
      await bloc.allSecoundBike();
    }
  }
  @override
  Widget build(BuildContext context) {
    print("get url: ${widget.data}");
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
      body: ValueListenableBuilder(valueListenable: bloc.isLoading, builder: (context,bool loading,_){
        if(loading){
          return const Center(
            child: CircularProgressIndicator(color: Colors.white,),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
          child:
          widget.data == "Second Hand Cars" || widget.data == "Second Hand Bikes" ?
          serviceContent(type: widget.data):
          const Center(child: Text("Coming Soon",style: TextStyle(color: Colors.white),),),
        );
      }),
    );
  }
}

class serviceContent extends StatefulWidget {
  final String? type;
  const serviceContent({super.key, required this.type});

  @override
  State<serviceContent> createState() => _serviceContentState();
}

class _serviceContentState extends State<serviceContent> {
  late VehicleBloc bloc;

  @override
  void initState() {
    bloc = context.read<VehicleBloc>();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueListenableBuilder(valueListenable: bloc.showBrands, builder: (context,List<ShowBrand> data,_){
            if(data.isEmpty){
              return const SizedBox();
            }
            return Column(
              children: [
                Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     const Text("Brands",style: TextStyle(color: Colors.white,fontSize: 22,fontWeight:FontWeight.w500),),
                     GestureDetector( onTap: (){
                       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Provider.value(value: bloc,child:CategoriesView(data: data,type: widget.type,))));              },
                         child:const Text("see all",style: TextStyle(color: Colors.red,fontWeight:FontWeight.w500,fontSize: 15),)),
                   ],
                 ),

                const SizedBox(height: 20,),
                SizedBox(
                  height: 70,
                  child: ListView.builder(
                      itemCount: data.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index) {
                        return GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Provider.value(value: bloc,child: RecommendationsPageView2(type: widget.type,isAppbar: true,id: data[index].bname),)));
                          },
                          child: Container(
                            // padding: EdgeInsets.only(right: 30,left: index==0?10:30),
                            margin: EdgeInsets.only(right: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white.withOpacity(0.7),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 3,
                                    spreadRadius: 2)
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                              child:  CachedNetworkImage(
                                imageUrl:
                                "http://www.verifyserve.social/upload/${data[index].bimg}",
                                height: 70,
                                width: 100,
                                fit: BoxFit.fill,
                                placeholder: (context, url) => Image.asset(
                                  AppImages.loading,
                                  height: 70,
                                  width: 100,
                                  fit: BoxFit.fill,
                                ),
                                errorWidget: (context, error, stack) =>
                                    Image.asset(
                                      AppImages.imageNotFound,
                                      height: 70,
                                      width: 100,
                                      fit: BoxFit.fill,
                                    ),
                              ),
                              /*FadeInImage.assetNetwork(
                                image: "http://www.verifyserve.social/upload/${data[index].bimg}",
                                // height: 60,
                                // width: 150,
                                height: 70,
                                width: 100,
                                fit: BoxFit.fill,
                                placeholder: AppImages.loading,
                                imageErrorBuilder: (context, error, stack) => Image.asset(
                                  AppImages.imageNotFound,
                                  fit: BoxFit.fill,
                                  height: 70,
                                  width: 100,
                                ),
                              ),*/
                            ),
                          ),
                        );
                      }
                  ),
                ),
              ],
            );
          }),
          const SizedBox(height: 15,),
          const Text("Fresh Recommendations",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight:FontWeight.w500),),
          const SizedBox(height: 15,),
          Expanded(child: Provider.value(value: bloc,child: RecommendationsPageView(type: widget.type,isAppbar: false,))),
        ],
      ),
    );
  }
}

class RecommendationsPageView2 extends StatefulWidget {
  const RecommendationsPageView2({super.key,required this.isAppbar,required this.id, this.type});
  final bool isAppbar;
  final String? id;
  final String? type;

  @override
  State<RecommendationsPageView2> createState() => _RecommendationsPageView2State();
}

class _RecommendationsPageView2State extends State<RecommendationsPageView2> {
  late VehicleBloc bloc;

  @override
  void initState() {
    bloc = context.read<VehicleBloc>();
    super.initState();
    init();
  }

  init()async{
    if(widget.type == "Second Hand Cars"){
      await bloc.showCarsByBrand(widget.id.toString());
    }
    if(widget.type == "Second Hand Bikes"){
      print("object");
      await  bloc.showBikeByBrand(widget.id.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: widget.isAppbar ? AppBar(
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
        ): null,
        body:
            ValueListenableBuilder(valueListenable: bloc.isLoading, builder: (context,bool loading,_){
              if(loading){
                return const Center(child: CircularProgressIndicator(color: Colors.white,),);
              }
              return   ValueListenableBuilder(valueListenable: bloc.showByBrands, builder: (context,List<SecoundHandCars> data,_){
                if(data.isEmpty){
                  return const Center(child: Text("No Data Found!",style: TextStyle(color: Colors.white),),);
                }
                return Column(
                  children: [
                    Expanded(
                      child: GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.75.h,
                        children: List.generate(data.length, (index) {
                          return Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 3,
                                    spreadRadius: 2)
                              ],
                            ),
                            child: InkWell(
                              onTap: (){
                                // print(data[index].toJson());
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RecommendationDetailPage2(data[index])));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                 /* ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.network(
                                        "http://www.verifyserve.social/upload/${data[index].svimg}",
                                        fit: BoxFit.fill,
                                        height: 110,
                                        width: 1.sw,
                                      )),*/
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                    child:  CachedNetworkImage(
                                      imageUrl:
                                      "http://www.verifyserve.social/upload/${data[index].svimg}",
                                      height: 110,
                                      width: 150,
                                      fit: BoxFit.fill,
                                      placeholder: (context, url) => Image.asset(
                                        AppImages.loading,
                                        height: 110,
                                        width: 150,
                                        fit: BoxFit.fill,
                                      ),
                                      errorWidget: (context, error, stack) =>
                                          Image.asset(
                                            AppImages.imageNotFound,
                                            height: 110,
                                            width: 150,
                                            fit: BoxFit.fill,
                                          ),
                                    ),
                                   /* FadeInImage.assetNetwork(
                                      image: "http://www.verifyserve.social/upload/${data[index].svimg}",
                                      height: 110,
                                      width: 150,
                                      fit: BoxFit.fill,
                                      placeholder: AppImages.loading,
                                      imageErrorBuilder: (context, error, stack) => Image.asset(
                                        AppImages.imageNotFound,
                                        fit: BoxFit.fill,
                                        height: 110,
                                        width: 150,
                                      ),
                                    ),*/
                                  ),
                                  // Image.asset(AppImages.documents),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    data[index].brand ??"",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(color: Colors.white, fontSize: 14,fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    data[index].price ??"",
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        color: Colors.green, fontSize: 13,fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.location_on,size: 18,color: Colors.blue,),
                                      Flexible(
                                        child: Text(
                                          data[index].locat ??"",
                                          textAlign: TextAlign.start,
                                          maxLines: 2,
                                          overflow: TextOverflow.fade,
                                          style: const TextStyle(
                                              color: Colors.white, fontSize: 11,fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                );

              });

            })
        );
  }
}

class RecommendationsPageView extends StatefulWidget {
  const RecommendationsPageView({super.key,required this.isAppbar, required this.type});
  final bool isAppbar;
  final String? type;

  @override
  State<RecommendationsPageView> createState() => _RecommendationsPageViewState();
}

class _RecommendationsPageViewState extends State<RecommendationsPageView> {
  late VehicleBloc bloc;

  @override
  void initState() {
    bloc = context.read<VehicleBloc>();
    super.initState();
    // init();
  }
  init( ) async {
    if(widget.type == "Second Hand Cars"){
      await bloc.showCarsByBrand(widget.type.toString());
    }
    if(widget.type == "Second Hand Bikes"){
      print("objectw");
      await bloc.showBikeByBrand(widget.type.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: widget.isAppbar ? AppBar(
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
      ): null,
      body:
      ValueListenableBuilder(valueListenable: bloc.secoundHandCars, builder: (context,List<SecoundHandCars> data,_){
        if(data.isEmpty){
          return const Center(child: CircularProgressIndicator(color: Colors.white,),);
        }
        return Column(
          children: [
            Expanded(
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7.h,
                children: List.generate(data.length, (index) {
                  return Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white.withOpacity(0.1),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 3,
                            spreadRadius: 2)
                      ],
                    ),
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RecommendationDetailPage2(data[index])));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                         /* ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                "http://www.verifyserve.social/upload/${data[index].svimg}",
                                fit: BoxFit.fill,
                                height: 110,
                                width: 1.sw,
                              )),*/
                          ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            child:  CachedNetworkImage(
                              imageUrl:
                              "http://www.verifyserve.social/upload/${data[index].svimg}",
                              height: 110,
                              width: 150,
                              fit: BoxFit.fill,
                              placeholder: (context, url) => Image.asset(
                                AppImages.loading,
                                height: 110,
                                width: 150,
                                fit: BoxFit.fill,
                              ),
                              errorWidget: (context, error, stack) =>
                                  Image.asset(
                                    AppImages.imageNotFound,
                                    height: 110,
                                    width: 150,
                                    fit: BoxFit.fill,
                                  ),
                            ),
                            /*FadeInImage.assetNetwork(
                              image: "http://www.verifyserve.social/upload/${data[index].svimg}",
                              height: 110,
                              width: 150,
                              fit: BoxFit.fill,
                              placeholder: AppImages.loading,
                              imageErrorBuilder: (context, error, stack) => Image.asset(
                                AppImages.imageNotFound,
                                fit: BoxFit.fill,
                                height: 110,
                                width: 150,
                              ),
                            ),*/
                          ),
                          // Image.asset(AppImages.documents),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            data[index].brand ??"",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: const TextStyle(color: Colors.white, fontSize: 14,fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            data[index].price ??"",
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Colors.green, fontSize: 13,fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.location_on,size: 18,color: Colors.blue,),
                              Flexible(
                                child: Text(
                                  data[index].locat ??"",
                                  textAlign: TextAlign.start,
                                  maxLines: 2,
                                  overflow: TextOverflow.fade,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 11,fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        );

        })
    );
  }
}

class RecommendationDetailPage extends StatelessWidget {
  final List<LaunchesDetailsPage> data;
  const RecommendationDetailPage(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(AppImages.documents),
            const SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("₹ 1200000",style: TextStyle(color: Colors.cyan,fontSize: 20),),
                  const SizedBox(height: 10,),
                  const Text("The price of mahindra xuv700 starts at rs. 14.01 lakh and goes upto Rs. 26.18 Lakh",
                    style: TextStyle(color: Colors.white,fontSize: 16),),
                  const SizedBox(height: 10,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.location_on,color: Colors.grey,size: 20,),
                      SizedBox(width: 10,),
                      Expanded(child: Text("Sultanpur, New Delhi  110042",style: TextStyle(color: Colors.white,fontSize: 16),)),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Divider(color: Colors.grey.withOpacity(0.5),thickness: 1.5,),
                  const SizedBox(height: 10,),
                  const Text("Description:",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),),
                  const SizedBox(height: 10,),
                  const Text("orem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,:",style: TextStyle(color: Colors.white,fontSize: 16,),),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: const Color(0xff0c280d),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(onPressed: (){}, child: const Text("Contact",style: TextStyle(fontSize: 18,color: Colors.white),)),
            TextButton(onPressed: (){}, child: const Text("Make offer",style: TextStyle(fontSize: 18,color: Colors.white),)),
          ],
        ),
      ),
    );
  }
}

class RecommendationDetailPage2 extends StatelessWidget {
  final SecoundHandCars data;
  const RecommendationDetailPage2(this.data, {super.key});

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           /* Image.network(
              "http://www.verifyserve.social/upload/${data.svimg}",
              fit: BoxFit.cover,
              width: 1.sw,
            ),*/
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              child:  CachedNetworkImage(
                imageUrl:
                "http://www.verifyserve.social/upload/${data.svimg}",
                // height: 350,
                width: 1.sw,
                fit: BoxFit.fill,
                placeholder: (context, url) => Image.asset(
                  AppImages.loading,
                  // height: 350,
                  width: 1.sw,
                  fit: BoxFit.fill,
                ),
                errorWidget: (context, error, stack) =>
                    Image.asset(
                      AppImages.imageNotFound,
                      // height: 350,
                      width: 1.sw,
                      fit: BoxFit.fill,
                    ),
              ),
              /*FadeInImage.assetNetwork(
                image: "http://www.verifyserve.social/upload/${data.svimg}",
                // height: 350,
                width: 1.sw,
                fit: BoxFit.fill,
                placeholder: AppImages.loading,
                imageErrorBuilder: (context, error, stack) => Image.asset(
                  AppImages.imageNotFound,
                  fit: BoxFit.fill,
                  // height: 350,
                  width:1.sw,
                ),
              ),*/
            ),
            // Image.asset(AppImages.documents),
            const SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5,),
                  Text(data.brand ?? "",style: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500),),
                  Text(data.smalldescript ?? "",
                    style:  TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 12),),
                  Text(data.mname ?? "",
                    style: const TextStyle(color: Colors.white,fontSize: 15),),
                  Text(data.price ?? "",style: const TextStyle(color: Colors.green,fontSize: 18,fontWeight: FontWeight.w500),),
                  const SizedBox(height: 3,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.location_on,color: Colors.blue,size: 20,),
                      const SizedBox(width: 3,),
                      Expanded(child: Text(data.locat ??"",style: const TextStyle(color: Colors.white,fontSize: 14),)),
                    ],
                  ),
                  // const SizedBox(height: 10,),
                  Divider(color: Colors.grey.withOpacity(0.5),thickness: 1.5,),
                  const Text("Description:",style: TextStyle(color: Colors.red,fontSize: 18,fontWeight: FontWeight.w500),),
                  const SizedBox(height: 5,),
                  Text(data.bigdescript ??"",style: const TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.w400),),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        // color: const Color(0xff0c280d),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 45,
              width: 0.47.sw,
              // margin: const EdgeInsets.symmetric(horizontal: 50),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  color: Colors.pink),
              child:const Center(
                child: Text(
                  "Buy",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      // letterSpacing: 0.8,
                      fontSize: 16),
                ),
              ),
            ),
            Container(
              height: 45,
              width: 0.47.sw,
              // margin: const EdgeInsets.symmetric(horizontal: 50),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  color: Colors.white.withOpacity(0.3)),
              child:const Center(
                child: Text(
                  "Contact Seller",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      // letterSpacing: 0.8,
                      fontSize: 16),
                ),
              ),
            ),
            // TextButton(onPressed: (){}, child: const Text("BUY",style: TextStyle(fontSize: 18,color: Colors.white),)),
            // TextButton(onPressed: (){}, child: const Text("CONTACT SELLER",style: TextStyle(fontSize: 18,color: Colors.white),)),
          ],
        ),
      ),
    );
  }
}