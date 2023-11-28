import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_light/domain/user_model/user_model.dart';
import 'package:social_light/presentation/widgets/warning.dart';

googleUserRegistration(
    context,
    String? imagePath,
    TextEditingController nameController,
    TextEditingController userNameController) async {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final String name = nameController.text;
  final String userName = userNameController.text;

  if (name.isEmpty || userName.isEmpty) {
    warning(context, 'Please fill in all the fields.');
    return;
  }

  warning(context, 'Successfully signed up');
  nameController.clear();
  userNameController.clear();

  String uid = auth.currentUser!.uid;
  UserDetails user = UserDetails(
      name: name,
      username: userName,
      imgpath: imagePath,
      uid: uid,
      followers: [],
      following: []);
  Map<String, dynamic> userData = user.toJson();
  FirebaseFirestore.instance.collection('users').doc(uid).set(userData);

  FirebaseFirestore.instance.collection('uids').add({
    'uid': FirebaseAuth.instance.currentUser!.uid.toString(),
  });
  FirebaseFirestore.instance.collection('chat_list').doc(uid).set({"Uid": []});
  false;
}
