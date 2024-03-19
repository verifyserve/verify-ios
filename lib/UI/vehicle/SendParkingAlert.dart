import 'dart:async';
import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vibration/vibration.dart';
import '../../data/Notification/controller.dart';
import '../../data/Notification/local_notification_service.dart';
import '../../data/model/UserInfo.dart';
import '../../data/model/vdetails.dart';
import '../../data/model/vehicleIdModel.dart';
import '../../utils/constant.dart';

import 'package:http/http.dart' as http;

import '../QR Scanner/qr_scanner.dart';
import 'package:intl/intl.dart';

import 'History/History.dart';
import 'History/historytab.dart';
import 'History/reciver.dart';

class SendParkingAlert extends StatefulWidget {
  const SendParkingAlert({Key? key}) : super(key: key);

  @override
  State<SendParkingAlert> createState() => _SendParkingAlertState();
}

class _SendParkingAlertState extends State<SendParkingAlert> {

  LocalNotificationService notificationService = LocalNotificationService();

  TextEditingController vehicleNumberController = TextEditingController();

  String? vehicleNumber;

  Userinfo? userinfo;

  IdModel? idModel;

  VDetailModel? vDetailModel;

  bool _validate = false;

  bool isLoading = false;

  bool isColumnVisible = false;

  Timer? _timer;

  int _countDown = 15;

  bool _showCountdown = false;

  // Get the current time
  DateTime now = DateTime.now();

  String currentTime = '';

  String currentDate = '';

 // DateTime? datetime;

  // void updateTimeAndDate() {
  //   setState(() {
  //     currentTime = DateFormat.Hm().format(DateTime.now()); // Format time as HH:mm
  //     currentDate = DateFormat.yMd().format(DateTime.now());// Format date as year/month/day
  //     datetime.toIso8601String();
  //   });
  // }

