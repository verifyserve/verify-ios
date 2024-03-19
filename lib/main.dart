import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verify/UI/auth/login.dart';
import 'package:verify/UI/home/home_bar.dart';
import 'package:verify/UI/splash/splash.dart';
import 'package:verify/data/Notification/local_notification_service.dart';
import 'package:verify/data/network/api_service.dart';
import 'package:verify/data/network/interceptors.dart';
import 'package:verify/data/repository/AuthRepository.dart';
import 'package:verify/data/repository/AuthRepository.dart';
import 'package:verify/data/repository/DocumentationRepository.dart';
import 'package:verify/data/repository/DocumentationRepository.dart';
import 'package:verify/data/repository/HomeRepository.dart';
import 'package:verify/data/repository/HotelRepository.dart';
import 'package:verify/data/repository/ItAndDesignRepossitory.dart';
import 'package:verify/data/repository/ItAndDesignRepossitory.dart';
import 'package:verify/data/repository/RealEstateRepository.dart';
import 'package:verify/data/repository/RealEstateRepository.dart';
import 'package:verify/data/repository/TruckRepositrory.dart';
import 'package:verify/data/repository/consultantRepository.dart';
import 'package:verify/data/repository/consultantRepository.dart';
import 'package:verify/data/repository/eventsAndWeddingRepository.dart';
import 'package:verify/data/repository/eventsAndWeddingRepository.dart';
import 'package:verify/data/repository/jobsRepository.dart';
import 'package:verify/data/repository/jobsRepository.dart';
import 'package:verify/data/repository/notificationRepository.dart';
import 'package:verify/data/repository/notificationRepository.dart';
import 'package:verify/data/repository/servicesRepository.dart';
import 'package:verify/data/repository/servicesRepository.dart';
import 'package:verify/data/repository/vehicleRepository.dart';
import 'package:verify/data/repository/vehicleRepository.dart';
import 'package:verify/utils/routes.dart';

import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> backgroundHandler(RemoteMessage message) async {
  // if (message['data'] != null) {
  //   final data = message['data'];
  //   final title = data['title'];
  //   final body = data['message'];
  //   showNotification(title, body);
  // }

  print(message.data.toString());
  print(message.notification!.title);

  String? title=message.notification!.title;
  String? body=message.notification!.body;

  AwesomeNotifications().createNotification(content: NotificationContent(id: 123,
    channelKey: "verify_CallNotify_app",
    color: Colors.white,
    title: title,
    body: body,
    category: NotificationCategory.Call,
    notificationLayout: NotificationLayout.BigText,
    locked: true,
    wakeUpScreen: true,
    fullScreenIntent: true,
    autoDismissible: true,
    backgroundColor: Colors.orange,
    displayOnForeground: true,
    displayOnBackground: true,
    timeoutAfter: Duration(seconds: 15),
    chronometer: Duration.zero,
  ),
      actionButtons: [
        NotificationActionButton(key: "acceptance", label: "Accept", color: Colors.greenAccent, autoDismissible: true,),
        NotificationActionButton(key: "REJECT", label: "Wait", color: Colors.redAccent, autoDismissible: true,),
      ]
  );

}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotificationService.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  final sharedPreferences = await SharedPreferences.getInstance();
  Dio dio = Dio();
  dio.interceptors.add(AppInterceptors());
  final ApiService apiService = ApiService(dio);

  AwesomeNotifications().initialize(null, [
    NotificationChannel(channelKey: "verify_CallNotify_app",
      channelName: "verify_CallNotify_app_channel",
      channelDescription: "Verify Notification Channel",
      defaultColor: Colors.redAccent,
      ledColor: Colors.white,
      importance: NotificationImportance.High,
      defaultPrivacy: NotificationPrivacy.Private,
      channelShowBadge: true,
      locked: true,
      defaultRingtoneType: DefaultRingtoneType.Ringtone,
      enableVibration: true,
      playSound: true,
    ),
  ],debug: true);

  runApp(MyApp(sharedPreferences,apiService));
}

class MyApp extends StatefulWidget {
  const MyApp(this.prefs, this.apiService, {Key? key}) : super(key: key);
  final SharedPreferences prefs;
  final ApiService apiService;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late SharedPreferences preferences;
  ValueNotifier<String>iid=ValueNotifier("");

  @override
  void initState() {
    super.initState();
    init();
  }

  init()async{
    preferences=await SharedPreferences.getInstance();
    iid.value=preferences.getString("id")??'';
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<HomeRepository>.value(value: HomeRepository(widget.prefs, widget.apiService),),
        Provider<RealEstateRepository>.value(value: RealEstateRepository(widget.prefs, widget.apiService),),
        Provider<DocumentationRepository>.value(value: DocumentationRepository(widget.prefs, widget.apiService),),
        Provider<ConsultantRepository>.value(value: ConsultantRepository(widget.prefs, widget.apiService),),
        Provider<ServiceRepository>.value(value: ServiceRepository(widget.prefs, widget.apiService),),
        Provider<AuthRepository>.value(value: AuthRepository(widget.prefs, widget.apiService),),
        Provider<VehicleRepository>.value(value: VehicleRepository(widget.prefs, widget.apiService),),
        Provider<ItAndDesignRepository>.value(value: ItAndDesignRepository(widget.prefs, widget.apiService),),
        Provider<JobsRepository>.value(value: JobsRepository(widget.prefs, widget.apiService),),
        Provider<EventsAndWeddingRepository>.value(value: EventsAndWeddingRepository(widget.prefs, widget.apiService),),
        Provider<NotificationRepository>.value(value: NotificationRepository(widget.prefs, widget.apiService),),
        Provider<HotelRepository>.value(value: HotelRepository(widget.prefs, widget.apiService),),
        Provider<TruckRepository>.value(value: TruckRepository(widget.prefs, widget.apiService),),
      ],
      child: ValueListenableBuilder(
          valueListenable: iid,
          builder: (context, String i,__) {
          return ScreenUtilInit(
            designSize: const Size(423, 803),
            useInheritedMediaQuery: true,
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    fontFamily: 'Poppins', //'Lato', //'Gilroy',
                    // primarySwatch: Colors.deepPurple,
                    // brightness: Brightness.light,
                    // scaffoldBackgroundColor: K.yellowColor,
                  ),
                  initialRoute: Splash.route,
                  routes: Routes.routes,
                  // home: Splash(),
                  // onGenerateRoute: (routeSettings) {
                  //   debugPrint('routeSettings $routeSettings');
                  //   switch(routeSettings.name) {
                  //     case HomeBar.route:
                  //       return MaterialPageRoute(
                  //         builder: (context) => const HomeBar(), //Dashboard(key: UniqueKey()),
                  //         settings: routeSettings,
                  //       );
                  //   }
                  // },
                ),
              );
            },
          );
        }
      ),
    );
  }
}