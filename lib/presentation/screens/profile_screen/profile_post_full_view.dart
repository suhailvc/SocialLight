import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:social_light/application/provider/post_like_provider/post_like_provider.dart';
import 'package:social_light/application/provider/profile_provider/get_profile_data.dart';
import 'package:social_light/domain/user_model/post_model.dart';
import 'package:social_light/presentation/screens/profile_screen/widget/more_horiz_sheet.dart';
import 'package:social_light/presentation/widgets/shimmer.dart';
import 'package:social_light/presentation/widgets/single_widget_shimmer.dart';

class PostFullView extends StatelessWidget {
  final double? index;
  final String userId;
  const PostFullView({this.index, required this.userId, super.key});

  @override
  Widget build(BuildContext context) {
    var sizeQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black)),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 226, 231, 231),
        centerTitle: true,
        title: const Text(
          'jaswanth',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Consumer<GetProfileDataProvider>(builder: (context, value, child) {
            return FutureBuilder<List<PostModel>>(
                future: GetProfileDataProvider().getPost(userId),
                builder: (context, postSnapshot) {
                  if (postSnapshot.connectionState == ConnectionState.waiting) {
                    return Expanded(
                      child: ShimmerLoading(
                          containerHeight: sizeQuery.height * 0.2,
                          itemCount: 3),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: postSnapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            SizedBox(
                              height: sizeQuery.height * 0.01,
                            ),
                            FutureBuilder(
                                future: GetProfileDataProvider()
                                    .getUserData(userId),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const SingleWidgetShimmer();
                                  }
                                  return ListTile(
                                    leading: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            snapshot.data!.imgpath!)),
                                    title: Text(
                                      snapshot.data!.name!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                    subtitle: Text(postSnapshot
                                        .data![index].time
                                        .toString()),
                                    trailing: IconButton(
                                        onPressed: () => moreHorizBottomSheet(
                                            context,
                                            postSnapshot.data![index].postId!,
                                            userId),
                                        icon: const Icon(
                                          Icons.more_horiz_sharp,
                                          weight: 10,
                                        )),
                                  );
                                }),
                            SizedBox(
                              width: double.infinity,
                              height: sizeQuery.height * 0.5,
                              //  decoration: const BoxDecoration(color: Colors.amber),
                              child: Image.network(
                                postSnapshot.data![index].imgUrl!,
                                fit: BoxFit.fill,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Consumer<PostLikeProvider>(
                                    builder: (context, likeValue, child) {
                                  return FutureBuilder(
                                      future: likeValue.isLikedProvider(userId,
                                          postSnapshot.data![index].postId!),
                                      builder: (context, likeSnapshot) {
                                        return GestureDetector(
                                          onTap: () =>
                                              likeValue.postLikeProvider(
                                                  userId,
                                                  postSnapshot
                                                      .data![index].postId!),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                  width:
                                                      sizeQuery.width * 0.05),
                                              likeSnapshot.data == true
                                                  ? const Icon(
                                                      FontAwesomeIcons
                                                          .solidHeart,
                                                      color: Colors.red,
                                                    )
                                                  : const Icon(
                                                      FontAwesomeIcons.heart)
                                            ],
                                          ),
                                        );
                                      });
                                }),
                                SizedBox(width: sizeQuery.width * 0.05),
                                const Icon(FontAwesomeIcons.comment),
                                SizedBox(width: sizeQuery.width * 0.05),
                                const Icon(FontAwesomeIcons.shareFromSquare)
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  );
                });
          })
        ],
      ),
    );
  }
}
