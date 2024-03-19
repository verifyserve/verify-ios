import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:verify/bloc/notificationBloc.dart';

import '../../../data/Notification/local_notification_service.dart';
import '../../../utils/constant.dart';
import '../../widgets/appTextField.dart';
import 'package:http/http.dart' as http;
import '../notification.dart';

class AddNotification extends StatefulWidget {
  const AddNotification({Key? key}) : super(key: key);

  @override
  State<AddNotification> createState() => _AddNotificationState();
}

class _AddNotificationState extends State<AddNotification> {
  late NotificationBloc bloc;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // TextEditingController title = TextEditingController();
  //String date = DateFormat("d/M/yyyy").format(DateTime.now());
  //String time = DateFormat("hh:mm aa").format(DateTime.now());
  // TextEditingController time = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();

  @override
  void initState() {
    bloc = context.read<NotificationBloc>();
    super.initState();
   //FirebaseMessaging.instance.getInitialMessage();
   //
   //  FirebaseMessaging.instance.getInitialMessage();
   //
   //  FirebaseMessaging.onMessage.listen((RemoteMessage message){
   //
   //    AwesomeNotifications().createNotification(content: NotificationContent(
   //      id: 124,
   //      channelKey: "verify_CallNotify_apk",
   //      color: Colors.white,
   //      category: NotificationCategory.Message,
   //      notificationLayout: NotificationLayout.Messaging,
   //      locked: true,
   //      wakeUpScreen: true,
   //      fullScreenIntent: true,
   //      autoDismissible: true,
   //      backgroundColor: Colors.orange,
   //      displayOnForeground: true,
   //      displayOnBackground: true,
   //    ),
   //    );
   //    // AwesomeNotifications().createNotification(content: NotificationContent(id: 1234,
   //    //   channelKey: "alert_app",
   //    //   color: Colors.orange,
   //    //   category: NotificationCategory.LocalSharing,
   //    //   notificationLayout: NotificationLayout.ProgressBar,
   //    //   locked: true,
   //    //   wakeUpScreen: true,
   //    //   fullScreenIntent: true,
   //    //   autoDismissible: false,
   //    //   displayOnForeground: true,
   //    //   displayOnBackground: true,
   //    //   backgroundColor: Colors.orange,
   //    // ),);
   //
   //    // AwesomeNotifications().actionStream.listen((event) {
   //    //   if(event.buttonKeyPressed == "REJECT"){
   //    //     print('Call Rejected');
   //    //     Fluttertoast.showToast(
   //    //         msg: "Call Rejected",
   //    //         toastLength: Toast.LENGTH_SHORT,
   //    //         gravity: ToastGravity.BOTTOM,
   //    //         timeInSecForIosWeb: 1,
   //    //         backgroundColor: Colors.red,
   //    //         textColor: Colors.white,
   //    //         fontSize: 16.0
   //    //     );
   //    //   }else if(event.buttonKeyPressed == "ACCEPT"){
   //    //     print('Call Accepted');
   //    //     Fluttertoast.showToast(
   //    //         msg: "Call Accepted",
   //    //         toastLength: Toast.LENGTH_SHORT,
   //    //         gravity: ToastGravity.BOTTOM,
   //    //         timeInSecForIosWeb: 1,
   //    //         backgroundColor: Colors.red,
   //    //         textColor: Colors.white,
   //    //         fontSize: 16.0
   //    //     );
   //    //   }
   //    //   else{
   //    //     print('Click on notification');
   //    //   }
   //    //
   //    // });
   //
   //    LocalNotificationService.createanddisplaynotification(message);
   //  });

  }

  String? _selectedTime;

  String workTime = '';

