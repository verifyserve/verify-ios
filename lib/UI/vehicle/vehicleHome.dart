import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:verify/UI/vehicle/ParkingAlert.dart';
import 'package:verify/UI/vehicle/VehicalSerices.dart';
import 'package:verify/UI/vehicle/parking_notification.dart';
import 'package:verify/bloc/vehicleBLoc.dart';
import 'package:verify/data/model/bikeImageSlider.dart';
import 'package:verify/data/model/carNewLaunches.dart';
import 'package:verify/data/model/fetchServiceVehical.dart';
import 'package:verify/data/model/newLaunchesDetalilPage.dart';
import 'package:verify/data/model/secoundHandCars.dart';
import 'package:verify/data/repository/vehicleRepository.dart';
import 'package:verify/utils/constant.dart';

import '../../data/model/carImageSlider.dart';
import '../../data/model/vehicleImageSlider.dart';
import 'SendParkingAlert.dart';

import 'package:http/http.dart' as http;

class VehicleHome extends StatefulWidget {
  const VehicleHome({super.key});

  @override
  State<VehicleHome> createState() => _VehicleHomeState();
}

class _VehicleHomeState extends State<VehicleHome> {

  late VehicleBloc bloc;

  //For Vehicle Slider
  Future<List<VehicleSlider>> fetchCarouselData() async {
    final response = await http.get(Uri.parse('https://verifyserve.social/WebService1.asmx/ShowVehiclemg'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) {
        return VehicleSlider(
          vimage: item['Vimage'],
        );
      }).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }


