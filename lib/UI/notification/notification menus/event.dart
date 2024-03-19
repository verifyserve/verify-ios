import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:ui' as ui;

import '../../../data/model/calendereventmodel.dart';
import '../../jobs/job_screen.dart';
import '../../realEstate/History_Clickdetails.dart';
import '../../services/Service_History.dart';
import 'Show_event.dart';


class Event extends StatefulWidget {
  const Event({Key? key}) : super(key: key);

  @override
  State<Event> createState() => _EventState();
}

class _EventState extends State<Event> {

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate;

  String? date;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late SharedPreferences preferences;
  ValueNotifier<String>number=ValueNotifier("");

  init()async {
    preferences = await SharedPreferences.getInstance();
    number.value = preferences.getString("phone") ?? '';
  }

  Future<List<CalenderEventModel>> fetchEventListData(String number) async {
    final url = Uri.parse("https://verifyserve.social/WebService3_ServiceWork.asmx/Canlendar_Show_API?Date=${date}&Number=${number}");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      //await Future.delayed(Duration(seconds: 2));
      final List result = json.decode(response.body);
      print(response.body.toString());
      return result.map((e) => CalenderEventModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 8, right: 8, bottom: 10),
              child: Container(
                padding: const EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 20),
                  lastDay: DateTime.utc(2040, 10, 20),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) {
                    // Use selectedDayPredicate to determine which day is currently selected.
                    // If this returns true, then day will be marked as selected.
                    // Using isSameDay is recommended to disregard
                    // the time-part of compared DateTime objects.
                    return isSameDay(_selectedDate, day);
                  },
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      // Call setState() when updating calendar format
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged:  (focusedDay){
                    // No need to call setState() here
                    _focusedDay = focusedDay;
                  },
                  headerVisible: true,
                  daysOfWeekVisible: true,
                  sixWeekMonthsEnforced: true,
                  shouldFillViewport: false,
                  headerStyle: HeaderStyle(titleTextStyle: TextStyle(fontSize: 20, color: Colors.deepPurple, fontWeight: FontWeight.w800)),
                  calendarStyle: CalendarStyle(todayTextStyle: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
                  onDaySelected: (selectedDay, focusedDay) {
                    // if (!isSameDay(_selectedDay, selectedDay)) {
                    //   // Call setState() when updating the selected day
                    //   setState(() {
                    //     _selectedDay = selectedDay;
                    //     _focusedDay = focusedDay;
                    //     print(_selectedDay);
                    //   });
                    // }
                    setState(() {
                      _selectedDate = selectedDay;
                      print('${_selectedDate?.day}/${_selectedDate?.month}/${_selectedDate?.year}');

                      date = "${_selectedDate?.day}/${_selectedDate?.month}/${_selectedDate?.year}";

                    });
                  },
                ),
              ),
            ),

            SizedBox(height: 10,),

            Column(
              children: [
                ValueListenableBuilder(
                    valueListenable: number,
                    builder: (context, String number,_) {
                    return FutureBuilder<List<CalenderEventModel>>(
                        future: fetchEventListData(number),
                        builder: (context, snapshot) {
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
                                  Text("No Data Found!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 0),),
                                ],
                              ),
                            );
                          }
                          else{
                            return ListView.builder(
                                itemCount: snapshot.data!.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: (){

                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 0, left: 8, right: 8, bottom: 10),
                                      child: Container(
                                        padding: const EdgeInsets.only(top: 5, left: 15, right: 5, bottom: 5),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: Row(
                                          children: [
                                            RotatedBox(
                                              quarterTurns: -1,
                                              child: Center(
                                                
                                                child: RichText(
                                                  text: TextSpan(
                                                    text: "${snapshot.data![index].ntype} ".toUpperCase(),
                                                    style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black,letterSpacing: 1),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10,),
                                            Container(color: Colors.black, height: 110, width: 1,),
                                            SizedBox(width: 10,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 100,
                                                  child: Text("${snapshot.data![index].nname}",
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(Iconsax.location,size: 10,color: Colors.red,),
                                                    SizedBox(width: 2,),
                                                    SizedBox(
                                                      width: 200,
                                                      child: Text("${snapshot.data![index].nLocation}",
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.black,
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
                                                    Icon(Iconsax.sms_copy,size: 12,color: Colors.red,),
                                                    SizedBox(width: 2,),
                                                    Text("Message⤵️",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.w500),
                                                    ),
                                                  ],
                                                ),

                                                SizedBox(width: 2,),

                                                GestureDetector(
                                                  onTap: () {
                                                    // Implement logic to show full text
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return AlertDialog(
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(20),
                                                          ),
                                                          title: const Text('Full Message'),
                                                          content: Text("${snapshot.data![index].nDes}",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors.black,
                                                                fontWeight: FontWeight.w400
                                                            ),),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.of(context).pop();
                                                              },
                                                              child: Text('Close'),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: SizedBox(
                                                    width: 200,
                                                    child: Text("${snapshot.data![index].nDes}",
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.w400
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 8.0),
                                                GestureDetector(
                                                  onTap: () {
                                                    // Implement logic to show full text
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return AlertDialog(
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(20),
                                                          ),
                                                          title: const Text('Full Message'),
                                                          content: Text("${snapshot.data![index].nDes}",
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.w400
                                                          ),),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.of(context).pop();
                                                              },
                                                              child: Text('Close'),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: Text(
                                                    '... Show More',
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.red,
                                                        fontWeight: FontWeight.w400
                                                    ),
                                                  ),
                                                ),

                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Icon(Iconsax.watch_copy,size: 12,color: Colors.red,),
                                                        SizedBox(width: 2,),
                                                        Text("${snapshot.data![index].nTime}",
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.w500
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(width: 170,),
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Icon(Iconsax.calendar_1_copy,size: 12,color: Colors.red,),
                                                        SizedBox(width: 2,),
                                                        Text("${snapshot.data![index].nDate}",
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.w500
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                            );
                          }
                        }
                    );
                  }
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}