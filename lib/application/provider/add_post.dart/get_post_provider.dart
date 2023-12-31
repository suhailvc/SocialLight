import 'package:flutter/material.dart';
import 'package:social_light/domain/user_model/post_model.dart';
import 'package:social_light/infrastructure/post/delete_post.dart';
import 'package:social_light/infrastructure/post/edit_post.dart';
import 'package:social_light/infrastructure/post/get_post.dart';

class GetPostProvider extends ChangeNotifier {
  String? userUid;
  List<PostModel> allposts = [];
  PostModel? post;
  Future<List<PostModel>> getPost() async {
    allposts = await getAllPost(userUid);
    notifyListeners();
    return allposts;
  }

  Future<PostModel?> getSinglePostProvider(
      String postId, String postUserId, String screen) async {
    print('--------------------$screen');

    post = await getSinglePost(postId, postUserId);
    notifyListeners();
    return post;
  }

  deletePostProvider(String postId) {
    deletePost(postId);
    notifyListeners();
  }

  editPostProvider(
      {required String postId, required String caption, required newUrl}) {
    editPost(postId, caption, newUrl);
    notifyListeners();
  }
}
