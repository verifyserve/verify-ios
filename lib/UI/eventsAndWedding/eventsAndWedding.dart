import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:verify/UI/eventsAndWedding/Banquet%20Hall/hoteldetails.dart';
import 'package:verify/UI/eventsAndWedding/Banquet%20Hall/locationdetails.dart';
import 'package:verify/UI/eventsAndWedding/Banquet%20Hall/weddingmain.dart';
import 'package:verify/data/repository/eventsAndWeddingRepository.dart';
import 'package:verify/utils/constant.dart';
import 'package:http/http.dart' as http;

import '../../bloc/eventsAndWeedingBloc.dart';
import '../../data/model/eventSlider.dart';
import '../widgets/comingSoon.dart';


class EventsAndWEdding extends StatefulWidget {
  const EventsAndWEdding({super.key});

  @override
  State<EventsAndWEdding> createState() => _EventsAndWEddingState();
}

class _EventsAndWEddingState extends State<EventsAndWEdding> {

  late EventsAndWeddingBloc bloc;

  //For Event Slider
  Future<List<EventModel>> fetchCarouselData() async {
    final response = await http.get(Uri.parse('https://verifyserve.social/WebService1.asmx/ShowEventimg'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) {
        return EventModel(
          eimage: item['Eimage'],
        );
      }).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    bloc = EventsAndWeddingBloc(context.read<EventsAndWeddingRepository>());
    super.initState();
    bloc.mainPageGrid();
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
      body: ValueListenableBuilder(
          valueListenable: bloc.mainGridLoader,
          builder: (context,bool loading,_) {
            if(loading){
              return const Center(child: CircularProgressIndicator(color: Colors.white,),);
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child: Column(
                  children: [
                    Container(
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
                        )),
                    const SizedBox(height: 20,),

                    FutureBuilder<List<EventModel>>(
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
                                        "https://www.verifyserve.social/upload/${item.eimage}",
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
                              if(index == 0){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WeddingMain()));
                              }
                              else{
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const ComingSoon(isLeading: true)));
                              }
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
                                    child:
                                    CachedNetworkImage(
                                      imageUrl:
                                      "http://www.verifyserve.social/upload/${bloc.mailList.value[index].eimg}",
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
                                      image: "http://www.verifyserve.social/upload/${bloc.mailList.value[index].eimg}",
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
                                      bloc.mailList.value[index].ename ?? "",
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
              ),
            );
          }
      ),
    );
  }
}