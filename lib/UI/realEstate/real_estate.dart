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
import 'Residential_filter.dart';

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

  void _showBottomSheet(BuildContext context) {

    List<String> timing = [
      "Residential",
      "Plots",
      "Commercial",
    ];
    ValueNotifier<int> timingIndex = ValueNotifier(0);

    String displayedData = "Press a button to display data";

    void updateData(String newData) {
      setState(() {
        displayedData = newData;
      });
    }

    showModalBottomSheet(
      backgroundColor: Colors.black,
      context: context,
      builder: (BuildContext context) {
        return  DefaultTabController(
          length: 2,
          child: Padding(
            padding: const EdgeInsets.only(left: 5,right: 5,top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5,),
                Container(
                  padding: EdgeInsets.all(3),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), color: Colors.grey),
                  child: TabBar(
                    indicator: BoxDecoration(
                      color: Colors.red[500],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    // ignore: prefer_const_literals_to_create_immutables
                    tabs: [
                      Tab(text: 'Residential'),
                      Tab(text: 'Commercial'),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(children: [
                    Residential_filter(),
                    Residential_filter()
                  ]),
                )
              ],
            ),
          ),
        );
      },
    );
  }

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
              /*FutureBuilder<List<RealstateModel>>(
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
              ),*/


              Container(
                height: 45,
                width: 1.sw,
                margin: const EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.pink, Colors.red],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: (){
                    _showBottomSheet(context);
                  },
                  child: Text(
                    "Find Property",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 5,
              ),

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
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: widget.data.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  /*Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return Provider.value(value: bloc,child: RealEstateDetail(id: '${widget.data[index].tPid}',),);
                  },));*/
                },
                child: Container(
                  width: 200,
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
                          width: 200,
                          child:ClipRRect(
                            borderRadius: const BorderRadius.only(topLeft:Radius.circular(5),topRight: Radius.circular(5)),
                            child:  CachedNetworkImage(
                              imageUrl:
                              "https://www.verifyserve.social/${widget.data[index].imagesh}",
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
                         padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text("${bloc.buyRentDetailsData.first.tital} With ${bloc.buyRentDetailsData.first.balcony} Balcony" ,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13
                                  ),
                                )
                            ),
                             Text(
                               widget.data[index].Buy_Rent ?? "",
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
                                  widget.data[index].title ?? "",
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
