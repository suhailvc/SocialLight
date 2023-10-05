import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:social_light/application/provider/profile_provider/get_profile_data.dart';

import 'package:social_light/presentation/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:social_light/presentation/screens/edit_post/edit_post.dart';

moreHorizBottomSheet(context, String postId, String userId) {
  var size = MediaQuery.of(context).size;
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.all(10),
        height: size.height * 0.2,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35), topRight: Radius.circular(35)),
            color: Colors.white),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditPostScreen(postId: postId),
                    ));
              },
              child: Row(
                children: [
                  SizedBox(
                    height: size.height * 0.12,
                  ),
                  const Icon(
                    size: 29,
                    FontAwesomeIcons.penToSquare,
                  ),
                  SizedBox(
                    width: size.height * 0.012,
                  ),
                  const Text(
                    'Edit',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Delete'),
                      content: const Text('Do yo want to delete'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('CANCEL',
                              style: TextStyle(color: Colors.teal)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text(
                            'DELETE',
                            style: TextStyle(color: Colors.teal),
                          ),
                          onPressed: () async {
                            log(FirebaseAuth.instance.currentUser!.uid);
                            log(postId);
                            await Provider.of<GetProfileDataProvider>(context,
                                    listen: false)
                                .deletePost(
                                    FirebaseAuth.instance.currentUser!.uid,
                                    postId);
                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const BottomNavScreen(count: 4),
                                ));
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Row(
                children: [
                  const Icon(
                    size: 29,
                    Icons.delete,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: size.height * 0.012,
                  ),
                  const Text(
                    'Delete',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.red),
                  )
                ],
              ),
            )
          ],
        ),
      );
    },
  );
}
