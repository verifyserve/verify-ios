import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../../utils/constant.dart';
import '../documents/Document/pdfscreen.dart';
import 'Show_Document/Image_SHow.dart';

class Catid_Tenant {
  final int id;
  final String Name_;
  final String Number;
  final String Father_name;
  final String Occupation;
  final String Date_of_birth;
  final String Permanent_address;
  final String District;
  final String Pin_code;
  final String Police_station;
  final String Place;
  final String front;
  final String back;
  final String photo;

  Catid_Tenant(
      {required this.id,required this.Name_,required this.Number,required this.Father_name,required this.Occupation,
        required this.Date_of_birth, required this.Permanent_address,required this.District,required this.Pin_code,
        required this.Police_station,required this.Place,required this.front,required this.back,required this.photo});

  factory Catid_Tenant.FromJson(Map<String, dynamic>json){
    return Catid_Tenant(id: json['id'],
        Name_: json['Name_'],
        Number: json['Number'],
        Father_name: json['Father_name'],
        Occupation: json['Occupation'],
        Date_of_birth: json['Date_of_birth'],
        Permanent_address: json['Permanent_address'],
        District: json['District'],
        Pin_code: json['Pin_code'],
        Police_station: json['Police_station'],
        Place: json['Place'],
        front: json['addhar_front'],
        back: json['addhar_back'],
        photo: json['passprot_size']);
  }
}

class My_Documents extends StatefulWidget {
  const My_Documents({super.key});

  @override
  State<My_Documents> createState() => _My_DocumentsState();
}

class _My_DocumentsState extends State<My_Documents> {

