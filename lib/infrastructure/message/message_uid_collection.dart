import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

uidOfMessages(String recieverId) async {
  var currentUid = FirebaseAuth.instance.currentUser!.uid;
  var messageDoc = await FirebaseFirestore.instance
      .collection("chat_list")
      .doc(currentUid)
      .get();
  var currentUserDocList =
      FirebaseFirestore.instance.collection("chat_list").doc(currentUid);
  var recieverDocList =
      FirebaseFirestore.instance.collection("chat_list").doc(recieverId);
  List uidList = (messageDoc.data() as dynamic)['Uid'];
  if (uidList.contains(recieverId)) {
    await currentUserDocList.update({
      "Uid": FieldValue.arrayRemove([recieverId])
    });
    await currentUserDocList.update({
      "Uid": FieldValue.arrayUnion([recieverId])
    });
    await recieverDocList.update({
      "Uid": FieldValue.arrayRemove([currentUid])
    });
    await recieverDocList.update({
      "Uid": FieldValue.arrayUnion([currentUid])
    });
  } else {
    await currentUserDocList.update({
      "Uid": FieldValue.arrayUnion([recieverId])
    });
    await recieverDocList.update({
      "Uid": FieldValue.arrayUnion([currentUid])
    });
  }
}