  @override
  void initState() {
    bloc = VehicleBloc(context.read<VehicleRepository>());
    super.initState();
    bloc.detailsController.stream.listen((event) {
      print("asdfasdf");
      if (event == "success") {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                RecommendationDetailPage(bloc.details.value)));
      } else {
        print("object");
      }
    });
    bloc.init();
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
        // actions:  [
        //   GestureDetector(
        //     onTap: () {
        //       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const ParkingNotification()));
        //     },
        //     child: const Icon(
        //       PhosphorIcons.bell,
        //       size: 25,
        //     ),
        //   ),
        //   const SizedBox(
        //     width: 20,
        //   ),
        // ],
      ),
      body: ValueListenableBuilder(
          valueListenable: bloc.loader,
          builder: (context, bool loading, _) {
            if (loading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    const SizedBox(
                      height: 15,
                    ),
                   /* Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>  Provider.value(
                                  value: bloc,
                                  child: const SendParkingAlert(),),));
                          },
                          child:const Text(
                           "Send Parking Alert !",
                           style: TextStyle(color: Colors.red, fontSize: 20,fontWeight: FontWeight.w600),
                              )),
                    ),*/
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>  Provider.value(
                            value: bloc,
                            child: const SendParkingAlert(),),));
                      },
                      child: Container(
                        height: 45,
                        width: 1.sw,
                        margin: const EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Colors.red),
                        child: Center(
                          child: Text(
                            "Send Parking Alert !",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                // letterSpacing: 0.8,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    FutureBuilder<List<VehicleSlider>>(
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
                                        "https://www.verifyserve.social/upload/${item.vimage}",
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
                        valueListenable: bloc.frontService,
                        builder: (context, List frontServices, _) {
                          if (frontServices.isEmpty) {
                            return const SizedBox();
                          }
                          return Column(
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Services",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    GridView.count(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      crossAxisCount: 4,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 0.80.h,
                                      children: List.generate(
                                          bloc.frontService.value.length,
                                          (index) {
                                        return InkWell(
                                          onTap: () async {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Provider.value(
                                                          value: bloc,
                                                          child: VehicleServices(data: bloc.frontService.value[index].vname ?? ""))),
                                            );
                                          },


                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              // Icon(Icons.home,size: 35,),
                                              /*Image.network(
                                          "http://www.verifyserve.social/upload/${bloc.frontService.value[index].vimg}",
                                          width: 35,
                                          height: 35,
                                        ),*/
                                              ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5)),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                  "http://www.verifyserve.social/upload/${bloc.frontService.value[index].vimg}",
                                                  height: 35,
                                                  width: 35,
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) => Image.asset(
                                                    AppImages.loading,
                                                    height: 35,
                                                    width: 35,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  errorWidget: (context, error, stack) =>
                                                      Image.asset(
                                                        AppImages.imageNotFound,
                                                        height: 35,
                                                        width: 35,
                                                        fit: BoxFit.cover,
                                                      ),
                                                ),
                                                /*FadeInImage.assetNetwork(
                                                  image:
                                                      "http://www.verifyserve.social/upload/${bloc.frontService.value[index].vimg}",
                                                  height: 35,
                                                  width: 35,
                                                  fit: BoxFit.cover,
                                                  placeholder:
                                                      AppImages.loading,
                                                  imageErrorBuilder:
                                                      (context, error, stack) =>
                                                          Image.asset(
                                                    AppImages.imageNotFound,
                                                            fit: BoxFit.cover,
                                                    height: 35,
                                                    width: 35,
                                                  ),
                                                ),*/
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  bloc.frontService.value[index]
                                                          .vname ??
                                                      "",
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                    ),
                                    const SizedBox(height: 5,),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Provider.value(
                                                        value: bloc,
                                                        child: ShowAllServices(
                                                            data: bloc.frontService.value))));
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        width: 1.sw,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.cyan.withOpacity(0.1),
                                                blurRadius: 5,
                                                spreadRadius:2)
                                          ],
                                          color: Colors.cyan.withOpacity(0.1),
                                        ),
                                        child: const Center(
                                            child: Text("Show all Services",style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                // fontSize: 12
                                            ),)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),

                    /*const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "New Upcoming Cars",
                          style: TextStyle(color: Colors.white,fontSize: 17,fontWeight:FontWeight.w500),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Provider.value(
                                  value: bloc,
                                  child: VerticalList(
                                    type: "CU",
                                    data: bloc.carUpcoming,
                                  )),
                            ));
                          },
                          child:const Text(
                            "view all",
                            style: TextStyle(color: Colors.red,fontWeight:FontWeight.w500,fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 180,
                      child: Provider.value(
                          value: bloc,
                          child: HorizontalList(
                            type: "CU",
                            data: bloc.carUpcoming,
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "New Launches Cars",
                          style: TextStyle(color: Colors.white,fontSize: 17,fontWeight:FontWeight.w500),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Provider.value(
                                    value: bloc,
                                    child: VerticalList(
                                      type: "CN",
                                      data: bloc.carNew,
                                    ))));
                          },
                          child: const Text(
                            "view all",
                            style: TextStyle(color: Colors.red,fontWeight:FontWeight.w500,fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 180,
                      child: Provider.value(
                          value: bloc,
                          child: HorizontalList(
                            type: "CN",
                            data: bloc.carNew,
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 180.0,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 2),
                      ),
                      items: bloc.bikeSlider.map((BikeImageSlider i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return */
                    /*Container(
                              margin: const EdgeInsets.only(right: 10),
                              width: 320.w,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  "http://www.verifyserve.social/upload/${i.bikeimg}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );*/
                    /*
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                width: 320.w,
                                child: ClipRRect(
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                    "http://www.verifyserve.social/upload/${i.bikeimg}",
                                    // height: 35,
                                    // width: 35,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Image.asset(
                                      AppImages.loading,
                                      // height: 35,
                                      // width: 35,
                                      fit: BoxFit.cover,
                                    ),
                                    errorWidget: (context, error, stack) =>
                                        Image.asset(
                                          AppImages.imageNotFound,
                                          // height: 35,
                                          // width: 35,
                                          fit: BoxFit.cover,
                                        ),
                                  ),
                                  */
                    /*FadeInImage.assetNetwork(
                                    image:
                                    "http://www.verifyserve.social/upload/${i.bikeimg}",
                                    // height: 60.h,
                                    // width: 120.w,
                                    fit: BoxFit.cover,
                                    placeholder: AppImages.loading,
                                    imageErrorBuilder: (context, error, stack) =>
                                        Image.asset(
                                          AppImages.imageNotFound,
                                          fit: BoxFit.cover,
                                          // height: 60.h,
                                          // width: 120.w,
                                        ),
                                  ),*/
                    /*
                                ),
                              );
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "New Upcoming Bikes",
                          style: TextStyle(color: Colors.white,fontSize: 17,fontWeight:FontWeight.w500),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Provider.value(
                                    value: bloc,
                                    child: VerticalList(
                                      type: "BU",
                                      data: bloc.bikeUpcoming,
                                    ))));
                          },
                          child: const Text(
                            "view all",
                            style: TextStyle(color: Colors.red,fontWeight:FontWeight.w500,fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 180,
                      child: Provider.value(
                          value: bloc,
                          child: HorizontalList(
                            type: "BU",
                            data: bloc.bikeUpcoming,
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "New Launches Bikes",
                          style: TextStyle(color: Colors.white,fontSize: 17,fontWeight:FontWeight.w500),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Provider.value(
                                    value: bloc,
                                    child: VerticalList(
                                      type: "BN",
                                      data: bloc.bikeNew,
                                    ))));
                          },
                          child:const Text(
                            "view all",
                            style: TextStyle(color: Colors.red,fontWeight:FontWeight.w500,fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 180,
                      child: Provider.value(
                          value: bloc,
                          child: HorizontalList(
                            type: "BN",
                            data: bloc.bikeNew,
                          )),
                    ),*/
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class ShowAllServices extends StatefulWidget {
  const ShowAllServices({super.key, required this.data});
  final List<FrontServiceVehical> data;

  @override
  State<ShowAllServices> createState() => _ShowAllServicesState();
}

