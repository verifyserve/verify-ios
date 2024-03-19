import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:verify/data/model/hotelList.dart';
import 'package:verify/data/repository/HotelRepository.dart';

import '../../bloc/hotelBloc.dart';
import '../../data/model/hotelImageSlider.dart';
import '../../utils/constant.dart';
import '../widgets/comingSoon.dart';

class HotelScreen extends StatefulWidget {
  const HotelScreen({Key? key}) : super(key: key);

  @override
  State<HotelScreen> createState() => _HotelScreenState();
}

class _HotelScreenState extends State<HotelScreen> {
  late HotelBloc hotelBloc;
  List<String> topList = ["Hotel", "Guest House", "Home Stay"];
  int? topIndex = 0;

  @override
  void initState() {
    hotelBloc = HotelBloc(context.read<HotelRepository>());
    super.initState();
    hotelBloc.init();
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
          valueListenable: hotelBloc.hotelLoader,
          builder: (context, bool loading, __) {
            if (loading == true) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "Where would you like to go ?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
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
                              size: 18,
                            ),
                            contentPadding: EdgeInsets.only(top: 0, bottom: 9),
                            border: InputBorder.none,
                            hintText: "Search Here...",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        itemCount: topList.length,
                        // physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              topIndex = index;
                              setState(() {});
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                              margin: EdgeInsets.only(left: 10.w, right: 10.w),
                              decoration: BoxDecoration(
                                  color: topIndex == index
                                      ? const Color.fromARGB(255, 242, 216, 184)
                                      : Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: topIndex == index
                                          ? const Color.fromARGB(
                                              255, 242, 216, 184)
                                          : Colors.white,
                                      width: 1)),
                              child: Text(
                                topList[index],
                                style: TextStyle(
                                    color: topIndex == index
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
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 170.0.h,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        autoPlayInterval: const Duration(seconds: 2),
                      ),
                      items: hotelBloc.hotelImageList.map((HotelImageSlider i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              margin: const EdgeInsets.only(right: 10),
                              width: 320.w,
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "http://www.verifyserve.social/upload/${i.img}",
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
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Popular Hotels",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    ValueListenableBuilder(
                        valueListenable: hotelBloc.hotelList,
                        builder: (context, List<HotelList> hotelList, __) {
                          if (hotelList == null) {
                            return const Center(
                                child: Text(
                              "No data found",
                              style: TextStyle(color: Colors.white),
                            ));
                          }
                          return SizedBox(
                            height: 280,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: hotelList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ComingSoon(
                                                    isLeading: true)));
                                  },
                                  child: Container(
                                    width: 0.6.sw,
                                    margin: EdgeInsets.only(
                                        bottom: 10,
                                        top: index == 0 ? 10 : 10,
                                        left: 10,
                                        right: 20),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child:
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 170,
                                          width: 1.sw,
                                          child: ClipRRect(
                                            borderRadius: const BorderRadius.only(topLeft:Radius.circular(5),topRight: Radius.circular(5)),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  "http://www.verifyserve.social/upload/${hotelList[index].img}",
                                              // height: 60.h,
                                              // width: 120.w,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  Image.asset(
                                                AppImages.loading,
                                                // height: 60.h,
                                                // width: 120.w,
                                                fit: BoxFit.cover,
                                              ),
                                              errorWidget:
                                                  (context, error, stack) =>
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                hotelList[index].hname ?? "",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13),
                                              )),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 7),
                                          width: 310,
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.location_on,
                                                size: 20,
                                                color: Colors.blue,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  hotelList[index].location ??
                                                      "",
                                                  style: const TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "₹ ${hotelList[index].price}",
                                                  style: const TextStyle(
                                                      color: Colors.green,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 14),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),


                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                        )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
