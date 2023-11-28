import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

deleteMessage(String otherUid, String docId) async {
  try {
    var currentUid = FirebaseAuth.instance.currentUser!.uid;
    var docName = currentUid + otherUid;
    List<String> charList = docName.split('');
    charList.sort();
    String uniqueId = charList.join();
    await FirebaseFirestore.instance
        .collection("message")
        .doc(uniqueId)
        .collection('chat')
        .doc(docId)
        .delete();
  } catch (e) {
    log("Error $e");
  }
}
