import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:social_light/application/provider/add_post.dart/get_post_provider.dart';
import 'package:social_light/application/provider/post_like_provider/post_like_provider.dart';
import 'package:social_light/presentation/screens/post_comment_screen/widget/comment_field.dart';
import 'package:social_light/presentation/widgets/shimmer.dart';

class PostCommentScreen extends StatelessWidget {
  final String userId;
  final String postId;
  final String name;
  // final String? desc;
  // final String imgPath;
  const PostCommentScreen(
      {required this.userId,
      required this.postId,
      // required this.imgPath,
      // this.desc,
      required this.name,
      super.key});

  @override
  Widget build(BuildContext context) {
    // bool content = desc == null || desc == '' ? 'true' : false;
    var sizeQuery = MediaQuery.of(context).size;
    // log(desc.toString());
    // log(content.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black)),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 226, 231, 231),
        centerTitle: true,
        title: Text(
          name,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Consumer<GetPostProvider>(builder: (context, postValue, child) {
          return FutureBuilder(
              future: postValue.getSinglePostProvider(postId, userId),
              builder: (context, postSnapshot) {
                if (!postSnapshot.hasData) {
                  return const SizedBox(
                      height: 30,
                      child: ShimmerLoading(itemCount: 2, containerHeight: 0));
                }
                return Column(
                  children: [
                    Visibility(
                      visible: postSnapshot.data!.caption == null ||
                              postSnapshot.data!.caption == ''
                          ? false
                          : true,
                      child: SizedBox(
                        height: sizeQuery.height * 0.01,
                      ),
                    ),
                    Visibility(
                      visible: postSnapshot.data!.caption == null ||
                              postSnapshot.data!.caption == ''
                          ? false
                          : true,
                      child: Row(
                        children: [
                          SizedBox(
                            width: sizeQuery.height * 0.02,
                          ),
                          Text(
                            postSnapshot.data!.caption!,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: postSnapshot.data!.caption == null ||
                              postSnapshot.data!.caption == ''
                          ? false
                          : true,
                      child: SizedBox(
                        height: sizeQuery.height * 0.02,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: sizeQuery.height * 0.34,
                      decoration: const BoxDecoration(),
                      child: Image.network(
                        postSnapshot.data!.imgUrl!,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      color: const Color.fromARGB(255, 214, 212, 212),
                      height: sizeQuery.height * 0.058,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Consumer<PostLikeProvider>(
                            builder: (context, likeValue, child) {
                              return FutureBuilder(
                                future:
                                    likeValue.isLikedProvider(userId, postId),
                                builder: (context, likeSnapshot) {
                                  return Row(
                                    children: [
                                      Text(postSnapshot.data!.like!.length
                                          .toString()),
                                      SizedBox(width: sizeQuery.width * 0.02),
                                      GestureDetector(
                                        onTap: () => likeValue.postLikeProvider(
                                            userId, postId),
                                        child: likeSnapshot.data == true
                                            ? const Icon(
                                                FontAwesomeIcons.solidHeart,
                                                color: Colors.red,
                                              )
                                            : const Icon(
                                                FontAwesomeIcons.heart),
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          SizedBox(width: sizeQuery.width * 0.05),
                          const Text('10'),
                          SizedBox(width: sizeQuery.width * 0.02),
                          const Icon(FontAwesomeIcons.comment),
                          SizedBox(width: sizeQuery.width * 0.05),
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 14,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            radius: 24,
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/download (1).jpeg',
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: const Text(
                            'Suhail',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          subtitle: const Text('photo comment',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          trailing: const Text('3h'),
                        );
                      },
                    ),
                  ],
                );
              });
        }),
      ),
      bottomSheet: const Padding(
        padding: EdgeInsets.all(8.0),
        child: CommentField(),
      ),
    );
  }
}
