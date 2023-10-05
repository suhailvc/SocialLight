import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

postLike(String userId, String postId) async {
  String currentUid = FirebaseAuth.instance.currentUser!.uid;
  var firebaseData = FirebaseFirestore.instance
      .collection('post')
      .doc(userId)
      .collection("this_user_post")
      .doc(postId);
  DocumentSnapshot<Map<String, dynamic>> postData = await firebaseData.get();
  List<dynamic> likeList = postData["like"];
  if (likeList.contains(currentUid)) {
    firebaseData.update({
      "like": FieldValue.arrayRemove([currentUid])
    });
  } else {
    firebaseData.update({
      "like": FieldValue.arrayUnion([currentUid])
    });
  }
}

Future<bool> isLiked(String userId, String postId) async {
  String currentUid = FirebaseAuth.instance.currentUser!.uid;
  var firebaseData = await FirebaseFirestore.instance
      .collection('post')
      .doc(userId)
      .collection("this_user_post")
      .doc(postId)
      .get();
  List<dynamic> likeList = firebaseData['like'];
  if (likeList.contains(currentUid)) {
    return true;
  }
  return false;
}