class _ShowAllServicesState extends State<ShowAllServices> {
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
      body: ListView.builder(
          itemCount: widget.data.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Provider.value(
                          value: bloc,
                          child: VehicleServices(
                            data: widget.data[index].vname,
                          ))),
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                   /* ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          "http://www.verifyserve.social/upload/${widget.data[index].vimg}",
                          height: 70,
                          width: 70,
                          fit: BoxFit.cover,
                        )),*/
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      child: CachedNetworkImage(
                        imageUrl:
                        "http://www.verifyserve.social/upload/${widget.data[index].vimg}",
                        height: 70,
                        width: 70,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Image.asset(
                          AppImages.loading,
                          height: 70,
                          width: 70,
                          fit: BoxFit.cover,
                        ),
                        errorWidget: (context, error, stack) =>
                            Image.asset(
                              AppImages.imageNotFound,
                              height: 70,
                              width: 70,
                              fit: BoxFit.cover,
                            ),
                      ),
                      /*FadeInImage.assetNetwork(
                        image: "http://www.verifyserve.social/upload/${widget.data[index].vimg}",
                        height: 70,
                        width: 70,
                        fit: BoxFit.cover,
                        placeholder: AppImages.loading,
                        imageErrorBuilder: (context, error, stack) => Image.asset(
                          AppImages.imageNotFound,
                          fit: BoxFit.cover,
                          height: 70,
                          width: 70,
                        ),
                      ),*/
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      widget.data[index].vname ?? "",
                      style: const TextStyle(color: Colors.white, fontSize: 15,fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class HorizontalList extends StatefulWidget {
  const HorizontalList({super.key, required this.data, required this.type});
  final List<NewLaunches> data;
  final String type;

  @override
  State<HorizontalList> createState() => _HorizontalListState();
}

class _HorizontalListState extends State<HorizontalList> {
  late VehicleBloc bloc;

  @override
  void initState() {
    bloc = VehicleBloc(context.read<VehicleRepository>());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.data.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              switch (widget.type) {
                case "CU":
                  bloc.carUpcomingDetail(widget.data[index].id.toString());
                  break;
                case "CN":
                  bloc.carNewDetail(widget.data[index].id.toString());
                  break;
                case "BU":
                  bloc.bikeUpcomingDetail(widget.data[index].id.toString());
                  break;
                case "BN":
                  bloc.bikeNewDetail(widget.data[index].id.toString());
                  break;
              }
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> NewLaunchesDetail(data: widget.data[index],)));
            },
            child: Container(
              padding: const EdgeInsets.only(right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 /* ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        "http://www.verifyserve.social/upload/${widget.data[index].img}",
                        height: 70,
                        width: 70,
                        fit: BoxFit.cover,
                      )),*/
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    child: CachedNetworkImage(
                      imageUrl:
                      "http://www.verifyserve.social/upload/${widget.data[index].img}",
                      height: 100,
                      width: 150,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => Image.asset(
                        AppImages.loading,
                        height: 100,
                        width: 150,
                        fit: BoxFit.fill,
                      ),
                      errorWidget: (context, error, stack) =>
                          Image.asset(
                            AppImages.imageNotFound,
                            height: 100,
                            width: 150,
                            fit: BoxFit.fill,
                          ),
                    ),
                    /*FadeInImage.assetNetwork(
                      image: "http://www.verifyserve.social/upload/${widget.data[index].img}",
                      height: 100,
                      width: 150,
                      fit: BoxFit.fill,
                      placeholder: AppImages.loading,
                      imageErrorBuilder: (context, error, stack) => Image.asset(
                        AppImages.imageNotFound,
                        fit: BoxFit.fill,
                        height: 100,
                        width: 150,
                      ),
                    ),*/
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.data[index].title ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontSize: 12,fontWeight: FontWeight.w500),
                  ),
                  Text(
                    widget.data[index].model != null?"${widget.data[index].model} Model":"",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontSize: 11,fontWeight: FontWeight.w400),
                  ),
                  Text(
                    widget.data[index].price ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.green, fontSize: 12,fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class VerticalList extends StatefulWidget {
  const VerticalList({super.key, required this.data, required this.type});
  final List<NewLaunches> data;
  final String type;

  @override
  State<VerticalList> createState() => _HorizVerticaltate();
}

class _HorizVerticaltate extends State<VerticalList> {
  late VehicleBloc bloc;

  @override
  void initState() {
    bloc = VehicleBloc(context.read<VehicleRepository>());
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
        child: ListView.builder(
            itemCount: widget.data.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  switch (widget.type) {
                    case "CU":
                      await bloc.carUpcomingDetail(widget.data[index].id.toString());

                      break;
                    case "CN":
                      await bloc.carNewDetail(widget.data[index].id.toString());

                      break;
                    case "BU":
                      await bloc.bikeUpcomingDetail(widget.data[index].id.toString());

                      break;
                    case "BN":
                      await bloc.bikeNewDetail(widget.data[index].id.toString());

                      break;
                  }
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> NewLaunchesDetail(data: widget.data[index],)));
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            "http://www.verifyserve.social/upload/${widget.data[index].img}",
                            height: 70,
                            width: 70,
                            fit: BoxFit.cover,
                          )),*/
                      ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        child:  CachedNetworkImage(
                          imageUrl:
                          "http://www.verifyserve.social/upload/${widget.data[index].img}",
                          height: 100,
                          width: 150,
                          fit: BoxFit.fill,
                          placeholder: (context, url) => Image.asset(
                            AppImages.loading,
                            height: 100,
                            width: 150,
                            fit: BoxFit.fill,
                          ),
                          errorWidget: (context, error, stack) =>
                              Image.asset(
                                AppImages.imageNotFound,
                                height: 100,
                                width: 150,
                                fit: BoxFit.fill,
                              ),
                        ),
                        /*FadeInImage.assetNetwork(
                          image: "http://www.verifyserve.social/upload/${widget.data[index].img}",
                          height: 100,
                          width: 150,
                          fit: BoxFit.fill,
                          placeholder: AppImages.loading,
                          imageErrorBuilder: (context, error, stack) => Image.asset(
                            AppImages.imageNotFound,
                            fit: BoxFit.fill,
                            height: 100,
                            width: 150,
                          ),
                        ),*/
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.data[index].title ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.white, fontSize: 14,fontWeight: FontWeight.w500),
                            ),
                            Text(
                              widget.data[index].model != null?"${widget.data[index].model} Model":"",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.white, fontSize: 11,fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(height: 3,),
                            Text(
                              widget.data[index].price ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.green, fontSize: 12,fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class NewLaunchesDetail extends StatelessWidget {
  final NewLaunches data;
  const NewLaunchesDetail({super.key, required this.data});

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
                "http://www.verifyserve.social/upload/${data.img}",
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
                image: "http://www.verifyserve.social/upload/${data.img}",
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
                  Text(data.title ?? "",
                    style: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500),),
                  if(data.smalldescript != null)Text(data.smalldescript ?? " ",
                    style:  TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 12),),
                  Text( data.model != null?"${data.model} Model":"",style: const TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w400),),

                  const SizedBox(height: 3,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(PhosphorIcons.gas_pump,color: Colors.red,size: 25,),
                      const SizedBox(width: 10,),
                      Expanded(child: Text(data.fuleType ??"",style: const TextStyle(color: Colors.white,fontSize: 14),)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(PhosphorIcons.gauge,color: Colors.red,size: 25,),
                      const SizedBox(width: 10,),
                      Expanded(child: Text(data.moterCC ??"",style: const TextStyle(color: Colors.white,fontSize: 14),)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(PhosphorIcons.jeep,color: Colors.red,size: 25,),
                      const SizedBox(width: 10,),
                      Expanded(child: Text(data.carType ??"",style: const TextStyle(color: Colors.white,fontSize: 14),)),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Text(data.price ?? "",style: const TextStyle(color: Colors.green,fontSize: 18,fontWeight: FontWeight.w500),),
                  Divider(color: Colors.grey.withOpacity(0.5),thickness: 1.5,),
                  const Text("Description:",style: TextStyle(color: Colors.red,fontSize: 18,fontWeight: FontWeight.w500),),
                  const SizedBox(height: 5,),
                  Text(data.discription ??"",style: const TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.w400),),
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