import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../data/model/aboutModel.dart';
import '../../data/model/privacypolicyModel.dart';
import '../../data/model/termsModel.dart';
import '../../utils/constant.dart';
import 'package:http/http.dart' as http;

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  AboutPageModel? aboutPageModel;

  PrivacyPageModel? privacyPageModel;

  PrivacyTermsModel? termsModel;

  Future<List<AboutPageModel>> FetchAboutApi() async {
    final url = Uri.parse('https://verifyserve.social/WebService3_ServiceWork.asmx/Show_AboutPage');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      print(response.body.toString());
      return result.map((e) => AboutPageModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<PrivacyPageModel>> FetchPrivacyApi() async {
    final url = Uri.parse('https://verifyserve.social/WebService3_ServiceWork.asmx/Show_PrivacyPolicy');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      print(response.body.toString());
      return result.map((e) => PrivacyPageModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<PrivacyTermsModel>> FetchTermsConditionsApi() async {
    final url = Uri.parse('https://verifyserve.social/WebService3_ServiceWork.asmx/Show_TermsCondition');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      print(response.body.toString());
      return result.map((e) => PrivacyTermsModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(child: Image(image: AssetImage("assets/images/about us.png"),alignment: Alignment.center,width: 370,)),
                SizedBox(height: 10,),
                Center(
                  child: Container(
                    width: 150,
                      padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 0.7, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.redAccent.withOpacity(0.9),
                            blurRadius: 10,
                            offset: Offset(0, 0),
                            blurStyle: BlurStyle.outer,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Text('ABOUT US',textAlign: TextAlign.center,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 1,decoration: TextDecoration.none),)),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                //height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 0.2, color: Colors.white),
                ),
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Iconsax.arrow_right,color: Colors.white,),
                        SizedBox(width: 8,),
                        Text('About Verify',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 1),),
                      ],
                    ),

                    SizedBox(height: 10,),

                    FutureBuilder<List<AboutPageModel>>(
                        future: FetchAboutApi(),
                        builder: (context,snapshot){
                          if(snapshot.hasData){
                            return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext context,int index){
                                  return GestureDetector(
                                    onTap: () {

                                    },
                                    child: Text('${snapshot.data![index].aBoutus}',textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.grey,fontFamily: 'Poppins',letterSpacing: 0.3),),
                                  );
                                });
                          }
                          else if(snapshot.hasError){
                            return Text('${snapshot.error}');
                          }else if(snapshot.data == null){

                          }
                          return Center(child: CircularProgressIndicator());
                        }

                    ),

                    SizedBox(height: 20,),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Iconsax.arrow_right,color: Colors.white,),
                        SizedBox(width: 8,),
                        Text('Privacy Policy',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 1),),
                      ],
                    ),

                    SizedBox(height: 10,),

                    FutureBuilder<List<PrivacyPageModel>>(
                        future: FetchPrivacyApi(),
                        builder: (context,snapshot){
                          if(snapshot.hasData){
                            return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext context,int index){
                                  return GestureDetector(
                                    onTap: () {

                                    },
                                    child: Text('${snapshot.data![index].privacypolicy}',textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.grey,fontFamily: 'Poppins',letterSpacing: 0.3),),
                                  );
                                });
                          }
                          else if(snapshot.hasError){
                            return Text('${snapshot.error}');
                          }else if(snapshot.data == null){

                          }
                          return Center(child: CircularProgressIndicator());
                        }

                    ),

                    SizedBox(height: 20,),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Iconsax.arrow_right,color: Colors.white,),
                        SizedBox(width: 8,),
                        Text('Terms & Conditions',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 1),),
                      ],
                    ),

                    SizedBox(height: 10,),

                    FutureBuilder<List<PrivacyTermsModel>>(
                        future: FetchTermsConditionsApi(),
                        builder: (context,snapshot){
                          if(snapshot.hasData){
                            return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext context,int index){
                                  return GestureDetector(
                                    onTap: () {

                                    },
                                    child: Text('${snapshot.data![index].termsandconditions}',textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.grey,fontFamily: 'Poppins',letterSpacing: 0.3),),
                                  );
                                });
                          }
                          else if(snapshot.hasError){
                            return Text('${snapshot.error}');
                          }else if(snapshot.data == null){

                          }
                          return Center(child: CircularProgressIndicator());
                        }

                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}