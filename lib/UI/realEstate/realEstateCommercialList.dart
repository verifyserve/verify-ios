import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:verify/UI/realEstate/commercialDetail.dart';
import 'package:verify/UI/realEstate/pgDetail.dart';
import 'package:verify/UI/realEstate/real_estateDeatail.dart';
import 'package:verify/bloc/realEstateBloc.dart';
import 'package:verify/data/model/commercialDetail.dart';
import 'package:verify/data/model/realestateFilter.dart';
import 'package:verify/utils/constant.dart';

class RealEstateCommercialList extends StatefulWidget {
  final List<commercialPGDetail> data;
  final String? type;
  RealEstateCommercialList({super.key, required this.data, this.type});

  @override
  State<RealEstateCommercialList> createState() => _RealEstateCommercialListState();
}

class _RealEstateCommercialListState extends State<RealEstateCommercialList> {
  late RealEstateBloc bloc;

  @override
  void initState() {
    bloc = context.read<RealEstateBloc>();
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
        padding: EdgeInsets.only(top: 20,bottom: 10),
        itemCount: widget.data.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if(widget.type == "pg"){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return Provider.value(value: bloc,child: PGDetail(id: '${widget.data[index].id}',),);
                },));
              }
              else {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return Provider.value(value: bloc,child: CommercialDetail(id: '${widget.data[index].id}',),);
                },));
              }

              // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Provider.value(value: bloc,child: RealEstateDetail(id: "${widget.data[index].tPid}" ),)));
            },
            child: Container(
              width: 1.sw,
              margin: EdgeInsets.only(
                  bottom: 20, top: index == 0 ? 10 : 0, left: 20, right: 20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 170,
                    width: 1.sw,
                    child:  ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
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
                      /* FadeInImage.assetNetwork(
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
                  /*ClipRRect(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(widget.data[index].title ??"",style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13
                        ),)),
                        const SizedBox(width: 10,),
                        Text(
                          widget.type == "pg" ? "Available" :"Available",
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
                        Text(widget.data[index].location??"",style: TextStyle(
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
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
