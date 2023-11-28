import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_light/domain/comment_model/comment_model.dart';

Future<List<CommentModel>> getComment(
    {required postId, required postUserId}) async {
  List<CommentModel> commentList;
  var comment = await FirebaseFirestore.instance
      .collection('post')
      .doc(postUserId)
      .collection('this_user_post')
      .doc(postId)
      .collection("comments")
      .get();
  commentList = comment.docs.map(
    (data) {
      Map<String, dynamic> mapComment = data.data();
      return CommentModel.fromJson(mapComment);
    },
  ).toList();
  return commentList;
}

Future<int> getCommentCount({required postId, required postUserId}) async {
  try {
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection('post')
        .doc(postUserId)
        .collection('this_user_post')
        .doc(postId)
        .collection("comments");

    QuerySnapshot querySnapshot = await collectionReference.get();
    int documentCount = querySnapshot.size;

    return documentCount;
  } catch (e) {
    log('Error: $e');
    return 0;
  }
}
