import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_light/domain/notification_model/notification_model.dart';
import 'package:social_light/infrastructure/push_notification/push_notification.dart';

addNotification(String toId, String status, String token) async {
  var currentUid = FirebaseAuth.instance.currentUser!.uid;
  String id = DateTime.now().millisecondsSinceEpoch.toString();
  var firebase =
      FirebaseFirestore.instance.collection('notification').doc(toId);
  NotificationModel notification = NotificationModel(
      currentUserId: currentUid,
      toId: toId,
      id: id,
      status: status,
      time: DateTime.now().toString());
  Map<String, dynamic> mapNotification = notification.toJson();
  await firebase.collection('user').add(mapNotification);
  sendPushNotification(token, 'user', status);
}

Future<List<NotificationModel>> getNotification() async {
  List<NotificationModel> notificationList = [];
  var currentUid = FirebaseAuth.instance.currentUser!.uid;
  var firebase =
      FirebaseFirestore.instance.collection('notification').doc(currentUid);
  try {
    var notificationSnapshot = await firebase
        .collection('user')
        .orderBy('time', descending: true)
        .get();
    notificationList = notificationSnapshot.docs.map((doc) {
      Map<String, dynamic> mapData = doc.data();
      return NotificationModel.fromJson(mapData);
    }).toList();
    return notificationList;
  } catch (e) {
    log("exception occure $e");
  }
  return notificationList;
}