  Future<List<Catid_Tenant>> fetchData(numb) async{
    var url=Uri.parse("https://verifyserve.social/WebService4.asmx/show_store_document_by_number_?number=$numb");
    final responce=await http.get(url);
    if(responce.statusCode==200){
      List listresponce=json.decode(responce.body);
      return listresponce.map((data) => Catid_Tenant.FromJson(data)).toList();
    }
    else{
      throw Exception('Unexpected error occured!');
    }
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late SharedPreferences preferences;
  ValueNotifier<String>number=ValueNotifier("");

  @override
  void initState() {
    super.initState();
    init();
  }

  init()async {
    preferences = await SharedPreferences.getInstance();
    number.value = preferences.getString("phone") ?? '';
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
            Navigator.pop(context, true);

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
              //Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Delete_Image()));
            },
            child: const Icon(
              PhosphorIcons.pencil,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),

      body:SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            ValueListenableBuilder(
                valueListenable: number,
                builder: (context, String num,__) {
                return FutureBuilder<List<Catid_Tenant>>(
                      future: fetchData(num),
                      builder: (context, snapshot) {
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              if(snapshot.connectionState == ConnectionState.waiting){
                                return Center(child: CircularProgressIndicator());
                              }
                              else if(snapshot.hasError){
                                return Text('${snapshot.error}');
                              }
                              else if (snapshot.data == null || snapshot.data!.isEmpty) {
                                // If the list is empty, show an empty image
                                return Center(
                                  child: Column(
                                    children: [
                                      // Lottie.asset("assets/images/no data.json",width: 450),
                                      Text("No Data Found!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                                    ],
                                  ),
                                );
                              }
                              else{

                                return Column(
                                  children: [

                                    SizedBox(
                                      height: 130,
                                      width: 200,
                                      child:ClipRRect(
                                        borderRadius: const BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20),bottomLeft:Radius.circular(20),bottomRight: Radius.circular(20)),
                                        child:  CachedNetworkImage(
                                          imageUrl:
                                          "https://verifyserve.social/PHP_Files/Main_Document/Add_Document_api/${snapshot.data![index].photo}",
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
                                      ),
                                    ),

                                    //SizedBox(height: 10,),

                                    Container(
                                      //color: Colors.black,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage("assets/images/bg.png"),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      height: 100,
                                      child: Column(
                                        children: [

                                          SizedBox(height: 10,),
                                          Text("${snapshot.data![index].Name_}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                                          SizedBox(height: 5,),
                                          Text("${snapshot.data![index].Number}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),


                                        ],
                                      ),
                                    ),

                                    //Text("Passport Size Photo",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),

                                    SizedBox(height: 0,),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          height: 150,
                                          width: 170,
                                          child:Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              ClipRRect(
                                                borderRadius: const BorderRadius.only(topLeft:Radius.circular(5),topRight: Radius.circular(5),bottomLeft:Radius.circular(5),bottomRight: Radius.circular(5)),
                                                child:  CachedNetworkImage(
                                                  imageUrl:
                              "https://verifyserve.social/PHP_Files/Main_Document/Add_Document_api/${snapshot.data![index].front}",
                                                   height: 100,
                                                  // width: 120.w,
                                                  fit: BoxFit.fill,
                                                  placeholder: (context, url) => Image.asset(
                                                    AppImages.loading,
                                                    // height: 60.h,
                                                    // width: 120.w,
                                                    fit: BoxFit.fill,
                                                  ),
                                                  errorWidget: (context, error, stack) =>
                                                      Image.asset(
                                                        AppImages.imageNotFound,
                                                        // height: 60.h,
                                                        // width: 120.w,
                                                        fit: BoxFit.cover,
                                                      ),
                                                ),
                                              ),

                                              SizedBox(height: 10,),

                                              Text("AadharCard Front Image",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),

                                            ],
                                          ),
                                        ),

                                        Container(
                                          height: 150,
                                          child: SizedBox(
                                            height: 150,
                                            width: 170,
                                            child:Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius: const BorderRadius.only(topLeft:Radius.circular(5),topRight: Radius.circular(5),bottomLeft:Radius.circular(5),bottomRight: Radius.circular(5)),
                                                  child:  CachedNetworkImage(
                                                    imageUrl:
                                                    "https://verifyserve.social/PHP_Files/Main_Document/Add_Document_api/${snapshot.data![index].back}",
                                                     height: 100,
                                                    // width: 120.w,
                                                    fit: BoxFit.fill,
                                                    placeholder: (context, url) => Image.asset(
                                                      AppImages.loading,
                                                      // height: 60.h,
                                                      // width: 120.w,
                                                      fit: BoxFit.fill,
                                                    ),
                                                    errorWidget: (context, error, stack) =>
                                                        Image.asset(
                                                          AppImages.imageNotFound,
                                                          // height: 60.h,
                                                          // width: 120.w,
                                                          fit: BoxFit.cover,
                                                        ),
                                                  ),
                                                ),

                                                SizedBox(height: 10,),

                                                Text("AadharCard Back Image",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),

                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 0,),

                                    Positioned(
                                        top: 290,
                                        right: 0.0,
                                        left: 0.0,
                                        height: 120,
                                        child: Container(
                                          margin: EdgeInsets.only(left: 10,right: 10),
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              color: Colors.white
                                          ),
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(Iconsax.location_copy,size: 12,color: Colors.red,),
                                                        SizedBox(width: 2,),
                                                        Text("Father Name",
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                              fontSize: 11,
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.w600),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(width: 5,),
                                                    Row(
                                                      children: [
                                                        SizedBox(width: 2,),
                                                        Text("Resident Place",
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                              fontSize: 11,
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.w600),
                                                        ),
                                                        SizedBox(width: 2,),
                                                        Icon(Iconsax.location_copy,size: 12,color: Colors.red,),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 150,
                                                      padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(5),
                                                        border: Border.all(width: 1, color: Colors.purpleAccent),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Colors.purpleAccent.withOpacity(0.5),
                                                              blurRadius: 10,
                                                              offset: Offset(0, 0),
                                                              blurStyle: BlurStyle.outer
                                                          ),
                                                        ],
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          // Icon(Iconsax.sort_copy,size: 15,),
                                                          //SizedBox(width: 10,),
                                                          Text("${snapshot.data![index].Father_name}",
                                                            maxLines: 2/*+abc.data![len].Building_Name.toUpperCase()*/,
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors.black,
                                                                fontWeight: FontWeight.w500,
                                                                letterSpacing: 0.5
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    SizedBox(
                                                      width: 20,
                                                    ),

                                                    GestureDetector(
                                                      onTap: (){

                                                      },
                                                      child: Container(
                                                        width: 150,
                                                        padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5),
                                                          border: Border.all(width: 1, color: Colors.blueAccent),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: Colors.blueAccent.withOpacity(0.5),
                                                                blurRadius: 10,
                                                                offset: Offset(0, 0),
                                                                blurStyle: BlurStyle.outer
                                                            ),
                                                          ],
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            // Icon(Iconsax.sort_copy,size: 15,),
                                                            //SizedBox(width: 10,),
                                                            Text("${snapshot.data![index].Place}",maxLines: 2/*+abc.data![len].Building_Name.toUpperCase()*/,
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.w500,
                                                                  letterSpacing: 0.5
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10,),

                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(Iconsax.personalcard,size: 12,color: Colors.red,),
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
                                                    SizedBox(width: 5,),
                                                    Row(
                                                      children: [
                                                        SizedBox(width: 2,),
                                                        Text("Date Of birth",
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                              fontSize: 11,
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.w600),
                                                        ),
                                                        SizedBox(width: 2,),
                                                        Icon(Iconsax.data,size: 12,color: Colors.red,),
                                                      ],
                                                    ),
                                                  ],
                                                ),

                                                SizedBox(
                                                  height: 5,
                                                ),

                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 150,
                                                      padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(5),
                                                        border: Border.all(width: 1, color: Colors.brown),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Colors.brown.withOpacity(0.5),
                                                              blurRadius: 10,
                                                              offset: Offset(0, 0),
                                                              blurStyle: BlurStyle.outer
                                                          ),
                                                        ],
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          // Icon(Iconsax.sort_copy,size: 15,),
                                                          //SizedBox(width: 10,),
                                                          Text("${snapshot.data![index].Occupation}",maxLines: 2/*+abc.data![len].Building_Name.toUpperCase()*/,
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors.black,
                                                                fontWeight: FontWeight.w500,
                                                                letterSpacing: 0.5
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    SizedBox(
                                                      width: 20,
                                                    ),

                                                    GestureDetector(
                                                      onTap: (){

                                                      },
                                                      child: Container(
                                                        width: 150,
                                                        padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5),
                                                          border: Border.all(width: 1, color: Colors.indigo),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: Colors.indigo.withOpacity(0.5),
                                                                blurRadius: 10,
                                                                offset: Offset(0, 0),
                                                                blurStyle: BlurStyle.outer
                                                            ),
                                                          ],
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            // Icon(Iconsax.sort_copy,size: 15,),
                                                            //SizedBox(width: 10,),
                                                            Text("${snapshot.data![index].Date_of_birth}"/*+abc.data![len].Building_Name.toUpperCase()*/,
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.w500,
                                                                  letterSpacing: 0.5
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10,),

                                                Row(
                                                  children: [
                                                    Icon(Iconsax.location_copy,size: 12,color: Colors.red,),
                                                    SizedBox(width: 2,),
                                                    Text("Your Permanent Address",
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
                                                  height: 5,
                                                ),

                                                Padding(
                                                  padding: const EdgeInsets.only(right: 10,left: 10),
                                                  child: Container(
                                                    padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(5),
                                                      border: Border.all(width: 1, color: Colors.deepPurple),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.deepPurple.withOpacity(0.5),
                                                            blurRadius: 10,
                                                            offset: Offset(0, 0),
                                                            blurStyle: BlurStyle.outer
                                                        ),
                                                      ],
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        // Icon(Iconsax.sort_copy,size: 15,),
                                                        //SizedBox(width: 10,),
                                                        Text("${snapshot.data![index].Permanent_address}",maxLines: 5/*+abc.data![len].Building_Name.toUpperCase()*/,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.w500,
                                                              letterSpacing: 0.5
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                                SizedBox(height: 10,),

                                                Row(
                                                  children: [
                                                    Icon(Iconsax.location_copy,size: 12,color: Colors.red,),
                                                    SizedBox(width: 2,),
                                                    Text("Your Permanent Address Police Station",
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
                                                  height: 5,
                                                ),

                                                Container(
                                                  width: 300,
                                                  padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                    border: Border.all(width: 1, color: Colors.black),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.black.withOpacity(0.5),
                                                          blurRadius: 10,
                                                          offset: Offset(0, 0),
                                                          blurStyle: BlurStyle.outer
                                                      ),
                                                    ],
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      // Icon(Iconsax.sort_copy,size: 15,),
                                                      //SizedBox(width: 10,),
                                                      Text("${snapshot.data![index].Police_station}"/*+abc.data![len].Building_Name.toUpperCase()*/,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w500,
                                                            letterSpacing: 0.5
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                SizedBox(height: 10,),

                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(Iconsax.personalcard,size: 12,color: Colors.red,),
                                                        SizedBox(width: 2,),
                                                        Text("Permanent District",
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                              fontSize: 11,
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.w600),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(width: 5,),
                                                    Row(
                                                      children: [
                                                        SizedBox(width: 2,),
                                                        Text("Permanent Pin Code",
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                              fontSize: 11,
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.w600),
                                                        ),
                                                        SizedBox(width: 2,),
                                                        Icon(Iconsax.code,size: 12,color: Colors.red,),
                                                      ],
                                                    ),
                                                  ],
                                                ),

                                                SizedBox(
                                                  height: 5,
                                                ),

                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 150,
                                                      padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(5),
                                                        border: Border.all(width: 1, color: Colors.orangeAccent),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Colors.orangeAccent.withOpacity(0.5),
                                                              blurRadius: 10,
                                                              offset: Offset(0, 0),
                                                              blurStyle: BlurStyle.outer
                                                          ),
                                                        ],
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          // Icon(Iconsax.sort_copy,size: 15,),
                                                          //SizedBox(width: 10,),
                                                          Text("${snapshot.data![index].District}"/*+abc.data![len].Building_Name.toUpperCase()*/,
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors.black,
                                                                fontWeight: FontWeight.w500,
                                                                letterSpacing: 0.5
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    SizedBox(
                                                      width: 20,
                                                    ),

                                                    GestureDetector(
                                                      onTap: (){

                                                      },
                                                      child: Container(
                                                        width: 150,
                                                        padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5),
                                                          border: Border.all(width: 1, color: Colors.greenAccent),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: Colors.greenAccent.withOpacity(0.5),
                                                                blurRadius: 10,
                                                                offset: Offset(0, 0),
                                                                blurStyle: BlurStyle.outer
                                                            ),
                                                          ],
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            // Icon(Iconsax.sort_copy,size: 15,),
                                                            //SizedBox(width: 10,),
                                                            Text("${snapshot.data![index].Pin_code}"/*+abc.data![len].Building_Name.toUpperCase()*/,
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.w500,
                                                                  letterSpacing: 0.5
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10,),
                                              ]
                                          ),
                                        )),

                                  ],
                                );

                              }

                            }
                        );
                      }
                  );
              }
            ),
          ],
        ),
      ),

    );
  }
}
