import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:social_light/application/provider/add_post.dart/get_post_provider.dart';
import 'package:social_light/application/provider/add_post.dart/post_comment.dart';
import 'package:social_light/application/provider/notification_provider/notification_provider.dart';
import 'package:social_light/application/provider/post_like_provider/post_like_provider.dart';
import 'package:social_light/application/provider/profile_provider/get_profile_data.dart';
import 'package:social_light/presentation/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:social_light/presentation/screens/post_comment_screen/post_comment_screen.dart';

import 'package:social_light/presentation/screens/profile_screen/user_profile_screen.dart';
import 'package:social_light/presentation/screens/profile_screen/widget/more_horiz_sheet.dart';
import 'package:social_light/presentation/widgets/single_widget_shimmer.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostImage extends StatelessWidget {
  final String postId;
  final String? descContent;
  final String userId;
  final String postImage;
  final String time;

  const PostImage(
      {required this.postId,
      required this.descContent,
      required this.time,
      required this.userId,
      required this.postImage,
      super.key});

  @override
  Widget build(BuildContext context) {
    DateTime postDateTime = DateTime.parse(time);
    var size = MediaQuery.of(context).size;
    final provider = Provider.of<GetPostProvider>(context, listen: false);
    return FutureBuilder(
        future: GetProfileDataProvider().getUserData(userId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SingleWidgetShimmer();
          }

          return Column(
            children: [
              GestureDetector(
                  onTap: () {
                    userId != FirebaseAuth.instance.currentUser!.uid
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  OtherUserProfileScreen(userId: userId),
                            ))
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const BottomNavScreen(count: 4)));
                  },
                  child: ListTile(
                    leading: snapshot.data!.imgpath != null
                        ? CircleAvatar(
                            backgroundColor: Colors.amber,
                            backgroundImage:
                                NetworkImage(snapshot.data!.imgpath!))
                        : const CircleAvatar(
                            backgroundImage: AssetImage(
                                'assets/images/585e4bf3cb11b227491c339a.png'),
                          ),
                    title: Text(
                      snapshot.data!.name!,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.black),
                    ),
                    subtitle: Text(timeago
                        .format(postDateTime, allowFromNow: true)
                        .toString()),
                    trailing: userId == FirebaseAuth.instance.currentUser!.uid
                        ? GestureDetector(
                            onTap: () => moreHorizBottomSheet(context, postId,
                                0, userId, postImage, descContent),
                            child: const Icon(Icons.more_vert))
                        : const SizedBox(),
                  )),
              GestureDetector(
                onDoubleTap: () {},
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostCommentScreen(
                            postId: postId,
                            userId: userId,
                            name: snapshot.data!.name!),
                      ));
                },
                child: Container(
                  width: double.infinity,
                  height: 300,
                  decoration: const BoxDecoration(),
                  child: Image.network(
                    postImage,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Consumer<GetPostProvider>(builder: (context, postValue, child) {
                return FutureBuilder(
                    future:
                        provider.getSinglePostProvider(postId, userId, "home"),
                    builder: (context, postSnapshot) {
                      print("----------home screen");
                      if (!postSnapshot.hasData) {
                        return const SizedBox();
                      }

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: size.width * 0.05),
                          Text(postSnapshot.data!.like!.length.toString()),
                          SizedBox(width: size.width * 0.02),
                          Consumer<PostLikeProvider>(
                              builder: (context, likeValue, child) {
                            return FutureBuilder(
                              future: PostLikeProvider()
                                  .isLikedProvider(userId, postId),
                              builder: (context, likeSnapshot) {
                                return GestureDetector(
                                    onTap: () {
                                      PostLikeProvider()
                                          .postLikeProvider(userId, postId);
                                      if (likeSnapshot.data == false) {
                                        Provider.of<NotificationProvider>(
                                                context,
                                                listen: false)
                                            .addNotificationProvider(
                                                userId,
                                                'is Liked your post',
                                                snapshot.data!.pushToken!);
                                      }
                                    },
                                    child: likeSnapshot.data == true
                                        ? const Icon(
                                            FontAwesomeIcons.solidHeart,
                                            color: Colors.red,
                                          )
                                        : const Icon(FontAwesomeIcons.heart));
                              },
                            );
                          }),
                          SizedBox(width: size.width * 0.05),
                          Consumer<PostCommentPorvider>(
                              builder: (context, commentCountValue, child) {
                            return FutureBuilder(
                                future:
                                    commentCountValue.getCommentCountProvider(
                                        postId: postId, postUserId: userId),
                                builder: (context, commentCountsnapshot) {
                                  return Text(
                                      commentCountsnapshot.data.toString());
                                });
                          }),
                          SizedBox(width: size.width * 0.02),
                          const Icon(FontAwesomeIcons.comment),
                        ],
                      );
                    });
              }),
              const SizedBox(height: 10)
            ],
          );
        });
  }
}
