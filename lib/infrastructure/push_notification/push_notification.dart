import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';

import 'package:http/http.dart' as http;

class FirbaseNotification {
  final _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    var token = await _firebaseMessaging.getToken();
    log('---------token-------------$token-----------------');

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    var result = await FlutterNotificationChannel.registerNotificationChannel(
      description: 'For Showing Notification',
      id: 'chats',
      importance: NotificationImportance.IMPORTANCE_HIGH,
      name: 'Chats',
    );
    log("notification channel result $result");
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got a message whilst in the foreground!');
      log('Message data: ${message.data}');

      if (message.notification != null) {
        log('Message also contained a notification: ${message.notification}');
      }
    });
  }
}

saveToken() async {
  var token = await FirebaseMessaging.instance.getToken();
  await FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .update({"pushToken": token});
}

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  log('Title:${message.notification?.title}');
  log('Body:${message.notification?.body}');
  log('PlayLoad:${message.data}');
}

Future<void> sendPushNotification(String token, String name, String msg) async {
  try {
    final body = {
      "to": token,
      "notification": {
        "title": name,
        "notification": msg,
        "android_channel_id": "chats",
      },
      "data": {
        "some_data": "User_Id:1234",
      },
    };
    var url = Uri.https('https://fcm.googleapis.com/fcm/send');
    var response = await http.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader:
              'AAAAymYhkoo:APA91bGfa-9AusrVlOG-b2ov3FSbim9n-oMy96SK4DbwPxakXpM330O18m4u0p8ahvVXHytG02aCxv7x5rcOa-cMDU_bdp-Mmx6eOxfdoActq87puZ6dUCifV6FAksJZSMDxIxlBqvQP'
        },
        body: jsonEncode(body));
    log('Response status: ${response.statusCode}');
    log('Response body: ${response.body}');

    log(await http.read(Uri.https('example.com', 'foobar.txt')));
  } catch (e) {
    log('exception in push notification$e');
  }
}
// firebaseMessagingToken() async {
//   await FirebaseMessaging.instance.requestPermission();
//   await FirebaseMessaging.instance.getToken().then((t) {
//     print(t);
//     if (t != null) {
//       UserDetails().pushToken = t;
//     }
//   });
// }

// storePushToken() async {
//   String? token = await FirebaseMessaging.instance.getToken();
//   print("----token----$token");
//   FirebaseFirestore.instance
//       .collection('users')
//       .doc(FirebaseAuth.instance.currentUser!.uid)
//       .set({"pushToken": token});
// }

// fTokenFunction() async {
//   await firebaseMessagingToken();
//   await storePushToken();
// }
