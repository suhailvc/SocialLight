import 'package:flutter/material.dart';
import 'package:social_light/domain/comment_model/comment_model.dart';
import 'package:social_light/infrastructure/comment/add_comment.dart';
import 'package:social_light/infrastructure/comment/get_comment.dart';

class PostCommentPorvider extends ChangeNotifier {
  TextEditingController commentController = TextEditingController();
  addCommentProvider(
      {required postUserId,
      required String postId,
      required String commentedUserId,
      required String comment}) {
    if (commentController.text.isEmpty) {
      return;
    }
    addComment(
        postUserId: postUserId,
        postId: postId,
        commentedUserId: commentedUserId,
        comment: comment);
    ChangeNotifier();
  }

  Future<List<CommentModel>> getCommentProvider(
      {required postId, required postUserId}) async {
    List<CommentModel> commentList =
        await getComment(postUserId: postUserId, postId: postId);
    ChangeNotifier();
    return commentList;
  }

  Future<int> getCommentCountProvider(
      {required postId, required postUserId}) async {
    int commentCount =
        await getCommentCount(postId: postId, postUserId: postUserId);
    ChangeNotifier();
    return commentCount;
  }
}
