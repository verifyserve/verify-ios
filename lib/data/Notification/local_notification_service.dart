
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:verify/UI/vehicle/Pages/newscreen.dart';


class LocalNotificationService{

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initialize() {
    // initializationSettings  for Android
    const InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings()
    );

    _notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (id) async {
        print("onSelectNotification");
        if (id!=null) {
          print("Router Value1234 $id");
          Navigator.of(BuildContext as BuildContext).push(
            MaterialPageRoute(
              builder: (context) => NewScreen(
                id: id,
              ),
            ),
          );
        }
      },
    );
  }

  Future<void> requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true,
    );

    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print('user granted permission');
    }
    else if(settings.authorizationStatus == AuthorizationStatus.provisional){
      print('user granted provisional permission');
    }
    else{
      print('user denied permission');
    }
  }

  static void createanddisplaynotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "verify_CallNotify_app", //verify_CallNotify_apk //verify_CallNotify_app
          "verify_CallNotify_channel",
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true
        ),
      );

      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data['_id'],
      );
    } on Exception catch (e) {
      print(e);
    }
  }

}