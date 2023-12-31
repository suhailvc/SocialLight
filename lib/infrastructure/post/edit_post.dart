import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

editPost(String postId, String caption,String newUrl) {
  try {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection("post")
        .doc(userId)
        .collection("this_user_post")
        .doc(postId)
        .update({"caption": caption, "imgUrl": newUrl});
  } catch (e) {
    log("exception found $e");
  }
}