  Future<void> _showStartTime() async {
    final TimeOfDay? result =
    await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      setState(() {
        _selectedTime = result.format(context);

        workTime = '${_selectedTime}';

        time.text = workTime;

      });
    }
  }

  String? selectedEvent;
  Color? selectedColor;

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
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                "Add Notification",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 25),
              ),
            ),
            SizedBox(height: 10,),
            Center(
              child: Text(
                "Please fill all details carefully it cannot be changed",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontWeight: FontWeight.w400,
                    fontSize: 13),
              ),
            ),
            SizedBox(height: 10,),
            Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Select Type",style: TextStyle(
                              color: Colors.white,
                            ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 5,),

                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 50.h,
                          width: 1.sw,
                          child: DropdownButton<String>(
                            hint: Text('Select Event'),
                            padding: EdgeInsets.only(left: 10),
                            value: selectedEvent,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedEvent = newValue!;
                                // Set corresponding color based on the selected event
                                selectedColor = getColorForEvent(newValue);
                              });
                            },
                            items: ['Birthday', 'Wedding', 'Clubbing']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),

                        const SizedBox(height: 10,),

                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Date",style: TextStyle(
                              color: Colors.white,
                            ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 5,),

                        // Container(
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     borderRadius: BorderRadius.circular(10),
                        //   ),
                        //   height: 150.h,
                        //   width: 1.sw,
                        //   child: CupertinoDatePicker(
                        //     onDateTimeChanged: (dt) {
                        //       date = DateFormat("d/M/yyyy").format(dt);
                        //       print(date);
                        //     },
                        //     mode: CupertinoDatePickerMode.date,
                        //     maximumDate: DateTime(DateTime.now().year + 2),
                        //     minimumDate: DateTime.now().subtract(const Duration(days: 1)),
                        //     initialDateTime: DateTime.now(),
                        //   ),
                        // ),

                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  // boxShadow: K.boxShadow,
                                ),
                                child: TextField(
                                  controller: date,
                                  readOnly: true,
                                  onTap: () async{
                                    DateTime? pickedDate = await showDatePicker(
                                        initialEntryMode: DatePickerEntryMode.calendarOnly,
                                        context: context, initialDate: DateTime.now(),
                                        firstDate: DateTime(2010), //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime(2101));

                                    if(pickedDate != null ){
                                      print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                      String formattedDate = DateFormat('d/M/yyyy').format(pickedDate);
                                      print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                      //you can implement different kind of Date Format here according to your requirement
                                      //yyyy-MM-dd
                                      setState(() {
                                        date.text = formattedDate; //set output date to TextField value.
                                      });
                                    }else{
                                      print("Date is not selected");
                                    }
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Enter Date",
                                      prefixIcon: Icon(
                                        PhosphorIcons.calendar,
                                        color: Colors.black54,
                                      ),
                                      hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                  color: Colors.pinkAccent.shade100
                              ),
                              child: IconButton(
                                onPressed: () async{
                                  DateTime? pickedDate = await showDatePicker(
                                      initialEntryMode: DatePickerEntryMode.calendarOnly,
                                      context: context, initialDate: DateTime.now(),
                                      firstDate: DateTime(2010), //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime(2101));

                                  if(pickedDate != null ){
                                    print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                    String formattedDate = DateFormat('d/M/yyyy').format(pickedDate);
                                    print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                    //you can implement different kind of Date Format here according to your requirement
                                    //yyyy-MM-dd
                                    setState(() {
                                      date.text = formattedDate; //set output date to TextField value.
                                    });
                                  }else{
                                    print("Date is not selected");
                                  }
                                },
                                icon: Icon(
                                  PhosphorIcons.calendar,
                                  color: Colors.black,
                                ),),
                            )
                          ],
                        ),

                        const SizedBox(height: 10,),

                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Time",style: TextStyle(
                              color: Colors.white,

                            ),
                            ),
                          ),
                        ),

                        // Container(
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     borderRadius: BorderRadius.circular(10),
                        //   ),
                        //   height: 150.h,
                        //   width: 1.sw,
                        //   child: CupertinoDatePicker(
                        //     onDateTimeChanged: (dt) {
                        //       time = DateFormat("hh:mm aa").format(dt);
                        //       print(date);
                        //     },
                        //     mode: CupertinoDatePickerMode.time,
                        //   ),
                        // ),
                        //

                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  // boxShadow: K.boxShadow,
                                ),
                                child: TextField(
                                  controller: time,
                                  readOnly: true,
                                  onTap: () async{
                                    _showStartTime();
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Enter Time",
                                      prefixIcon: Icon(
                                        PhosphorIcons.calendar,
                                        color: Colors.black54,
                                      ),
                                      hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                  color: Colors.pinkAccent.shade100
                              ),
                              child: IconButton(
                                onPressed: () async{
                                  _showStartTime();
                                },
                                icon: Icon(
                                  PhosphorIcons.watch,
                                  color: Colors.black,
                                ),),
                            )
                          ],
                        ),

                        const SizedBox(height: 10,),
                        AppTextField(
                          onFieldSubmitted: (value) {
                            description.text = value;
                          },
                          controller: description,
                          title: "Description",
                          maxLines: 5,
                          showTitle: true,
                          validate: true,
                        ),
                        const SizedBox(height: 10,),
                        AppTextField(
                          onFieldSubmitted: (value) {
                            location.text = value;
                          },
                          controller: location,
                          title: "Location",
                          showTitle: true,
                          validate: true,
                        ),
                        const SizedBox(height: 10,),
                        AppTextField(
                          onFieldSubmitted: (value) {
                            number.text = value;
                          },
                          controller: number,
                          title: "Number",
                          showTitle: true,
                          validate: true,
                        ),
                        const SizedBox(height: 10,),
                        // AppTextField(
                        //   onFieldSubmitted: (value) {
                        //     type.text = value;
                        //   },
                        //   controller: type,
                        //   title: "Type",
                        //   showTitle: true,
                        //   validate: true,
                        // ),
                        const SizedBox(height: 20,),
                        GestureDetector(
                          onTap: () {
                            if(formKey.currentState!.validate()){
                              if (kDebugMode) {
                                print("${date} ${time} ${description.text} ${location.text} ${number.text} ${type.text}");
                              }
                              bloc.sendNoti(
                                date: date.text,
                                time: time.text,
                                description: description.text,
                                location: location.text,
                                number: number.text,
                                type: selectedEvent
                              );
                            }
                          },
                          child: Container(
                              height: 45,
                              width: 1.sw,
                              // margin: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  color: Colors.red),
                              child:
                              ValueListenableBuilder(
                                valueListenable: bloc.sendNotiLoader,
                                builder: (context, bool loading, child) {
                                  if(loading){
                                    return Center(child: CircularProgressIndicator(color: Colors.white,),);
                                  }
                                  return Center(
                                    child: Text(
                                      "Submit",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          // letterSpacing: 0.8,
                                          fontSize: 16),
                                    ),
                                  );
                                },
                              )
                          ),
                        ),
                        SizedBox(height: 10,)
                      ],
                    ),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
  Color getColorForEvent(String event) {
    switch (event) {
      case 'Birthday':
        return Color(0xFF0000FF);
      case 'Wedding':
        return Color(0xFF00FF00);
      case 'Clubbing':
        return Color(0xFF800080);
      default:
        return Colors.transparent;
    }
  }

  Future<void> sendPushgNotification() async {

    final data = {
      'action': 'ACCEPt',
      'id': '124',
      'status': 'done'
    };

    http.Response response = await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'key=AAAAtelDzuE:APA91bF6bv75VmfoOxUuyaV6tmdGfjDjoGe4TKbkN6W1zFGhbACuV_ZCZNfQ8HL9YuNx16oACmnHzVysonEKvAtwSfFuUrxfRo2P4tkXaMkaj97A-3WwNDy33x9Pww3VdvaFho-gk9kV',
    },
      body: jsonEncode(<String, dynamic>{
        'notification': <String, dynamic>{
          'title': 'Calendar Notification',
          'body': 'You have a new task!',
        },
        'priority': 'high',
        'data':data,
        'to': 'eg0s9O6_QK2f94uDgRyvXj:APA91bGgwI5jaA644R2cH_8kve5sIz5AvEbnAfdO8nn1jvz1NzR1JkmUBAC7KJ1ltROlGyKvjtoCtKTcGFinTU6hyHlTUM-jHNsWylLs2bnbnGh_wix_uRzngKQUQ_BoRHMZou7YLcHT',
      },
      ),
    );

    if(response.statusCode == 200){
      Fluttertoast.showToast(
          msg: "Alert sent",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else{
      Fluttertoast.showToast(
          msg: "Alert not sent",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    response;
  }
}