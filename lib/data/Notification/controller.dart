import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;

class NotificationController {

  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future <void> onNotificationCreatedMethod(ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future <void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future <void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {
    // Your code goes here
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future <void> onActionReceivedMethod(ReceivedAction receivedAction) async {

    // Your code goes here
    if(receivedAction.buttonKeyPressed == "REJECT"){

    }

    else if(receivedAction.buttonKeyPressed == "acceptance"){
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
                'body': 'Alert Accepted',
                'title': 'Verify',
              },
              'priority': 'high',
              'data': <String, dynamic>{
                'status': 'done'
              },
              'to': "fWqN0UsURMGai3bLjvsN6G:APA91bHaxbaI93evufsSdEC6Kjr2BLffrHReEYVsrEjoiB4tLYMB5-5C0fN3jqKY1fXHhgiARCYrMeAybu7RqkjeaU5w-aHmdcAoTa-gqY9OgcXl02C8Two3cEt1o6S29O3xeJwMD0pW",
            },
          ),
        );
        response;
      } catch (e) {
        e;
      }
    }
    else{
      print('Click on notification');
    }

    // // Navigate into pages, avoiding to open the notification details page over another details page already opened
    // MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil('/notification-page',
    //         (route) => (route.settings.name != '/notification-page') || route.isFirst,
    //     arguments: receivedAction);
  }
}