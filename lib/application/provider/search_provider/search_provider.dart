import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_light/domain/user_model/user_model.dart';

class UserSearchProvider extends ChangeNotifier {
  List<UserDetails> allusers = [];
  List<UserDetails> searchedlist = [];
  TextEditingController searchController = TextEditingController();
  bool isDataLoaded = false;

  Future<void> getAllUsers() async {
    try {
      if (isDataLoaded) {
        return;
      }
      isDataLoaded = true;

      QuerySnapshot userUIDsSnapshot =
          await FirebaseFirestore.instance.collection('uids').get();
      List<DocumentSnapshot> uidDocuments = userUIDsSnapshot.docs;

      for (var i = 0; i < uidDocuments.length; i++) {
        var uid = uidDocuments[i]['uid'];

        DocumentSnapshot userSnapshot =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();

        if (uid != FirebaseAuth.instance.currentUser!.uid) {
          Map<String, dynamic> userData =
              userSnapshot.data() as Map<String, dynamic>;
          UserDetails user = UserDetails.fromJson(userData);
          allusers.add(user);
        } else {
          continue;
        }
      }

      notifyListeners();
    } catch (e) {
      log('Error: $e');
    }
  }

  List<UserDetails> searchlist(String query) {
    searchedlist = allusers
        .where((element) =>
            element.username!
                .toLowerCase()
                .contains(query.toLowerCase().trim()) ||
            element.name!.toLowerCase().contains(query.toLowerCase().trim()))
        .toList();
    notifyListeners();
    return searchedlist;
  }
}


