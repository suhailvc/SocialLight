import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_light/application/provider/profile_provider/get_profile_data.dart';
import 'package:social_light/presentation/screens/bottom_nav_bar/bottom_nav_bar.dart';

homePostDeleteDialog({required BuildContext context, required postId}) {
  showDialog(
    useRootNavigator: true,
    useSafeArea: true,
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Delete'),
        content: const Text('Do yo want to delete'),
        actions: <Widget>[
          TextButton(
            child: const Text('CANCEL', style: TextStyle(color: Colors.teal)),
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
              await Provider.of<GetProfileDataProvider>(context, listen: false)
                  .deletePost(FirebaseAuth.instance.currentUser!.uid, postId);
              // ignore: use_build_context_synchronously
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BottomNavScreen(count: 0),
                  ));
            },
          ),
        ],
      );
    },
  );
}
