import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import '../../../../utils/constant.dart';

class Servant {
  //final int id;
  final String Servant_Name;
  final String Servant_Number;
  final String Work_Timing;
  final String Servant_Work;

  Servant(
      {required this.Servant_Name, required this.Servant_Number, required this.Work_Timing, required this.Servant_Work});

  factory Servant.FromJson(Map<String, dynamic>json){
    return Servant(Servant_Name: json['Servant_Name'],
        Servant_Number: json['Servant_Number'],
        Work_Timing: json['Work_Timing'],
        Servant_Work: json['Servant_Work']);
  }
}

class aaaa {
  //final int id;
  final String Owner_Name;
  final String Owner_Number;
  final String Owner_Email;
  final String Property_type;
  final String PropertyAddress;
  final String Society;
  final String Place;

  aaaa(
      {required this.Owner_Name, required this.Owner_Number, required this.Owner_Email, required this.Property_type,
        required this.PropertyAddress, required this.Society, required this.Place});

  factory aaaa.FromJson(Map<String, dynamic>json){
    return aaaa(Owner_Name: json['Owner_Name'],
        Owner_Number: json['Owner_Number'],
        Owner_Email: json['Owner_Email'],
        Property_type: json['Property_type'],
        PropertyAddress: json['PropertyAddress'],
        Society: json['Society'],
        Place: json['Place']);
  }
}

class Owner_details extends StatefulWidget {
  final String iidd;
  final String num;
  const Owner_details({Key? key, required this.iidd, required this.num}) : super(key: key);


  @override
  State<Owner_details> createState() => _Owner_detailsState();
}

class _Owner_detailsState extends State<Owner_details> {
  List<String> tittle = ["Owner INFO", "SERVANTS", ""];
  int? pageIndex=0;

