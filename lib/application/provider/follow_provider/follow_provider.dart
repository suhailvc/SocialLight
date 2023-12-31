import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:social_light/domain/user_model/user_model.dart';
import 'package:social_light/infrastructure/follow/follow.dart';
import 'package:social_light/infrastructure/follow/followers_following_list.dart';

class FollowProvider extends ChangeNotifier {
  followUserProvider(String personId) async {
    await followUser(personId);
    notifyListeners();
  }

  Future<bool> isFollowing(String personId) async {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    var userDetails = await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserId)
        .get();
    List<dynamic> details = userDetails['following'];
    // notifyListeners();
    if (details.contains(personId)) {
      return true;
    }
    return false;
  }

  Future<UserDetails?> getFollowersProvider(String? userId) async {
    UserDetails? followData = await followersList(userId);
    notifyListeners();
    return followData;
  }
}
