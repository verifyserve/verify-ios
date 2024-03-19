import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constant.dart';

class Catid{
  //final int id;
  final String service_name;
  final String date;
  final String time;
  Catid({required this.service_name,required this.date,required this.time});
  factory Catid.FromJson(Map<String,dynamic>json){
    return Catid(service_name: json['work'],date: json['date'],time: json['time']);

  }
}

class Service_history extends StatefulWidget {
  const Service_history({super.key});

  @override
  State<Service_history> createState() => _Service_historyState();
}

class _Service_historyState extends State<Service_history> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late SharedPreferences preferences;
  ValueNotifier<String>id=ValueNotifier("");

  @override
  void initState() {
    super.initState();
    init();
  }

  init()async{
    preferences=await SharedPreferences.getInstance();
    id.value=preferences.getString("id")??'';

  }

  Future<List<Catid>> fetchData(id) async{

    var url=Uri.parse("https://verifyserve.social/WebService2.asmx/New_Service_history?id=$id");
    /*Map<String,dynamic> data = {
      "location":preferences.getString("location"),
      "Serivicelist_id":"$id",
    };*/
    //return List.from(resData.map((e) => SubService.fromJson(e)));
    final responce=await http.get(url,);
    if(responce.statusCode==200){
      List listresponce=json.decode(responce.body);
      return listresponce.map((data) => Catid.FromJson(data)).toList();
    }
    else{
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

      body: Container(
        width: double.infinity,
        child: ValueListenableBuilder(
            valueListenable: id,
            builder: (context, String n,__) {
              return FutureBuilder<List<Catid>>(
                  future: fetchData(n),
                  builder: (context,abc){
                    if(abc.hasData){
                      return  ListView.builder(
                          itemCount: abc.data!.length,
                          //itemCount: 1,
                          reverse: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context,int len){
                            return GestureDetector(

                              onTap: () async {
                                //  int itemId = abc.data![len].id;
                                //int iiid = abc.data![len].PropertyAddress
                                /*SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.setString('id_Document', abc.data![len].id.toString());
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ShowProperty(iidd: abc.data![len].id.toString()))

                              );*/
                              },

                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                padding: const EdgeInsets.only(
                                    top: 1, left: 1, right: 1, bottom: 1),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 20, right: 10, bottom: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.9),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          /* const Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Property',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700),),

                                          ],
                                        ),*/

                                          //const Spacer(),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              SizedBox(
                                                width: 140,
                                                child: Text(abc.data![len].service_name,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              SizedBox(
                                                width: 140,
                                                child: Text(
                                                  "Booking Date:  "+abc.data![len].date,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white,
                                                    // fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "Booking Time:  "+abc.data![len].time,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                  // fontWeight: FontWeight.w500
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              /*Text(
                                                abc.data![len].make_an_offer,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                  // fontWeight: FontWeight.w500
                                                ),
                                              ),
                                              SizedBox(height: 5,)*/
                                            ],
                                          ),
                                          const Spacer(),
                                          Column(
                                            children: [
                                              SizedBox(height: 0,),
                                              ClipRRect(
                                                borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                child:  Container(
                                                  width: 100,
                                                  height:90,
                                                  child: Image.asset(AppImages.verify, height: 55),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),

                            );

                          });
                    }
                    else if(abc.hasError){
                      return Text(abc.error.toString());

                    }
                    return const LinearProgressIndicator(
                      color: Colors.black87,
                    );
                  }

              );
            }
        ),


      ),

    );
  }
}
