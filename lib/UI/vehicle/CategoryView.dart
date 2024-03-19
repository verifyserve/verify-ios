

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:provider/provider.dart';
import 'package:verify/UI/vehicle/VehicalSerices.dart';
import 'package:verify/bloc/vehicleBLoc.dart';
import 'package:verify/data/model/showBrand.dart';

import '../../utils/constant.dart';

class CategoriesView extends StatefulWidget {
  final List<ShowBrand> data;
  final String? type;
  const CategoriesView({super.key, required this.data,required this.type});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView.builder(
          padding: EdgeInsets.only(top: 20,bottom: 10),
          itemCount: widget.data.length,itemBuilder: (context,index){
          return GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Provider.value(value: bloc,child: RecommendationsPageView2(isAppbar: true,id: widget.data[index].bname,type: widget.type),)));
            },
            child: Container(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  /*Image.network(
                    "http://www.verifyserve.social/upload/${widget.data[index].bimg}",
                    height: 100,
                    width: 100,
                    fit: BoxFit.fill,
                  ),*/
                  Container(
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
                        "http://www.verifyserve.social/upload/${widget.data[index].bimg}",
                        height: 100,
                        width: 130,
                        fit: BoxFit.fill,
                        placeholder: (context, url) => Image.asset(
                          AppImages.loading,
                          height: 100,
                          width: 130,
                          fit: BoxFit.fill,
                        ),
                        errorWidget: (context, error, stack) =>
                            Image.asset(
                              AppImages.imageNotFound,
                              height: 100,
                              width: 130,
                              fit: BoxFit.fill,
                            ),
                      ),
                     /* FadeInImage.assetNetwork(
                        image: "http://www.verifyserve.social/upload/${widget.data[index].bimg}",
                        height: 100,
                        width: 130,
                        fit: BoxFit.fill,
                        placeholder: AppImages.loading,
                        imageErrorBuilder: (context, error, stack) => Image.asset(
                          AppImages.imageNotFound,
                          fit: BoxFit.fill,
                          height: 100,
                          width: 130,
                        ),
                      ),*/
                    ),
                  ),
                  // Icon(Icons.home,color: Colors.white,size: 28,),
                  const SizedBox(width: 20,),
                  Expanded(child: Text(widget.data[index].bname ?? "",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 18),)),
                  // const Spacer(),
                  // Icon(PhosphorIcons.caret_right,color: Colors.white,size: 25,),
                ],
              ),
            ),
          );
        },),
      ),
    );
  }
}
