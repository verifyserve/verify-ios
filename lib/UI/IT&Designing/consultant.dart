import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:verify/bloc/consultantBloc.dart';
import 'package:verify/data/repository/consultantRepository.dart';
import 'package:verify/utils/constant.dart';

import 'Lawyer/lawyer.dart';
import '../widgets/comingSoon.dart';

class Consultant extends StatefulWidget {
  const Consultant({Key? key}) : super(key: key);

  @override
  State<Consultant> createState() => _ConsultantState();
}

class _ConsultantState extends State<Consultant> {
  late ConsultantBloc bloc;

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
    bloc = ConsultantBloc(context.read<ConsultantRepository>());
    super.initState();
    bloc.mainPageGrid();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      /*appBar: AppBar(
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
      ),*/
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
                  const SizedBox(height: 10,),
                  ListView.builder(
                      physics:const ScrollPhysics(),
                      itemCount: bloc.mailList.value.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // if(index == 0){
                            //   Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) => LawyerList()));
                            // }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const ComingSoon(isLeading: true)));
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
                                  child: CachedNetworkImage(
                                    imageUrl:
                                    "http://www.verifyserve.social/upload/${bloc.mailList.value[index].aimage}",
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
                                    image: "http://www.verifyserve.social/upload/${bloc.mailList.value[index].aimage}",
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
                                    bloc.mailList.value[index].aname ?? "",
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