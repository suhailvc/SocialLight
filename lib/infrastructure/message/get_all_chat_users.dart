import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_light/domain/user_model/user_model.dart';

Future<List<UserDetails>> getMessageUserList() async {
  var currentUid = FirebaseAuth.instance.currentUser!.uid;
  List<UserDetails> allChatUsers = [];
  try {
    DocumentSnapshot<Map<String, dynamic>> messageDoc = await FirebaseFirestore
        .instance
        .collection("chat_list")
        .doc(currentUid)
        .get();
    List messageUidList = (messageDoc.data() as dynamic)["Uid"];
    for (var element in messageUidList) {
      if (element != currentUid) {
        DocumentSnapshot<Map<String, dynamic>> docUsersList =
            await FirebaseFirestore.instance
                .collection("users")
                .doc(element)
                .get();
        Map<String, dynamic> usersMap =
            docUsersList.data() as Map<String, dynamic>;
        UserDetails singleUser = UserDetails.fromJson(usersMap);
        allChatUsers.add(singleUser);
      }
    }

    return allChatUsers;
  } catch (e) {
    log('Error fetching messaged users: $e');
    return [];
  }
}
