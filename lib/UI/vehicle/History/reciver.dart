import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/model/vehcilerecentmodel.dart';
import 'package:http/http.dart' as http;

import '../../../utils/constant.dart';

class ReciverHistory extends StatefulWidget {
  const ReciverHistory({super.key});

  @override
  State<ReciverHistory> createState() => _ReciverHistoryState();
}

class _ReciverHistoryState extends State<ReciverHistory> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late SharedPreferences preferences;
  ValueNotifier<String>id=ValueNotifier("");

  init()async{
    preferences=await SharedPreferences.getInstance();
    id.value=preferences.getString("id")??'';
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<List<VechicleRecentModel>> fetchvechiclehistory(iid) async {
    final url = Uri.parse('https://verifyserve.social/WebService1.asmx/ShowVehicleHistoey_Reciver?sid=$iid');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      await Future.delayed(Duration(seconds: 2));
      final List result = json.decode(response.body);
      return result.map((e) => VechicleRecentModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.only(left: 10,bottom: 10),
              child: Text("Alerts that you've received!",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 1),),
            ),
            ValueListenableBuilder(
                valueListenable: id,
                builder: (context, String i,__) {
                return FutureBuilder<List<VechicleRecentModel>>(
                  future: fetchvechiclehistory(i),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Container(
                                padding: EdgeInsets.only(right: 10,left: 10,top: 10,bottom: 10),
                                child: Container(
                                  padding: EdgeInsets.only(right: 15,left: 10,top: 5,bottom: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(12)),
                                    border: Border.all(width: 1, color: Colors.grey),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image(image: AssetImage('assets/images/history_icon.png'),width: 60),
                                      SizedBox(width: 20,),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('${snapshot.data![index].senderName}',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 1.5),),
                                          SizedBox(height: 5,),
                                          Row(
                                            children: [
                                              Text('${snapshot.data![index].date}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.grey.shade500,fontFamily: 'Poppins',letterSpacing: 1),),
                                              SizedBox(width: 3,),
                                              Icon(Icons.circle,color: Colors.white,size: 5,),
                                              SizedBox(width: 3,),
                                              Text('${snapshot.data![index].time}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.grey.shade500,fontFamily: 'Poppins',letterSpacing: 1,),),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Image(image: AssetImage('assets/images/in_arrow.png'),width: 20,color: Colors.greenAccent),
                                    ],
                                  ),
                                )
                            );
                          },
                        ),
                      );
                    }
                    else if(snapshot.hasError){
                      return Text('${snapshot.error}');
                    }else if(snapshot.data == null){
                      // Center(child: Text('Empty',style: TextStyle(color: Colors.white),));
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                );
              }
            ),
          ],
        )
    );
  }
}
