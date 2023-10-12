import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_light/domain/message_model/message_model.dart';

Future<List<MessageModel>> getMessagefirebase(String userId) async {
  List<MessageModel> messageList = [];
  String currentUId = FirebaseAuth.instance.currentUser!.uid;
  String combineId = userId + currentUId;
  var sortId = combineId.split('');
  sortId.sort();
  String uniqueId = sortId.join();
  var messages = await FirebaseFirestore.instance
      .collection("message")
      .doc(uniqueId)
      .collection('chat')
      .get();
  messageList = messages.docs.map((data) {
    Map<String, dynamic> mapData = data.data();
    return MessageModel.fromJson(mapData);
  }).toList();
  return messageList;
}
