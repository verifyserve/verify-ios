import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:verify/bloc/truckBloc.dart';
import 'package:verify/data/repository/TruckRepositrory.dart';

import '../../data/model/truckIist.dart';
import '../../utils/constant.dart';
import '../widgets/comingSoon.dart';

class TruckScreen extends StatefulWidget {
  const TruckScreen({Key? key}) : super(key: key);

  @override
  State<TruckScreen> createState() => _TruckScreenState();
}

class _TruckScreenState extends State<TruckScreen>with SingleTickerProviderStateMixin  {
  late TabController _tabController;
  late TruckBloc truckBloc;
  List<String> topList = ["LCV", "Truck", "Hyva","Container", "Chota Hathi", "Trailer","Tanker"];
  int? topIndex = 0;
  List<String> topList1 = ["BackHoe Loaders", "Excavators", "Telescopic Handlers","Skid Steer Loaders", "Wheel Loaders"];
  int? topIndex1 = 0;
  @override
  void initState() {
    truckBloc = TruckBloc(context.read<TruckRepository>());
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    truckBloc.truckListGrid();
    truckBloc.jcbListGrid();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar:AppBar(
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
          const SizedBox(height: 10,),
          Expanded(
              child: Container(
                height: 1.sh,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(topLeft:Radius.circular(40),topRight: Radius.circular(40)),
                    color: Colors.white
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 55,
                      child: TabBar(
                        indicatorColor: Colors.red,
                        isScrollable: true,
                        unselectedLabelColor: Colors.black,
                        labelColor: Colors.red,
                        labelStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18
                        ),
                        unselectedLabelStyle:  const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 17
                        ),
                        controller: _tabController, tabs: const [
                        Padding(
                          padding: EdgeInsets.only(right: 50,left: 50),
                          child: Text("TRUCK"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 50,right: 50),
                          child: Text("JCB"),
                        ),
                      ],
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 1.sh,
                        child: TabBarView(
                          controller: _tabController,
                          children:  [
                            ValueListenableBuilder(
                                valueListenable: truckBloc.truckLoader,
                                builder: (context,bool loading,__){
                                  if(loading==true){
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    );
                                  }
                                  return Container(
                                    color: Colors.black,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "Select vehical type for your load",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10,),
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
                                                        horizontal: 15, vertical: 10),
                                                    margin: EdgeInsets.only(left: 10.w, right: 5.w),
                                                    decoration: BoxDecoration(
                                                        color: topIndex == index
                                                            ?  Colors.white
                                                            : Colors.grey.withOpacity(0.3),
                                                        borderRadius: BorderRadius.circular(10),
                                                        ),
                                                    child: Text(
                                                      topList[index],
                                                      style: TextStyle(
                                                          color: topIndex == index
                                                              ? Colors.black
                                                              : Colors.white,
                                                      fontWeight: topIndex==index?FontWeight.w600:FontWeight.w500),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          const SizedBox(height: 10,),
                                          ValueListenableBuilder(
                                            valueListenable: truckBloc.truckList,
                                            builder: (context,List<TruckList>truckList,__) {
                                              if (truckList == null) {
                                                return const Center(
                                                    child: Text(
                                                      "No data found",
                                                      style: TextStyle(color: Colors.white),
                                                    ));
                                              }
                                              return Expanded(
                                                child: GridView.count(
                                                  shrinkWrap: true,
                                                  crossAxisCount: 2,
                                                  crossAxisSpacing: 10,
                                                  mainAxisSpacing: 10,
                                                  childAspectRatio: 0.65,
                                                  children: List.generate(truckList.length, (index) {
                                                    return Container(
                                                      padding: const EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        color: Colors.grey.withOpacity(0.1),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Colors.grey.withOpacity(0.2),
                                                              blurRadius: 3,
                                                              spreadRadius: 2)
                                                        ],
                                                      ),
                                                      child: InkWell(
                                                        onTap: (){
                                                          // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RecommendationDetailPage2(data[index])));
                                                        },
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                              child:  CachedNetworkImage(
                                                                imageUrl:
                                                                "http://www.verifyserve.social/upload/${truckList[index].img}",
                                                                height: 110,
                                                                width: 1.sw,
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
                                                            ),
                                                            // Image.asset(AppImages.documents),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              truckList[index].loading ??"",
                                                              maxLines: 2,
                                                              overflow: TextOverflow.ellipsis,
                                                              textAlign: TextAlign.start,
                                                              style: const TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.w600),
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                const Icon(PhosphorIcons.check_circle_fill,size: 18,color: Colors.green,),
                                                                const SizedBox(width: 3,),
                                                                Flexible(
                                                                  child: Text(
                                                                    truckList[index].varified ??"",
                                                                    maxLines: 1,
                                                                    overflow: TextOverflow.fade,
                                                                    textAlign: TextAlign.start,
                                                                    style: const TextStyle(
                                                                        color: Colors.white, fontSize: 14,fontWeight: FontWeight.w400),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                const Icon(PhosphorIcons.jeep,size: 18,color: Colors.blue,),
                                                                const SizedBox(width: 3,),
                                                                Flexible(
                                                                  child: Text(
                                                                    truckList[index].vno ??"",
                                                                    textAlign: TextAlign.start,
                                                                    maxLines: 2,
                                                                    overflow: TextOverflow.fade,
                                                                    style: const TextStyle(
                                                                        color: Colors.white, fontSize: 14,fontWeight: FontWeight.w400),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Center(
                                                              child: GestureDetector(
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                          const ComingSoon(
                                                                              isLeading: true)));
                                                                },
                                                                child: Container(
                                                                  padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 6),
                                                                  decoration: const BoxDecoration(
                                                                    color: CupertinoColors.systemYellow,
                                                                    borderRadius: BorderRadius.all(Radius.circular(5)
                                                                    ),
                                                                  ),
                                                                  child: const Text(
                                                                    "View Trucks",
                                                                    style: TextStyle(
                                                                      color: Colors.black,
                                                                      fontWeight: FontWeight.w600
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              );
                                            }
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                            ),
                            ValueListenableBuilder(
                                valueListenable: truckBloc.truckLoader,
                                builder: (context,bool loading,__){
                                  if(loading==true){
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    );
                                  }
                                  return Container(
                                    color: Colors.black,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "Select vehical type for your load",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10,),
                                          SizedBox(
                                            height: 40,
                                            child: ListView.builder(
                                              itemCount: topList1.length,
                                              // physics: const NeverScrollableScrollPhysics(),
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    topIndex1 = index;
                                                    setState(() {});
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets.symmetric(
                                                        horizontal: 15, vertical: 10),
                                                    margin: EdgeInsets.only(left: 10.w, right: 5.w),
                                                    decoration: BoxDecoration(
                                                      color: topIndex1 == index
                                                          ?  Colors.white
                                                          : Colors.grey.withOpacity(0.3),
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    child: Text(
                                                      topList1[index],
                                                      style: TextStyle(
                                                          color: topIndex1 == index
                                                              ? Colors.black
                                                              : Colors.white,
                                                          fontWeight: topIndex1==index?FontWeight.w600:FontWeight.w500),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          const SizedBox(height: 10,),
                                          ValueListenableBuilder(
                                              valueListenable: truckBloc.jcbList,
                                              builder: (context,List<TruckList>truckList,__) {
                                                if (truckList == null) {
                                                  return const Center(
                                                      child: Text(
                                                        "No data found",
                                                        style: TextStyle(color: Colors.white),
                                                      ));
                                                }
                                                return Expanded(
                                                  child: GridView.count(
                                                    shrinkWrap: true,
                                                    crossAxisCount: 2,
                                                    crossAxisSpacing: 10,
                                                    mainAxisSpacing: 10,
                                                    childAspectRatio: 0.65,
                                                    children: List.generate(truckList.length, (index) {
                                                      return Container(
                                                        padding: const EdgeInsets.all(10),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: Colors.grey.withOpacity(0.1),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: Colors.grey.withOpacity(0.2),
                                                                blurRadius: 3,
                                                                spreadRadius: 2)
                                                          ],
                                                        ),
                                                        child: InkWell(
                                                          onTap: (){
                                                            // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RecommendationDetailPage2(data[index])));
                                                          },
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                                child:  CachedNetworkImage(
                                                                  imageUrl:
                                                                  "http://www.verifyserve.social/upload/${truckList[index].img}",
                                                                  height: 110,
                                                                  width: 1.sw,
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
                                                              ),
                                                              // Image.asset(AppImages.documents),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                truckList[index].loading ??"",
                                                                maxLines: 2,
                                                                overflow: TextOverflow.ellipsis,
                                                                textAlign: TextAlign.start,
                                                                style: const TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.w600),
                                                              ),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  const Icon(PhosphorIcons.check_circle_fill,size: 18,color: Colors.green,),
                                                                  const SizedBox(width: 3,),
                                                                  Flexible(
                                                                    child: Text(
                                                                      truckList[index].varified ??"",
                                                                      maxLines: 1,
                                                                      overflow: TextOverflow.fade,
                                                                      textAlign: TextAlign.start,
                                                                      style: const TextStyle(
                                                                          color: Colors.white, fontSize: 14,fontWeight: FontWeight.w400),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  const Icon(PhosphorIcons.jeep,size: 18,color: Colors.blue,),
                                                                  const SizedBox(width: 3,),
                                                                  Flexible(
                                                                    child: Text(
                                                                      truckList[index].vno ??"",
                                                                      textAlign: TextAlign.start,
                                                                      maxLines: 2,
                                                                      overflow: TextOverflow.fade,
                                                                      style: const TextStyle(
                                                                          color: Colors.white, fontSize: 14,fontWeight: FontWeight.w400),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Center(
                                                                child: GestureDetector(
                                                                  onTap: () {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                            const ComingSoon(
                                                                                isLeading: true)));
                                                                  },
                                                                  child: Container(
                                                                    padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 6),
                                                                    decoration: const BoxDecoration(
                                                                      color: CupertinoColors.systemYellow,
                                                                      borderRadius: BorderRadius.all(Radius.circular(5)
                                                                      ),
                                                                    ),
                                                                    child: const Text(
                                                                      "View JCB",
                                                                      style: TextStyle(
                                                                          color: Colors.black,
                                                                          fontWeight: FontWeight.w600
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                                  ),
                                                );
                                              }
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}
