import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_light/domain/message_model/message_model.dart';

Future<MessageModel?> getLastMessage(String userId) async {
  try {
    String currentUId = FirebaseAuth.instance.currentUser!.uid;
    String combineId = userId + currentUId;
    var sortId = combineId.split('');
    sortId.sort();
    String uniqueId = sortId.join();
    var messageDoc = await FirebaseFirestore.instance
        .collection("message")
        .doc(uniqueId)
        .collection('chat')
        .orderBy('sentTime', descending: true)
        .limit(1)
        .get();

    if (messageDoc.docs.isNotEmpty) {
      Map<String, dynamic> data = messageDoc.docs.first.data();
      print('@@@@@@@@@${data}');
      return MessageModel.fromJson(data);
    } else {
      return null;
    }
    // if (messageDoc.docs.isNotEmpty) {
    //   DocumentSnapshot<Map<String, dynamic>> firstDocument = messageDoc.docs[0];
    //   Map<String, dynamic> mapMessage = firstDocument.data() ?? {};
    //   return MessageModel.fromJson(mapMessage);
    // } else {
    //   return null;
    // }
  } catch (e) {
    log('Error getting last message: $e');
  }
  // return null;
}
