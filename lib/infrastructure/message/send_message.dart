import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_light/domain/message_model/message_model.dart';
import 'package:social_light/infrastructure/message/message_uid_collection.dart';

sendMessageFireBase(String otherUid, String msg) async {
  var currentTime = DateTime.now().toString();
  var currentUid = FirebaseAuth.instance.currentUser!.uid;
  var docName = currentUid + otherUid;
  List<String> charList = docName.split('');
  charList.sort();
  String uniqueId = charList.join();
  MessageModel message = MessageModel(
      messageId: uniqueId,
      message: msg,
      sentTime: currentTime,
      toId: otherUid,
      userId: currentUid);

  var ref = FirebaseFirestore.instance
      .collection('message')
      .doc(uniqueId)
      .collection('chat');
  Map<String, dynamic> mapMessage = message.toJson();
  ref.doc(currentTime).set(mapMessage);
  await uidOfMessages(otherUid);
}