  Future<List<Servant>> fetchData1(num,id) async {
    var url = Uri.parse('https://verifyserve.social/WebService2.asmx/Show_Documaintation_Servent_Tenents?owner_num=$num&id=$id');
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      List listresponce = json.decode(responce.body);
      return listresponce.map((data) => Servant.FromJson(data)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<aaaa>> fetchData(id) async {
    var url = Uri.parse('https://verifyserve.social/WebService1.asmx/Show_Documaintation_Byid?id=$id');
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
      body: Column(
        children: [
          SizedBox(height: 10,),
          Image.asset(AppImages.documents),
          const SizedBox(height: 20,),
          SizedBox(
            height: 40,
            child: ListView.builder(
              itemCount: tittle.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    pageIndex = index;
                    if(pageIndex == 1){
                      // bloc.yourInfo(widget.data.dTPid);
                    }
                    setState(() {});
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    margin: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        color:
                        pageIndex == index ? Colors.teal : Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      tittle[index],
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: pageIndex == index
                              ? Colors.white
                              : Colors.black),
                    ),
                  ),
                );
              },
            ),
          ),
          if(pageIndex == 0)Expanded(
            child: FutureBuilder<List<aaaa>>(
                future: fetchData(widget.iidd),
                builder: (context,snapshot) {
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
                    return ListView.builder(
                      //itemCount: abc.data!.length,
                        itemCount: 1,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context,int len) {
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(height: 10,),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 10, left: 10, right: 10, bottom: 10),
                                  padding: EdgeInsets.only(
                                      top: 10, left: 10, right: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text("Owner Name",style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600
                                          ),),
                                          // const Spacer(),
                                          // Text("Edit",style: TextStyle(
                                          //     color: Colors.amber,
                                          //     fontSize: 12,
                                          //     fontWeight: FontWeight.w600
                                          // ),),
                                        ],
                                      ),
                                      const SizedBox(height: 5,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 45,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.circular(5),
                                                child: Image.asset(
                                                  AppImages.verify,
                                                  fit: BoxFit.cover,
                                                )),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text(snapshot.data![len].Owner_Name,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 10, left: 10, right: 10, bottom: 10),
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 10, right: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      const Row(
                                        children: [
                                          Text("Contact",style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600
                                          ),),
                                          // Spacer(),
                                          // Text("Edit",style: TextStyle(
                                          //     color: Colors.amber,
                                          //     fontSize: 12,
                                          //     fontWeight: FontWeight.w600
                                          // ),),
                                        ],
                                      ),
                                      const SizedBox(height: 5,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10.0),
                                                color: Colors.white54
                                            ),
                                            child: Icon(Icons.phone,size: 15,),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text(snapshot.data![len].Owner_Number,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 10,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10.0),
                                                color: Colors.white54
                                            ),
                                            child: Icon(Icons.email,size: 15,),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text(snapshot.data![len].Owner_Email,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 10,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10.0),
                                                color: Colors.white54
                                            ),
                                            child: Icon(Icons.location_on,size: 15,),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text("Property Type   "+snapshot.data![len].Property_type,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 10, left: 10, right: 10, bottom: 10),
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 10, right: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      const Row(
                                        children: [
                                          Text("Property Address",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600
                                            ),),
                                          // Spacer(),
                                          // Text("Edit",style: TextStyle(
                                          //     color: Colors.amber,
                                          //     fontSize: 12,
                                          //     fontWeight: FontWeight.w600
                                          // ),),
                                        ],
                                      ),
                                      const SizedBox(height: 5,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10.0),
                                                color: Colors.white54
                                            ),
                                            child: Icon(Icons.home,size: 15,),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text(snapshot.data![len].PropertyAddress,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 10,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10.0),
                                                color: Colors.white54
                                            ),
                                            child: Icon(Icons.home_work,size: 15,),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text(snapshot.data![len].Society,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 10,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10.0),
                                                color: Colors.white54
                                            ),
                                            child: Icon(Icons.location_on,size: 15,),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text(snapshot.data![len].Place,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                    );
                  }

                }
            ),
          ),
          if(pageIndex == 1)const SizedBox(height: 10,),
          if(pageIndex == 1)Expanded(
              child: FutureBuilder<List<Servant>>(
                  future: fetchData1(widget.num,widget.iidd),
                  builder: (context,snapshot){
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
                      return  ListView.builder(
                          itemCount: snapshot.data!.length,
                          // itemCount: 1,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context,int len){
                            return GestureDetector(

                              onTap: () {

                              },

                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    padding: const EdgeInsets.only(
                                        top: 5, left: 5, right: 5, bottom: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [

                                        Container(
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 10, right: 5, bottom: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(0.7),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(5),
                                                child: Image(
                                                  image: AssetImage('assets/images/image_not_found.png'),
                                                  height: 75,
                                                  width: 70,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),

                                              const Spacer(),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  SizedBox(
                                                    width: 100,
                                                    child: Text('   '+snapshot.data![len].Servant_Name,
                                                      //'hlo',
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w500),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    '   +91 '+snapshot.data![len].Servant_Number,
                                                    //'hlo',
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.white,
                                                      // fontWeight: FontWeight.w500
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  SizedBox(
                                                    width: 130,
                                                    child: Text(
                                                      '   '+snapshot.data![len].Work_Timing,
                                                      //'hlo',
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                        color: Colors.white,
                                                        // fontWeight: FontWeight.w500
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    snapshot.data![len].Servant_Work,
                                                    //'hlo',
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w700),),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                            );

                          });
                    }
                  }
              ),
          ),
          if(pageIndex == 2)SizedBox(
            height: 20,
          ),
          if(pageIndex == 2)Column(
            children: [
              Expanded(
                child:
                /* FutureBuilder<List<Servant>>(
                    future: fetchData1(widget.iidd,widget.num),
                    builder: (context,ser){
                      if(ser.hasData){
                        return  ListView.builder(
                            itemCount: ser.data!.length,
                            // itemCount: 1,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context,int len){
                              return GestureDetector(

                                onTap: () {

                                },

                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                      padding: const EdgeInsets.only(
                                          top: 5, left: 5, right: 5, bottom: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.6),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        children: [

                                          Container(
                                            padding: const EdgeInsets.only(
                                                top: 10, left: 10, right: 5, bottom: 10),
                                            decoration: BoxDecoration(
                                              color: Colors.black.withOpacity(0.7),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(5),
                                                  child: Image(
                                                    image: AssetImage('assets/images/image_not_found.png'),
                                                    height: 75,
                                                    width: 70,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),

                                                const Spacer(),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    SizedBox(
                                                      width: 100,
                                                      child: Text(//'   '+ser.data![len].Servant_Name,
                                                        'hlo',
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.w500),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      //'   +91 '+ser.data![len].Servant_Number,
                                                      'hlo',
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                        color: Colors.white,
                                                        // fontWeight: FontWeight.w500
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    SizedBox(
                                                      width: 130,
                                                      child: Text(
                                                       // '   '+ser.data![len].Work_Timing,
                                                        'hlo',
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          color: Colors.white,
                                                          // fontWeight: FontWeight.w500
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const Spacer(),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      //ser.data![len].Servant_Work,
                                                      'hlo',
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w700),),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                              );

                            });
                      }
                      else if(ser.hasError){
                        return Text(ser.error.toString());

                      }
                      return const LinearProgressIndicator(
                        color: Colors.black87,
                      );
                    }

                ),*/
                Center(child: Text('Hello',style: TextStyle(color: Colors.white)),)
              ),
            ],
          ),
        ],
      ),
    );
  }
}