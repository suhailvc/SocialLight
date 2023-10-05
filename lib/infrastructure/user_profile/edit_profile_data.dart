import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

editProfiledata(
    {required String name,
    required String imagepath,
    // required String newPassword,
    required String userName}) async {
  try {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    // await FirebaseAuth.instance.currentUser!.updatePassword(newPassword);
    await FirebaseFirestore.instance.collection("users").doc(userId).update({
      "name": name,
      "imgpath": imagepath,
      "username": userName,
    });
  } catch (e) {
    log("exception found $e");
  }
}
