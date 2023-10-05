import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_light/application/provider/follow_provider/follow_provider.dart';
import 'package:social_light/domain/user_model/post_model.dart';

Future<List<PostModel>> getAllPost(String? userUid) async {
  List<PostModel> allposts = [];
  try {
    var collectionData =
        await FirebaseFirestore.instance.collection("uids").get();
    var docsData = collectionData.docs;
    for (int i = 0; i < docsData.length; i++) {
      var uidData = docsData[i];
      userUid = uidData['uid'];
      bool following = await FollowProvider().isFollowing(userUid!);
      if (following) {
        var postData = await FirebaseFirestore.instance
            .collection("post")
            .doc(userUid)
            .collection('this_user_post')
            .get();

        List<PostModel> posts = postData.docs.map((doc) {
          Map<String, dynamic> mapData = doc.data();
          return PostModel.fromJson(mapData);
        }).toList();
        allposts.addAll(posts);

        allposts.sort((a, b) => b.time!.compareTo(a.time!));
      }
    }

    return allposts;
  } catch (e) {
    log('exception occured $e');
    return [];
  }
}

Future<PostModel?> getSinglePost(String postId, String postUserId) async {
  PostModel post;
  try {
    var postData = await FirebaseFirestore.instance
        .collection("post")
        .doc(postUserId)
        .collection('this_user_post')
        .doc(postId)
        .get();
    Map<String, dynamic> mapData = postData.data()!;
    post = PostModel.fromJson(mapData);
    return post;
  } catch (e) {
    log('Exception found $e');
    return null;
  }
}
