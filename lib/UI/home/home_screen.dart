import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:verify/UI/IT&Designing/it_design_screen.dart';
import 'package:verify/UI/auth/login.dart';
import 'package:verify/UI/IT&Designing/consultant.dart';
import 'package:verify/UI/documents/document_screen.dart';
import 'package:verify/UI/eventsAndWedding/eventsAndWedding.dart';
import 'package:verify/UI/IT&Designing/it_lawyer.dart';
import 'package:verify/UI/jobs/job_screen.dart';
import 'package:verify/UI/notification/notification.dart';
import 'package:verify/UI/realEstate/real_estate.dart';
import 'package:verify/UI/services/servicesScreen.dart';
import 'package:verify/UI/vehicle/vehicleHome.dart';
import 'package:verify/UI/widgets/comingSoon.dart';
import 'package:verify/bloc/homebloc.dart';
import 'package:verify/data/model/eventsAndWedding.dart';
import 'package:verify/data/model/homeSlider.dart';
import 'package:verify/data/repository/AuthRepository.dart';
import 'package:verify/data/repository/HomeRepository.dart';
import 'package:verify/utils/constant.dart';
import 'package:verify/utils/message_handler.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../bloc/authBloc.dart';
import '../../bloc/vehicleBLoc.dart';
import '../../data/Notification/controller.dart';
import '../../data/Notification/local_notification_service.dart';
import '../../data/repository/vehicleRepository.dart';
import '../About/about.dart';
import '../coming_page.dart';
import '../hotels/hotel_screen.dart';
import '../insurance/insurance_main.dart';
import '../profile/My_Documents.dart';
import '../profile/profile.dart';
import '../realEstate/Real-Estate_mainpage.dart';
import '../realEstate/Real_Estate_New.dart';
import '../realEstate/demo.dart';
import '../truck & jcb/truck_screen.dart';
import '../vehicle/Pages/newscreen.dart';
import '../vehicle/SendParkingAlert.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  LocalNotificationService notificationService = LocalNotificationService();

  late HomeBloc bloc;
  late AuthBloc tokenbloc;
  late VehicleBloc vehicleBloc;

  List<String> staticImages = [
    AppImages.static1,
    AppImages.static2,
    AppImages.static3,
    AppImages.static4,
    AppImages.static5,
    AppImages.static6,
    AppImages.static7,
    AppImages.static8,
  ];
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late SharedPreferences preferences;
  ValueNotifier<String>id=ValueNotifier("");
  ValueNotifier<String>name=ValueNotifier("");
  ValueNotifier<String>email=ValueNotifier("");
  ValueNotifier<String>number=ValueNotifier("");
  ValueNotifier<String>token=ValueNotifier("");
  @override
  void initState() {
    bloc = HomeBloc(context.read<HomeRepository>());
    vehicleBloc = VehicleBloc(context.read<VehicleRepository>());
    tokenbloc = AuthBloc(context.read<AuthRepository>());
    super.initState();
    bloc.msgController?.stream.listen((event) {
      AppMessageHandler().showSnackBar(context, event);
    });
    bloc.mainPageGrid();

    FirebaseMessaging.onMessage.listen((RemoteMessage message){

      String? title = message.notification!.title;
      String? body = message.notification!.body;

      AwesomeNotifications().createNotification(content: NotificationContent(id: 123,
        channelKey: "verify_CallNotify_app",
        color: Colors.white,
        title: title,
        body: body,
        category: NotificationCategory.Call,
        notificationLayout: NotificationLayout.Default,
        locked: true,
        wakeUpScreen: true,
        fullScreenIntent: true,
        autoDismissible: true,
        displayOnForeground: true,
        displayOnBackground: true,
        backgroundColor: Colors.orange,
        timeoutAfter: Duration(seconds: 15),
        chronometer: Duration(seconds: 0),
      ),
          actionButtons: [
            NotificationActionButton(key: "acceptance", label: 'Accept',
                color: Colors.greenAccent,
                autoDismissible: true,
                actionType: ActionType.Default
            ),
            NotificationActionButton(key: "REJECT", label: 'Wait',
                color: Colors.redAccent,
                autoDismissible: true,
                actionType: ActionType.Default
            ),
          ]
      );

      // AwesomeNotifications().setListeners(
      //     onActionReceivedMethod: (ReceivedAction receivedAction) async {
      //        if(receivedAction.buttonKeyPressed == "acceptance"){
      //         try {
      //           http.Response response = await http.post(
      //             Uri.parse('https://fcm.googleapis.com/fcm/send'),
      //             headers: <String, String>{
      //               'Content-Type': 'application/json; charset=UTF-8',
      //               'Authorization': 'key=AAAAtelDzuE:APA91bF6bv75VmfoOxUuyaV6tmdGfjDjoGe4TKbkN6W1zFGhbACuV_ZCZNfQ8HL9YuNx16oACmnHzVysonEKvAtwSfFuUrxfRo2P4tkXaMkaj97A-3WwNDy33x9Pww3VdvaFho-gk9kV',
      //             },
      //             body: jsonEncode(
      //
      //               <String, dynamic>{
      //                 'notification': <String, dynamic>{
      //                   'body': 'Alert Accepted',
      //                   'title': 'Verify',
      //                 },
      //                 'priority': 'high',
      //                 'data': <String, dynamic>{
      //                   'status': 'done'
      //                 },
      //                 'to': "",
      //                 //'to': "fWqN0UsURMGai3bLjvsN6G:APA91bHaxbaI93evufsSdEC6Kjr2BLffrHReEYVsrEjoiB4tLYMB5-5C0fN3jqKY1fXHhgiARCYrMeAybu7RqkjeaU5w-aHmdcAoTa-gqY9OgcXl02C8Two3cEt1o6S29O3xeJwMD0pW",
      //               },
      //             ),
      //           );
      //           response;
      //         } catch (e) {
      //           e;
      //         }
      //       }
      //        else if(receivedAction.buttonKeyPressed == "REJECT"){}
      //        else{
      //          print('Click on notification');
      //        }
      //
      //     }
      //
      //     // onActionReceivedMethod:         NotificationController.onActionReceivedMethod,
      //     // onNotificationCreatedMethod:    NotificationController.onNotificationCreatedMethod,
      //     // onNotificationDisplayedMethod:  NotificationController.onNotificationDisplayedMethod,
      //     // onDismissActionReceivedMethod:  NotificationController.onDismissActionReceivedMethod
      //
      // );

    });

    init();
  }



  init()async{

    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print("FirebaseMessaging.instance.getInitialMessage");
      if (message!= null) {
        print("New Notification");
        final routeFromMessage = message.data["route"];
        Navigator.of(context).pushNamed(routeFromMessage);

       // LocalNotificationService.createanddisplaynotification(message);
      }
    },);

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen((message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
        }
        LocalNotificationService.createanddisplaynotification(message);
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");

        }
       // LocalNotificationService.createanddisplaynotification(message);

      },
    );

    //For Permission
    notificationService.requestNotificationPermission();

    preferences=await SharedPreferences.getInstance();
    id.value=preferences.getString("id")??'';
    name.value=preferences.getString("name")??'';
    email.value=preferences.getString("email")??'';
    number.value = preferences.getString("phone") ?? '';
    token.value = preferences.getString("token") ?? '';
  }

  //For Home Slider
  Future<List<HomeSlider>> fetchCarouselData() async {
    final response = await http.get(Uri.parse('https://verifyserve.social/WebService1.asmx/ShowHomeimg'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) {
        return HomeSlider(
          himage: item['Himage'],
        );
      }).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  //Website Link
  _launchURL() async {
    final Uri url = Uri.parse('https://theverify.in/');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  bool isSigningOut = false;

  Future<void> backpress(id) async{
    final responce = await http.get(Uri.parse("https://verifyserve.social/WebService3_ServiceWork.asmx/Delete_Account_by_id?Uid=$id"));
    //final responce = await http.get(Uri.parse('https://verifyserve.social/WebService2.asmx/Add_Tenants_Documaintation?Tenant_Name=gjhgjg&Tenant_Rented_Amount=entamount&Tenant_Rented_Date=entdat&About_tenant=bout&Tenant_Number=enentnum&Tenant_Email=enentemail&Tenant_WorkProfile=nantwor&Tenant_Members=enentmember&Owner_Name=wnername&Owner_Number=umb&Owner_Email=emi&Subid=3'));

    if(responce.statusCode == 200){
      print(responce.body);

      //SharedPreferences prefs = await SharedPreferences.getInstance();

    } else {
      print('Failed Registration');
    }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: InkWell(
          onTap: () => scaffoldKey.currentState?.openDrawer(),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Image.asset(
                AppImages.menu,
                color: Colors.white,
                height: 30,
              ),
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Image.asset(AppImages.verify_again, height: 75),
      ),
      drawer: Drawer(
        backgroundColor: Colors.black,
        width: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // height: 230,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                    // SizedBox(
                    //   height: 120.h,
                    //   width: 120.w,
                    //   child: ClipRRect(
                    //       borderRadius: BorderRadius.circular(5),
                    //       child: Image.asset(
                    //         "assets/images/profile.png",
                    //         fit: BoxFit.cover,
                    //       )),
                    // ),
                    InkWell(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProfilePage()));
                        scaffoldKey.currentState?.openEndDrawer();
                      },
                      child: Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                                radius: 60,
                                backgroundImage: AssetImage('assets/images/man.png')
                              //_imageFile == null? AssetImage('assets/images/profile.jpg'): FileImage(file(_imageFile.path)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ValueListenableBuilder(
                      valueListenable: name,
                      builder: (context, String name,__) {
                        return Text(
                          name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        );
                      }
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                     ValueListenableBuilder(
                         valueListenable: email,
                         builder: (context, String email,__) {
                         return Text(
                          email,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                    );
                       }
                     ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      /*child: ValueListenableBuilder(
                          valueListenable: email,
                          builder: (context, String email,__) {
                            return Text(
                              email,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            );
                          }
                      ),*/
                    ),
                  ],

                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            /*Center(
              child: Image.asset(
                AppImages.scanner,
                color: Colors.white,
                fit: BoxFit.cover,
                height: 200,
                width: 200,
              ),
            ),
            const SizedBox(
              height: 5,
            ),*/
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
              child: const Text(
                "This Is Verify Multi-Service App.",
                style: TextStyle(color: Colors.grey, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
                scaffoldKey.currentState?.openEndDrawer();
              },
              child: Container(
                child: const Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      PhosphorIcons.user,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "My Profile",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // const SizedBox(
            //   height: 20,
            // ),
            // const Row(
            //   children: [
            //     SizedBox(
            //       width: 15,
            //     ),
            //     Icon(
            //       PhosphorIcons.gear,
            //       color: Colors.white,
            //       size: 20,
            //     ),
            //     SizedBox(
            //       width: 10,
            //     ),
            //     Text(
            //       "Settings",
            //       style: TextStyle(
            //         fontWeight: FontWeight.bold,
            //         fontSize: 15,
            //         color: Colors.white,
            //       ),
            //     ),
            //   ],
            // ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutPage()));
                scaffoldKey.currentState?.openEndDrawer();
              },
              child: const Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Icon(
                    Iconsax.profile_2user_copy,
                   // Icons.groups,
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "About us",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            InkWell(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute
                      (builder: (context) => My_Documents())
                );
              },
              child: Container(
                child: const Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    // Icon(
                    //   PhosphorIcons.browser,
                    //   color: Colors.white,
                    //   size: 20,
                    // ),
                    Image(image: AssetImage("assets/images/doc_.jpg"),width: 20,),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Documents",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

              ),
            ),
            const SizedBox(
              height: 20,
            ),

            InkWell(
              onTap: (){
                _launchURL();
                scaffoldKey.currentState?.openEndDrawer();
              },
              child: Container(
                child: const Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    // Icon(
                    //   PhosphorIcons.browser,
                    //   color: Colors.white,
                    //   size: 20,
                    // ),
                    Image(image: AssetImage("assets/images/website.png"),width: 20,color: Colors.white,),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Website",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

              ),
            ),

            const SizedBox(
              height: 20,
            ),

            Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Icon(
                  Iconsax.logout_1_copy,
               // Icons.exit_to_app_outlined,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    scaffoldKey.currentState?.openEndDrawer();
                    setState(() {
                      isSigningOut = true;
                    });
                    await Future.delayed(Duration(seconds: 1));
                    await FirebaseMessaging.instance.deleteToken();
                    SharedPreferences pref = await SharedPreferences.getInstance();
                    pref.clear();
                    Navigator.of(context).pushNamedAndRemoveUntil(LoginPage.route, (route) => false);
                    setState(() {
                      isSigningOut = false;
                    });
                  },
                  child: Text(
                    "Sign Out",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: ValueListenableBuilder(
          valueListenable: bloc.mainGridLoader,
          builder: (context, bool loading, _) {
            if (loading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: isSigningOut
                      ? Center(
                        child: Container(
                        padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 12),
                        width: 230,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(width: 1, color: Colors.white),
                          color: Colors.white
                        ),
                        child: Column(
                          children: [
                            Text('Signing Out...',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black,fontFamily: 'Poppins',letterSpacing: 1.5),),
                            SizedBox(height: 10,),
                            Center(child: SizedBox(
                              width: 30,
                                height: 30,
                                child: CircularProgressIndicator(strokeWidth: 2,))),
                          ],
                        )),
                      )
                      :
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /*Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextFormField(
                            controller: TextEditingController(),
                            decoration: const InputDecoration(
                              icon: Icon(
                                PhosphorIcons.magnifying_glass,
                                color: Colors.grey,
                                size: 18,
                              ),
                              contentPadding: EdgeInsets.only(top: 0, bottom: 9),
                              border: InputBorder.none,
                              hintText: "Search Here...",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          )),*/
                      const SizedBox(
                        height: 0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>  Provider.value(
                              value: vehicleBloc,
                              child: const SendParkingAlert(),),));
                        },
                        child: Container(
                          height: 45,
                          width: 1.sw,
                          margin: const EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              color: Colors.red),
                          child: const Center(
                            child: Text(
                              "Send Parking Alert ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  // letterSpacing: 0.8,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ValueListenableBuilder(
                          valueListenable: number,
                          builder: (context, String num,__)  {
                          return GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 0,
                            children:
                                List.generate(bloc.mailList.value.length, (index) {
                              return InkWell(
                                onTap: () async {
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.setString('login_number', num);
                                  if (index == 0) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SliverListExample()),

                                    );
                                  }
                                  if (index == 1) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              //const NotificationPage()),
                                          //RealEstateHomepage()),
                                          ServicesScreen()),
                                          //SliverListExample()),
                                    );
                                  }
                                  if (index == 2) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              //const RealEstateHomepage()),
                                          SendParkingAlert(),),
                                    );
                                  }
                                  if (index == 3) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const DocumentScreen()),
                                          //const ServicesScreen()),
                                    );

                                  }
                                  if (index == 4) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const  ComingSoon12()),
                                             // const InsurancePage()),
                                    );
                                  }
                                  if (index == 5) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ServicesScreen()),
                                    );
                                  }
                                  if (index == 6) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Job()),
                                    );
                                  }
                                  if (index == 7) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const ITLawyer()),
                                    );
                                  }
                                  if (index == 8) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const EventsAndWEdding()),
                                          /*builder: (context) => const ComingSoon12()),*/
                                      // Events And Wedding Layout _______


                                      
                                    );
                                  }
                                  if (index == 9) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HotelScreen()),
                                    );
                                  }
                                  if (index == 10) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const EventsAndWEdding()),
                                    );
                                  }
                                  if (index == 11) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const TruckScreen()),
                                    );
                                  }
                                },
                                child: Column(
                                  children: [
                                    ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5)),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "http://www.verifyserve.social/upload/${bloc.mailList.value[index].vimage}",
                                          height: 100.h,
                                          width: 170.w,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => Image.asset(
                                            AppImages.loading,
                                            height: 60.h,
                                            fit: BoxFit.cover,
                                            width: 110.w,
                                          ),
                                          errorWidget: (context, error, stack) =>
                                              Image.asset(
                                            AppImages.imageNotFound,
                                            height: 60.h,
                                            fit: BoxFit.cover,
                                            width: 110.w,
                                          ),
                                        )
                                        // FadeInImage.assetNetwork(
                                        //   image: "http://www.verifyserve.social/upload/${bloc.mailList.value[index].vimage}",
                                        //   height: 60.h,
                                        //   width: 110.w,
                                        //   fit: BoxFit.cover,
                                        //   placeholder: AppImages.loading,
                                        //   imageErrorBuilder: (context, error, stack) => Image.asset(
                                        //     AppImages.imageNotFound,
                                        //     height: 60.h,
                                        //     fit: BoxFit.cover,
                                        //     width: 110.w,
                                        //   ),
                                        // ),
                                        ),
                                    /* SizedBox(
                                    height: 60.h,
                                    width: 110.w,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.network(
                                          "http://www.verifyserve.social/upload/${bloc.mailList.value[index].vimage}",
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Image.asset(AppImages.logo);
                                          },
                                        ),
                                    ),
                                  ),*/
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Flexible(
                                      child: Text(
                                        bloc.mailList.value[index].vname ?? "",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 11),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          );
                        }
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FutureBuilder<List<HomeSlider>>(
                        future: fetchCarouselData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator(),heightFactor: 4,);
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData) {
                            return Center(child: Text('No data available.'));
                          } else {
                            return CarouselSlider(
                              options: CarouselOptions(
                                height: 180.0,
                                enlargeCenterPage: true,
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 2),
                              ),
                              items: snapshot.data!.map((item) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return  Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      width: 320.w,
                                      child: ClipRRect(
                                        borderRadius:
                                        const BorderRadius.all(Radius.circular(15)),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                          "https://www.verifyserve.social/upload/${item.himage}",
                                          fit: BoxFit.fill,
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
                                    );
                                  },
                                );
                              }).toList(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}