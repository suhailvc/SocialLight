import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

deletePost(String postId) {
  var userId = FirebaseAuth.instance.currentUser!.uid;
  try {
    FirebaseFirestore.instance
        .collection("post")
        .doc(userId)
        .collection("this_user_post")
        .doc(postId)
        .delete();
  } catch (e) {
    log("exception found $e");
  }
}
