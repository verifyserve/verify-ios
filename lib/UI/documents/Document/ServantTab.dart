import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/constant.dart';

class aaaa {
  //final int id;
  final String servent_name;
  final String servent_number;
  final String servent_work;
  final String servent_location;
  final String Image;

  aaaa(
      {required this.servent_name, required this.servent_number, required this.servent_work, required this.servent_location,required this.Image});

  factory aaaa.FromJson(Map<String, dynamic>json){
    return aaaa(servent_name: json['servent_name'],
        servent_number: json['servent_number'],
        servent_work: json['servent_work'],
        servent_location: json['servent_location'],
    Image: json['servent_img']);
  }
}

class ServantTab extends StatefulWidget {
  const ServantTab({super.key});

  @override
  State<ServantTab> createState() => _ServantTabState();
}

class _ServantTabState extends State<ServantTab> {

  Future<List<aaaa>> fetchData() async {
    var url = Uri.parse('https://verifyserve.social/WebService1.asmx/ShowDocumaintationServent?userid=2');
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      List listresponce = json.decode(responce.body);
      return listresponce.map((data) => aaaa.FromJson(data)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.only(top: 10),
        child: FutureBuilder<List<aaaa>>(
            future: fetchData(),
            builder: (context,abc) {
              if(abc.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }
              else if(abc.hasError){
                return Text('${abc.error}');
              }
              else if (abc.data == null || abc.data!.isEmpty) {
                // If the list is empty, show an empty image
                return Center(
                  child: Column(
                    children: [
                    //  Lottie.asset("assets/images/no data.json",width: 450),
                      Text("No Data Found!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                    ],
                  ),
                );
              }
              else{
                return GridView.builder(
                  itemCount: abc.data!.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 0.0,
                      childAspectRatio: 2.8
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  height: 100.h,
                                  width: 120.w,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                    "https://www.verifyserve.social/upload/"+abc.data![index].Image,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Image.asset(
                                      AppImages.loading,
                                      fit: BoxFit.cover,
                                    ),
                                    errorWidget: (context, error, stack) =>
                                        Image.asset(
                                          height: 65.h,
                                          width: 120.w,
                                          AppImages.imageNotFound,
                                          fit: BoxFit.cover,
                                        ),
                                  ),
                                ),

                                /*Image(
                                  image: AssetImage('assets/images/menu.png'),
                                  height: 65.h,
                                  width: 120.w,
                                  fit: BoxFit.cover,
                                ),*/
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Iconsax.user_copy,size: 12,color: Colors.red,),
                                        SizedBox(width: 2,),
                                        Text("Name",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: Text(abc.data![index].servent_name.toUpperCase(),
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Icon(Iconsax.mobile_copy,size: 12,color: Colors.red,),
                                        SizedBox(width: 2,),
                                        Text("Mobile",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("+91 ",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.red,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          width: 150,
                                          child: Text(
                                            ""+abc.data![index].servent_number,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(AppImages.work,width: 12,fit: BoxFit.fill,color: Colors.red),
                                        SizedBox(width: 2,),
                                        Text("Occupation",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: Text(
                                        ""+abc.data![index].servent_work,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            }
        ),
      ),
    );
  }
}