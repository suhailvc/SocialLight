import 'package:flutter/material.dart';
import 'package:social_light/infrastructure/post_like/post_like.dart';

class PostLikeProvider extends ChangeNotifier {
  postLikeProvider(String userId, String postId) {
    postLike(userId, postId);
    notifyListeners();
  }

  Future<bool> isLikedProvider(String userId, String postId) async {
    bool liked = await isLiked(userId, postId);
    notifyListeners();
    return liked;
  }
}
