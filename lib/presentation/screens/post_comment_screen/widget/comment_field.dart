import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:social_light/application/provider/add_post.dart/post_comment.dart';

class CommentField extends StatelessWidget {
  final String postId;
  final String postUserId;
  const CommentField(
      {required this.postUserId, required this.postId, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: Provider.of<PostCommentPorvider>(context, listen: false)
          .commentController,
      maxLines: 1,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        fillColor: Colors.white,
        hintText: 'Write your comment...',
        suffixIcon: InkWell(
          onTap: () async {
            await Provider.of<PostCommentPorvider>(context, listen: false)
                .addCommentProvider(
                    postUserId: postUserId,
                    postId: postId,
                    commentedUserId: FirebaseAuth.instance.currentUser!.uid,
                    comment:
                        Provider.of<PostCommentPorvider>(context, listen: false)
                            .commentController
                            .text);
            Provider.of<PostCommentPorvider>(context, listen: false)
                .commentController
                .text = '';
          },
          child: const Icon(FontAwesomeIcons.paperPlane),
        ),
      ),
    );
  }
}
