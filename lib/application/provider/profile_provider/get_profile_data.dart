import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:social_light/domain/user_model/post_model.dart';
import 'package:social_light/domain/user_model/user_model.dart';
import 'package:social_light/infrastructure/user_profile/edit_profile_data.dart';
import 'package:social_light/presentation/widgets/warning.dart';

class GetProfileDataProvider extends ChangeNotifier {
  String uId = FirebaseAuth.instance.currentUser!.uid;
  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  UserDetails? userDataList;
  //TextEditingController passwordController = TextEditingController();
  List<PostModel> allposts = [];
  Future<UserDetails?> getUserData(String userId) async {
    print('........................user data');
    DocumentSnapshot data =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (data.exists) {
      Map<String, dynamic> userData = data.data() as Map<String, dynamic>;
      userDataList = UserDetails.fromJson(userData);
      return UserDetails.fromJson(userData);
    } else {
      return null;
    }
  }

  Future<List<PostModel>> getPost(String userId) async {
    var collectiData = await FirebaseFirestore.instance
        .collection('post')
        .doc(userId)
        .collection('this_user_post')
        .get();
    return allposts = collectiData.docs.map((data) {
      Map<String, dynamic> mapData = data.data();
      return PostModel.fromJson(mapData);
    }).toList();
  }

  deletePost(String userId, String postId) async {
    try {
      await FirebaseFirestore.instance
          .collection('post')
          .doc(userId)
          .collection('this_user_post')
          .doc(postId)
          .delete();
      notifyListeners();
    } catch (e) {
      log('error-$e');
    }
  }

  editUserDataProvider(
      {required BuildContext context,
      required String newNameController,
      required String? newImagepath,
      // required String newPasswordController,
      required String newUserNameController}) async {
    final String name = newNameController;
    final String userName = newUserNameController;
    //final String newPassword = newPasswordController;
    if (newImagepath == null) {
      warning(context, "please select photo");
      return;
    }
    if (name.isEmpty || userName.isEmpty) {
      warning(context, "please fill all the field");
      return;
    }
    // if (newPassword.length < 6) {
    //   warning(context, 'Password must be at least 6 characters long.');
    //   return;
    // }
    await editProfiledata(
        name: name,
        imagepath: newImagepath,
        // newPassword: newPassword,
        userName: userName);
    notifyListeners();
  }
}
