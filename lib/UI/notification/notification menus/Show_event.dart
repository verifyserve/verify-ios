import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../utils/constant.dart';

class hhhhhhlllllllppp{
  final String name;
  final String date;
  final String time;
  final String location;
  final String PropertyAddress;
  hhhhhhlllllllppp({required this.name,required this.date,required this.time,required this.location,required this.PropertyAddress});
  factory hhhhhhlllllllppp.FromJson(Map<String,dynamic>json){
    return hhhhhhlllllllppp(name: json['Nname'],
        date: json['NDate'],
        time: json['NTime'],
        location: json['NLocation'],
        PropertyAddress: json['NDes']);

  }
}

class Show_Event extends StatefulWidget {
  final String date;
  const Show_Event({Key? key, required this.date}) : super(key: key);

  @override
  State<Show_Event> createState() => _Show_EventState();
}

class _Show_EventState extends State<Show_Event> {

  Future<List<hhhhhhlllllllppp>> fetchData(date) async {
    var url = Uri.parse("https://verifyserve.social/WebService3_ServiceWork.asmx/Canlendar_Show_API?Date="+date);
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      List listresponce = json.decode(responce.body);
      return listresponce.map((data) => hhhhhhlllllllppp.FromJson(data)).toList();
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
      body: FutureBuilder<List<hhhhhhlllllllppp>>(
          future: fetchData(widget.date),
          builder: (context, abc) {
            return ListView.builder(
              //itemCount: abc.data!.length,
                itemCount: 1,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int len) {
                  return GestureDetector(

                    onTap: (){

                    },

                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        margin: const EdgeInsets.only(bottom: 10,top: 10),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.white,
                                blurRadius: 0,
                                spreadRadius: 2)
                          ],
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                        ),
                        child:  Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10,),
                            Row(
                              children: [
                                Text(
                                  abc.data![len].name ?? "",
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17
                                  ),
                                ),
                                Spacer(),
                                Image(image: AssetImage('assets/images/pin.png'),width: 25,)
                              ],
                            ),
                            const SizedBox(height: 5,),
                            Text(
                              abc.data![len].PropertyAddress ?? "",
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 4,
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight:
                                  FontWeight.w500,
                                  fontFamily: "Poppins",
                                  fontSize: 11
                              ),
                            ),
                            const SizedBox(height: 20,),
                            Row(
                              children: [
                                const Icon(Icons.location_on,color: Colors.blue,size: 20,),
                                const SizedBox(width: 3,),
                                Text(
                                  abc.data![len].location ??"",
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      color: Colors.black54,
                                      fontWeight:
                                      FontWeight.w500,
                                      fontFamily: "Poppins",
                                      fontSize: 13
                                  ),
                                ),
                                Spacer(),
                                const Icon(Icons.date_range_outlined,color: Colors.blue,size: 20,),
                                const SizedBox(width: 3,),
                                Text(
                                  "${abc.data![len].date}",
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black54,
                                      fontSize: 13
                                  ),
                                ),
                                Spacer(),
                                const Icon(Icons.watch_later_outlined,color: Colors.blue,size: 20,),
                                const SizedBox(width: 3,),
                                Text(
                                  "${abc.data![len].time}",
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black54,
                                      fontSize: 13
                                  ),
                                ),

                              ],
                            ),
                            const SizedBox(height: 10,),
                          ],
                        ),
                      ),
                    ),
                  );
                }
            );
          }
      ),
    );
  }
}
