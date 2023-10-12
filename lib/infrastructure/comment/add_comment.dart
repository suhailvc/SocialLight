import 'package:cloud_firestore/cloud_firestore.dart';

addComment(
    {required postUserId,
    required String postId,
    required String commentedUserId,
    required String comment}) async {
  String commentId = DateTime.now().millisecondsSinceEpoch.toString();
  await FirebaseFirestore.instance
      .collection('post')
      .doc(postUserId)
      .collection('this_user_post')
      .doc(postId)
      .collection("comments")
      .doc(commentId)
      .set({
    "commentId": commentId,
    "commentedUserId": commentedUserId,
    "comment": comment,
    "time": DateTime.now().toString()
  });
}
