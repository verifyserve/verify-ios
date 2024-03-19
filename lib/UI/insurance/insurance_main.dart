import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:verify/Comingsoon.dart';
import 'dart:convert';
import '../../utils/constant.dart';

class aaa {
  final String name;
  final String img;

  aaa(
      {required this.name, required this.img});

  factory aaa.FromJson(Map<String, dynamic>json){
    return aaa(name: json['name'],
        img: json['img']);
  }
}

class InsurancePage extends StatefulWidget {
  const InsurancePage({super.key});

  @override
  State<InsurancePage> createState() => _InsurancePageState();
}

class _InsurancePageState extends State<InsurancePage> {

  final List<ReusableRowInsurance> insurancelist = [
    ReusableRowInsurance(images: "assets/images/life.jpg", title: "Term Life Insurance"),
    ReusableRowInsurance(images: "assets/images/life.jpg", title: "Term Life Insurance"),
    ReusableRowInsurance(images: "assets/images/life.jpg", title: "Term"),
    ReusableRowInsurance(images: "assets/images/life.jpg", title: "Term"),
    ReusableRowInsurance(images: "assets/images/life.jpg", title: "Term"),
  ];

  Future<List<aaa>> life() async {
    var url = Uri.parse('https://verifyserve.social/WebService3_ServiceWork.asmx/life_insu');
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      List listresponce = json.decode(responce.body);
      return listresponce.map((data) => aaa.FromJson(data)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<aaa>> health() async {
    var url = Uri.parse('https://verifyserve.social/WebService3_ServiceWork.asmx/health_insu');
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      List listresponce = json.decode(responce.body);
      return listresponce.map((data) => aaa.FromJson(data)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<aaa>> moter() async {
    var url = Uri.parse('https://verifyserve.social/WebService3_ServiceWork.asmx/moter_insu');
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      List listresponce = json.decode(responce.body);
      return listresponce.map((data) => aaa.FromJson(data)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<aaa>> investment() async {
    var url = Uri.parse('https://verifyserve.social/WebService3_ServiceWork.asmx/investment_insu');
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      List listresponce = json.decode(responce.body);
      return listresponce.map((data) => aaa.FromJson(data)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
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
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Health Insurance',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',
                letterSpacing: 0,
                //decoration: TextDecoration.underline,decorationColor: Colors.blue,
                decorationStyle: TextDecorationStyle.solid,
                decorationThickness: 2.0,
              ),),
              SizedBox(height: 20,),
              FutureBuilder<List<aaa>>(
                  future: health(),
                  builder: (context, abc) {
                    if(abc.hasData){
                      return GridView.builder(
                        itemCount: abc.data!.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 0.0,
                          mainAxisSpacing: 30.0,
                        ),
                        itemBuilder: (BuildContext context, int len) {
                          return GestureDetector(

                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => coming()),
                              );
                            },

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 50.h,
                                  width: 65.w,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                      "https://www.verifyserve.social/upload/"+abc.data![len].img,
                                      //fit: BoxFit.cover,
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
                                ),
                                SizedBox(height: 5,),
                                Expanded(
                                  child: SizedBox(
                                      width: 90,
                                      child: Text(abc.data![len].name,textAlign: TextAlign.center,style: TextStyle(fontSize: 11,fontWeight: FontWeight.w400,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0,),overflow: TextOverflow.ellipsis,maxLines: 2,)),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                    else if(abc.hasError){
                      return Text(abc.error.toString());

                    }
                    else if((abc.connectionState == ConnectionState.waiting)){
                      LinearProgressIndicator(
                        color: Colors.black87,
                      );
                    }
                    return LinearProgressIndicator(
                      color: Colors.black87,
                    );

                    //demo



                }
              ),

              SizedBox(height: 20,),

              Text('Motor Insurance',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',
                letterSpacing: 0,
                //decoration: TextDecoration.underline,decorationColor: Colors.blue,
                decorationStyle: TextDecorationStyle.solid,
                decorationThickness: 2.0,
              ),),
              SizedBox(height: 20,),
              FutureBuilder<List<aaa>>(
                  future: moter(),
                  builder: (context, abc) {

                    if(abc.hasData){
                      return GridView.builder(
                        itemCount: abc.data!.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 0.0,
                          mainAxisSpacing: 30.0,
                        ),
                        itemBuilder: (BuildContext context, int len) {
                          return GestureDetector(

                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => coming()),
                              );
                            },

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 50.h,
                                  width: 65.w,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                      "https://www.verifyserve.social/upload/"+abc.data![len].img,
                                      //fit: BoxFit.cover,
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
                                ),
                                SizedBox(height: 5,),
                                Expanded(
                                  child: SizedBox(
                                      width: 70,
                                      child: Text(abc.data![len].name,textAlign: TextAlign.center,style: TextStyle(fontSize: 11,fontWeight: FontWeight.w400,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0,),overflow: TextOverflow.ellipsis,maxLines: 2,)),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                    else if(abc.hasError){
                      return Text(abc.error.toString());

                    }
                    else if((abc.connectionState == ConnectionState.waiting)){
                      LinearProgressIndicator(
                        color: Colors.black87,
                      );
                    }
                    return LinearProgressIndicator(
                      color: Colors.black87,
                    );
                  }
              ),

              SizedBox(height: 20,),

              Text('Life Insurance',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',
                letterSpacing: 0,
                //decoration: TextDecoration.underline,decorationColor: Colors.blue,
                decorationStyle: TextDecorationStyle.solid,
                decorationThickness: 2.0,
              ),),
              SizedBox(height: 20,),
              FutureBuilder<List<aaa>>(
                  future: life(),
                  builder: (context, abc) {

                    if(abc.hasData){
                      return GridView.builder(
                        itemCount: abc.data!.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 0.0,
                          mainAxisSpacing: 30.0,
                        ),
                        itemBuilder: (BuildContext context, int len) {
                          return GestureDetector(

                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => coming()),
                              );
                            },

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 50.h,
                                  width: 65.w,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                      "https://www.verifyserve.social/upload/"+abc.data![len].img,
                                      //fit: BoxFit.cover,
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
                                ),
                                SizedBox(height: 5,),
                                Expanded(
                                  child: SizedBox(
                                      width: 90,
                                      child: Text(abc.data![len].name,textAlign: TextAlign.center,style: TextStyle(fontSize: 11,fontWeight: FontWeight.w400,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0,),overflow: TextOverflow.ellipsis,maxLines: 2,)),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                    else if(abc.hasError){
                      return Text(abc.error.toString());

                    }
                    else if((abc.connectionState == ConnectionState.waiting)){
                      LinearProgressIndicator(
                        color: Colors.black87,
                      );
                    }
                    return LinearProgressIndicator(
                      color: Colors.black87,
                    );
                  }
              ),

              SizedBox(height: 20,),

              Text('Investment Plans',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',
                letterSpacing: 0,
                //decoration: TextDecoration.underline,decorationColor: Colors.blue,
                decorationStyle: TextDecorationStyle.solid,
                decorationThickness: 2.0,
              ),),
              SizedBox(height: 20,),
              FutureBuilder<List<aaa>>(
                  future: investment(),
                  builder: (context, abc) {

                    if(abc.hasData){
                      return GridView.builder(
                        itemCount: abc.data!.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 0.0,
                          mainAxisSpacing: 30.0,
                        ),
                        itemBuilder: (BuildContext context, int len) {
                          return GestureDetector(

                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => coming()),
                              );
                            },

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 50.h,
                                  width: 65.w,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                      "https://www.verifyserve.social/upload/"+abc.data![len].img,
                                      //fit: BoxFit.cover,
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
                                ),
                                SizedBox(height: 5,),
                                Expanded(
                                  child: SizedBox(
                                      width: 90,
                                      child: Text(abc.data![len].name,textAlign: TextAlign.center,style: TextStyle(fontSize: 11,fontWeight: FontWeight.w400,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0,),overflow: TextOverflow.ellipsis,maxLines: 2,)),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                    else if(abc.hasError){
                      return Text(abc.error.toString());

                    }
                    else if((abc.connectionState == ConnectionState.waiting)){
                      LinearProgressIndicator(
                        color: Colors.black87,
                      );
                    }
                    return LinearProgressIndicator(
                      color: Colors.black87,
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
class ReusableRowInsurance extends StatelessWidget {

  final String images;
  final String title;

  const ReusableRowInsurance({super.key,required this.images,required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 15),
      child: Column(
        children: [
          Image.asset(images),
          SizedBox(height: 5,),
          Text(title),
        ],
      ),
    );
  }
}