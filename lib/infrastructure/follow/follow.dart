import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

followUser(String personId) async {
  try {
    final post = FirebaseFirestore.instance.collection("users");
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    var docDetails = await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserId)
        .get();

    final List<dynamic> userData = docDetails["following"];
    if (userData.contains(personId)) {
      await post.doc(currentUserId).update({
        "following": FieldValue.arrayRemove([personId])
      });

      await post.doc(personId).update({
        "followers": FieldValue.arrayRemove([currentUserId])
      });
    } else {
      await post.doc(currentUserId).update({
        "following": FieldValue.arrayUnion([personId])
      });
      await post.doc(personId).update({
        "followers": FieldValue.arrayUnion([currentUserId])
      });
    }
  } catch (e) {
    log("exception occured in follow $e");
  }
}