  Future<IdModel> getIdFromNumber(String vehicleNumber)async {
    final response = await http.get(Uri.parse('https://verifyserve.social/Webservice2.asmx/Show_accountid_byVehicleno?vehicle_no=$vehicleNumber'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      print(response.body.toString());
      return IdModel.fromJson(data);
    }else{
      print(Exception());
      return IdModel.fromJson(data);
    }
  }

  Future<List<VDetailModel>> getvehicleonwerdetails() async {
    final url = Uri.parse('https://verifyserve.social/WebService2.asmx/Show_aocuntdetail_byid?id=${idModel!.data!.first.subiid}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      await Future.delayed(Duration(seconds: 2));
      final List result = json.decode(response.body);
      print(response.body.toString());
      return result.map((e) => VDetailModel.fromJson(e)).toList();

    } else {
      throw Exception('Failed to load data');
    }
  }

  //For Internet Connectivity
  Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  //For User Details
  void _fetchOwnerDetails() async {

    // Check for internet connectivity
    bool isConnected = await checkInternetConnectivity();
    if (!isConnected) {
      // No internet connection, show a message to the user
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text("No Internet Connection",style: TextStyle(fontFamily: 'Poppins',fontWeight: FontWeight.w500),),
              content: Text("Please connect to the internet to fetch vehicle owner details.",style: TextStyle(fontFamily: 'Poppins'),),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              actions: <Widget>[TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),],
            ),
      );
      return;
    }else {
      setState(() {
        isLoading = true;
      });

      await Future.delayed(Duration(seconds: 1)); // Simulate a 3-second delay.

      vehicleNumber = vehicleNumberController.text;

      try {
        final ownerDetails = await getIdFromNumber(vehicleNumber!);

        setState(() {
          idModel = ownerDetails;
          isColumnVisible = true;
          isLoading = false;
        });

        print('Correct');
      } catch (e) {
        print('No user');
        setState(() {
          Fluttertoast.showToast(
              msg: "No User Found!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 16.0
          );
          isColumnVisible = false;
          isLoading = false;
        });
      }
    }
  }

  //For Timer
  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_countDown == 0) {
        timer.cancel();
        setState(() {
          _showCountdown = false;
          Fluttertoast.showToast(
              msg: "Countdown Finished!, Send again if you want",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 16.0
          );
        });
      } else {
        setState(() {
          _countDown--;
        });
      }
    });
  }

  void resetTimer() {
    if (_timer != null) {
      _timer!.cancel();
      setState(() {
        _countDown = 15;
        _showCountdown = false;
      });
    }
  }

  // //For Dialer
  // void _launchDialer() async {
  //
  //   launch('tel:${userinfo!.data!.first.vmobile}');
  //
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();
    vehicleNumberController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late SharedPreferences preferences;
  ValueNotifier<String>id=ValueNotifier("");
  ValueNotifier<String>name=ValueNotifier("");

  init()async{
    preferences=await SharedPreferences.getInstance();
    name.value=preferences.getString("name")??'';
    id.value=preferences.getString("id")??'';
  }

  //For Vehicle History
  // VehicleHistory() async{
  //   final dio = Dio();
  //   var data = await dio.get(
  //       'https://verifyserve.social/WebService1.asmx/AddVehicle_History',
  //       queryParameters: {
  //         "reciver_name": "${userinfo!.data!.first.vname}",
  //         "date": "${currentDate}",
  //         "time": "${currentTime}",
  //         "userid": "1",
  //         "sid": "${userinfo!.data!.first.vid}",
  //         "sender_name": "fgs",
  //       });
  //   var res = jsonDecode(data.data);
  //   print(res.runtimeType);
  //   await Future.delayed(Duration(seconds: 2));
  //   return true;
  // }

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
        actions: [
          InkWell(
              onTap: (){
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => Recent()));
              },
              child: Container(
                padding: EdgeInsets.only(right: 7,top: 5),
                child: Row(
                  children: [
                    InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VehcileHistory()));
                        },
                        child: Icon(PhosphorIcons.timer,size: 30,)),
                  ],
                ),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.png"),
              fit: BoxFit.contain,
            ),
          ),
          child: Form(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  const SizedBox(
                    height: 20,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Send Parking Alert !",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 25),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextFormField(
                            controller: vehicleNumberController,
                            textCapitalization: TextCapitalization.characters,
                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black54,fontFamily: 'Poppins',letterSpacing: 1),
                            onTapOutside: (event) => FocusScope.of(context).unfocus(),
                            inputFormatters: [
                              //LengthLimitingTextInputFormatter(10)
                            ],
                            decoration: InputDecoration(
                                hintText: "Enter Vehicle Number",
                                contentPadding: EdgeInsets.all(12),
                                errorText: _validate ? "Field Can't Be Empty" : null,
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white,
                                        style: BorderStyle.none
                                    )
                                ),
                                suffixIcon: IconButton(
                                  onPressed: vehicleNumberController.clear,
                                  icon: Icon(PhosphorIcons.x_circle,size: 20,),
                                ),
                                prefixIcon: Icon(
                                  PhosphorIcons.car_simple,
                                  color: Colors.black54,
                                ),
                                hintStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.grey[500],fontFamily: 'Poppins',),
                                border: InputBorder.none),
                          ),
                        ),
                      ),

                      //SCANNER

                      // SizedBox(width: 5,),
                      //
                      // InkWell(
                      //   hoverColor: Colors.white,
                      //   onTap: () {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => QRScanner()));
                      //   },
                      //     child: Image.asset('assets/images/qr img.png',height: 35,width:35,))

                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  GestureDetector(
                    onTap: () {
                      setState(() {
                        vehicleNumberController.text.isEmpty? _validate = true : _validate = false;
                      });

                      _fetchOwnerDetails();
                      getvehicleonwerdetails();

                    },
                    child: Container(
                      height: 45,
                      width: 0.5.sw,
                      margin:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.red),
                      child: Center(child: Text("Get Owner's Details",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600, letterSpacing: 0.8, fontSize: 15,fontFamily: 'Poppins'),))
                    ),
                  ),

                  // ElevatedButton(
                  //     onPressed: (){
                  //       _fetchOwnerDetails();
                  //     },
                  //     child: Text("Get Onwer's Details")),

                  const SizedBox(
                    height: 40,
                  ),

                  if (isLoading)
                    Center(heightFactor: 5,child: CircularProgressIndicator())
                  else
                    Visibility(
                      visible: isColumnVisible,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: InputDecorator(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                )
                            ),
                            child: ValueListenableBuilder(
                                valueListenable: id,
                                builder: (context, String i,__) {
                                return ValueListenableBuilder(
                                    valueListenable: name,
                                    builder: (context, String n,__) {
                                    return  FutureBuilder<List<VDetailModel>>(
                                      future: getvehicleonwerdetails(),
                                      builder: (context, snapshot) {
                                        if(snapshot.hasData){
                                          return  Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              ReusableRow(title: 'Owner Name', colon: ':',value: '${snapshot.data!.first.vname}'),
                                              SizedBox(height: 10,),
                                              ReusableRow(title: 'Vehicle Type', colon: ':',value: '${idModel!.data!.first.vechicleTyoe}'),
                                              SizedBox(height: 10,),
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  border: Border.all(width: 1, color: Colors.grey),
                                                ),
                                                child: Text.rich(
                                                    TextSpan(
                                                        text: 'Note:-',
                                                        style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),
                                                        children: <InlineSpan>[
                                                          TextSpan(
                                                            text: " Send Alert or make Call directly to the Vehicle's Owner.",
                                                            style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.grey.shade400,fontFamily: 'Poppins',letterSpacing: 0),
                                                          )
                                                        ]
                                                    )),
                                              ),

                                              SizedBox(height: 30),

                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: SizedBox(
                                                      width: 130,
                                                      child: ElevatedButton.icon(
                                                        onPressed: () async {
                                                          try {
                                                            http.Response response = await http.post(
                                                              Uri.parse('https://fcm.googleapis.com/fcm/send'),
                                                              headers: <String, String>{
                                                                'Content-Type': 'application/json; charset=UTF-8',
                                                                'Authorization': 'key=AAAAtelDzuE:APA91bF6bv75VmfoOxUuyaV6tmdGfjDjoGe4TKbkN6W1zFGhbACuV_ZCZNfQ8HL9YuNx16oACmnHzVysonEKvAtwSfFuUrxfRo2P4tkXaMkaj97A-3WwNDy33x9Pww3VdvaFho-gk9kV',
                                                              },
                                                              body: jsonEncode(
                                                                <String, dynamic>{
                                                                  'notification': <String, dynamic>{
                                                                    'body': 'Hey, ${n} is looking for you',
                                                                    'title': 'Vehicle Alert!',
                                                                  },
                                                                  'priority': 'high',
                                                                  'data': <String, dynamic>{
                                                                    'click_action': 'User Clicked',
                                                                    'id': i,
                                                                    'status': 'done'
                                                                  },
                                                                  'to': '${snapshot.data!.first.tokenNo}',
                                                                },
                                                              ),
                                                            );

                                                            Fluttertoast.showToast(
                                                                msg: "Alert sent",
                                                                toastLength: Toast.LENGTH_SHORT,
                                                                gravity: ToastGravity.BOTTOM,
                                                                timeInSecForIosWeb: 1,
                                                                backgroundColor: Colors.grey,
                                                                textColor: Colors.white,
                                                                fontSize: 16.0
                                                            );

                                                            resetTimer();
                                                            setState(() {
                                                              _showCountdown = true;
                                                            });
                                                            startTimer();


                                                            response;
                                                          } catch (e) {
                                                            e;
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
                                                          setState(() {
                                                            // Format the time in 12-hour format with AM/PM
                                                            currentTime = DateFormat('h:mm a').format(now);
                                                            currentDate = DateFormat.yMd().format(DateTime.now());// Format date as year/month/day
                                                            //currentTime = DateFormat.Hm().format(DateTime.now()); // Format time as HH:mm
                                                            //  datetime.toIso8601String();
                                                          });
                                                          final dio = Dio();
                                                          await Future.delayed(Duration(seconds: 2));
                                                          var data = await dio.get(
                                                              'https://verifyserve.social/WebService1.asmx/AddVehicle_History',
                                                              queryParameters: {
                                                                "reciver_name": "${snapshot.data!.first.vname}",
                                                                "date": "${currentDate}",
                                                                "time": "${currentTime}",
                                                                "userid": i,
                                                                "sid": "${snapshot.data!.first.vid}",
                                                                "sender_name": n,
                                                              });
                                                          var res = jsonDecode(data.data);
                                                          print(res.runtimeType);
                                                        },
                                                        icon: Icon(Icons.taxi_alert,color: Colors.redAccent.shade100,size: 25),
                                                        label: Text('ALERT!',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,letterSpacing: 0.5),),
                                                      ),
                                                    ),
                                                  ),

                                                  SizedBox(width: 10,),

                                                  Expanded(
                                                    flex: 1,
                                                    child: SizedBox(
                                                      width: 130,
                                                      child: ElevatedButton.icon(
                                                        icon: Icon(Icons.call_outlined,color: Colors.greenAccent,size: 25),
                                                        label: Text('CALL',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,letterSpacing: 0.5),),
                                                        onPressed: (){
                                                          FlutterPhoneDirectCaller.callNumber('${snapshot.data!.first.vmobile}');
                                                        },
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
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
                                );
                              }
                            ),
                          ),
                        ),
                      ),
                    ),
                  SizedBox(height: 20),
                  Visibility(
                    visible: _showCountdown,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Alert running on user's phone for:", style: TextStyle(fontSize: 15,color: Colors.white),),
                          SizedBox(width: 5,),
                          SizedBox(
                            width: 40,
                              child: Text("$_countDown", style: TextStyle(fontSize: 18,color: Colors.white),)),
                        ],
                      ),)
                  // AppTextField(
                  //   onFieldSubmitted: (value) {
                  //     number.text = value;
                  //   },
                  //   controller: number,
                  //   title: "Vehicle Number",
                  //   showTitle: false,
                  //   textCapitalization: TextCapitalization.characters,
                  //   validate: true,
                  //   /*onChanged: (v){
                  //     number.text = capitalize(v);
                  //     // print("${this[0].toUpperCase()}${this.substring(1).toLowerCase()}");
                  //   },*/
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     // print(type.value);
                  //     // if (formKey.currentState!.validate()) {
                  //     //   bloc.sendParkingAlert(number.text);
                  //     //   Navigator.push(
                  //     //     context,
                  //     //     MaterialPageRoute(
                  //     //       builder: (context) => Provider.value(
                  //     //         value: bloc,
                  //     //         child: const ParkingAlert(),
                  //     //       ),
                  //     //     ),
                  //     //   );
                  //     // }
                  //   },
                  //   child: Container(
                  //     height: 45,
                  //     width: 0.7.sw,
                  //     margin:
                  //         const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  //     decoration: const BoxDecoration(
                  //         borderRadius: BorderRadius.all(Radius.circular(5)),
                  //         color: Colors.red),
                  //     child: ValueListenableBuilder(
                  //       valueListenable: bloc.isLoading,
                  //       builder: (context, bool loading, child) {
                  //         if (loading) {
                  //           return const Center(
                  //               child: CircularProgressIndicator(
                  //             color: Colors.white,
                  //           ));
                  //         }
                  //         return const Center(
                  //           child: Text(
                  //             "Submit",
                  //             style: TextStyle(
                  //                 color: Colors.white,
                  //                 fontWeight: FontWeight.w600,
                  //                 // letterSpacing: 0.8,
                  //                 fontSize: 16),
                  //           ),
                  //         );
                  //       },
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  // Future<void> sendCallNotification() async {
  //   try {
  //     http.Response response = await http.post(
  //       Uri.parse('https://fcm.googleapis.com/fcm/send'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'Authorization': 'key=AAAAtelDzuE:APA91bF6bv75VmfoOxUuyaV6tmdGfjDjoGe4TKbkN6W1zFGhbACuV_ZCZNfQ8HL9YuNx16oACmnHzVysonEKvAtwSfFuUrxfRo2P4tkXaMkaj97A-3WwNDy33x9Pww3VdvaFho-gk9kV',
  //       },
  //       body: jsonEncode(
  //         <String, dynamic>{
  //           'notification': <String, dynamic>{
  //             'body': 'Hey, someone is looking for you',
  //             'title': 'Vehicle Alert!',
  //           },
  //           'priority': 'high',
  //           'data': <String, dynamic>{
  //             'click_action': 'FLUTTER_NOTIFICATION_CLICK',
  //             'id': '1',
  //             'status': 'done'
  //           },
  //           'to': userinfo!.data!.first.tokenNo,
  //         },
  //       ),
  //     );
  //
  //     Fluttertoast.showToast(
  //         msg: "Alert sent",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.grey,
  //         textColor: Colors.white,
  //         fontSize: 16.0
  //     );
  //
  //     resetTimer();
  //     setState(() {
  //       _showCountdown = true;
  //     });
  //     startTimer();
  //
  //
  //     response;
  //   } catch (e) {
  //     e;
  //     Fluttertoast.showToast(
  //         msg: "Alert not sent",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.grey,
  //         textColor: Colors.white,
  //         fontSize: 16.0
  //     );
  //   }
  // }
}
class ReusableRow extends StatelessWidget {

  String title,value,colon;

  ReusableRow({super.key,required this.title,required this.value,required this.colon});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',)),

        SizedBox(width: 5,),

        Text(colon,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',),),

        SizedBox(width: 5,),

        Text(value.toUpperCase(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700,color: Colors.grey.shade400,fontFamily: 'Poppins', letterSpacing: 0.8,),),
      ],
    );
  }
}