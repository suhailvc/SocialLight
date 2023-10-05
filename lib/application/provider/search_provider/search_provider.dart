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


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:social_light/domain/user_model/user_model.dart';

// class UserSearchProvider extends ChangeNotifier {
//   List<UserDetails> allUsers = [];
//   List<UserDetails> searchResult = [];
//   bool isLoading = true;
//   Future<void> allUser() async {
//     // allUsers.clear();
//     //notifyListeners();
//     //searchResult.clear();
//     //notifyListeners();
//     var collectionData =
//         await FirebaseFirestore.instance.collection("uids").get();
//     var docData = collectionData.docs;
//     for (int i = 0; i < docData.length; i++) {
//       var uId = docData[i];

//       var userUid = uId["uid"];
//       if (FirebaseAuth.instance.currentUser!.uid != userUid) {
//         var userDetails = await FirebaseFirestore.instance
//             .collection("users")
//             .doc(userUid)
//             .get();

//         Map<String, dynamic> userData =
//             userDetails.data() as Map<String, dynamic>;
//         var userDetailsList = UserDetails.fromJson(userData);
//         allUsers.clear();
//         notifyListeners();
//         allUsers.add(userDetailsList);

//         notifyListeners();
//       }
//     }

// /*     return searchResult;
//  */
//   }

//   @override
//   void dispose() {
//     searchResult.clear();
//     notifyListeners();
//     allUsers.clear();
//     notifyListeners();
//     super.dispose();
//   }

//   searchUser(String name) {
//     searchResult = allUsers
//         .where((element) =>
//             element.name!.toLowerCase().contains(name.toLowerCase().trim()))
//         .toList();
//     notifyListeners();
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:social_light/domain/user_model/user_model.dart';

// class UserSearchProvider extends ChangeNotifier {
//   // List<UserDetails> allUsers = [];
//   List<UserDetails> searchResult = [];
//   TextEditingController searchController = TextEditingController();
//   serachUser() async {
//     searchResult.clear();
//     notifyListeners();
//     var collectionDetails = await FirebaseFirestore.instance
//         .collection("users")
//         .where("name", isGreaterThanOrEqualTo: searchController.text)
//         .get();
//     collectionDetails.docs.forEach((doc) {
//       // Convert the document data into a UserDetails object
//       UserDetails userDetails = UserDetails(
//         // Replace these lines with your actual field names
//         //  id: doc.id,
//         name: doc['name'],
//         // Add other fields as needed
//       );

//       // Add the UserDetails object to the searchResult list
//       searchResult.add(userDetails);
//     });

//     // Notify listeners that the search results have been updated
//     notifyListeners();
//   }
// }
