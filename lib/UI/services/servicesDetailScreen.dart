import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verify/utils/constant.dart';

import '../../bloc/servicesBloc.dart';
import '../../data/repository/servicesRepository.dart';

class ServicesDetailScreen extends StatefulWidget {
  final int? id;
  const ServicesDetailScreen(this.id,{super.key});

  @override
  State<ServicesDetailScreen> createState() => _ServicesDetailScreenState();
}

class _ServicesDetailScreenState extends State<ServicesDetailScreen> {
  late ServiceBloc bloc;
  late SharedPreferences preferences;
  ValueNotifier<String>name=ValueNotifier("");
  @override
  void initState() {
    bloc = context.read<ServiceBloc>();
    super.initState();
    bloc.subDetails(widget.id);
    init();
  }

  init()async{
    preferences=await SharedPreferences.getInstance();
    name.value=preferences.getString("location")??'';
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
        builder: (context, bool loading,__) {
          if(loading==true){
            return  const Center(child: CircularProgressIndicator(color: Colors.white,),);
          }
          return SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Container(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 210,
                      width: 1.sw,
                      child: CachedNetworkImage(
                        imageUrl:
                        "http://www.verifyserve.social/upload/${bloc.subDe.first.subimg}",
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
                    /*Image.asset(
                      AppImages.static2,
                      height: 210,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),*/
                    const SizedBox(
                      height: 10,
                    ),
                     Text(
                      "${bloc.subDe.first.title}",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                     Text(
                      "${bloc.subDe.first.experience}",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.home,color: Colors.yellow,size: 20,),
                        SizedBox(width: 2,),
                        Text("${bloc.subDe.first.address}",style: TextStyle(color: Colors.white),)
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                     ValueListenableBuilder(
                       valueListenable: name,
                       builder: (context, String names,__) {
                         return Text(
                          names,
                          style: TextStyle(color: Colors.blue),
                    );
                       }
                     ),
                    const SizedBox(
                      height: 10,
                    ),
                   /* const Text(
                      "(Reviews)",
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ListView.builder(
                      itemCount: 3,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index){
                        return const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              minLeadingWidth: 10,
                              horizontalTitleGap: 10,
                              leading: Padding(
                                padding: EdgeInsets.only(top: 5.0),
                                child: Icon(Icons.person,color: Colors.white,size: 28,),
                              ),
                              title: Text(
                                "Raj yadav",
                                style: TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                "feb 22,2023",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Text(
                              "this is the review message!",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        );
                      },
                    ),*/
                  ],
                ),
              ),
            ),
          );
        }
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: const Color(0xff0c280d),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(onPressed: (){}, child: const Text("Book Later",style: TextStyle(fontSize: 18,color: Colors.white),)),
            TextButton(onPressed: (){}, child: const Text("Book Now",style: TextStyle(fontSize: 18,color: Colors.white),)),
          ],
        ),
      ),
    );
  }
}
