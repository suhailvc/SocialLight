import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_light/application/provider/follow_provider/follow_provider.dart';
import 'package:social_light/application/provider/notification_provider/notification_provider.dart';

class FollowButton extends StatelessWidget {
  final String otherUserId;
  final String token;
  const FollowButton(
      {required this.token, required this.otherUserId, super.key});

  @override
  Widget build(BuildContext context) {
    var sizeQuery = MediaQuery.of(context).size;
    return Consumer<FollowProvider>(
      builder: (context, followValue, child) {
        // String otherUserId = userList[index].uid.toString();
        return FutureBuilder<bool>(
          future: followValue.isFollowing(otherUserId),
          builder: (context, followSnapshot) {
            log(followSnapshot.data.toString());
            // if (followSnapshot.connectionState == ConnectionState.waiting) {
            //   return const CircularProgressIndicator();
            // }
            return ElevatedButton(
                onPressed: () {
                  followValue.followUserProvider(otherUserId);
                  if (followSnapshot.data == true) {
                    Provider.of<NotificationProvider>(context, listen: false)
                        .addNotificationProvider(
                            otherUserId, 'is started following you', token);
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize:
                      Size(sizeQuery.height * 0.12, sizeQuery.height * 0.04),
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: followSnapshot.data == true
                    ? const Text(
                        'Following',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : const Text(
                        'Follow',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ));
          },
        );
      },
    );
  }
}
