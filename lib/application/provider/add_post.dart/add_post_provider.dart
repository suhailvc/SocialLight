import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_light/domain/user_model/post_model.dart';
import 'package:uuid/uuid.dart';

class AddPostProvider extends ChangeNotifier {
  submitPost(
    context,
    String postCaption,
    String imgUrl,
  ) {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    String postId = const Uuid().v1();
    PostModel post = PostModel(
        caption: postCaption,
        imgUrl: imgUrl,
        like: [],
        postId: postId,
        time: DateTime.now().toString(),
        userId: userId);
    Map<String, dynamic> postData = post.toJson();
    FirebaseFirestore.instance
        .collection('post')
        .doc(userId)
        .collection('this_user_post')
        .doc(postId)
        .set(postData);
  }
}
