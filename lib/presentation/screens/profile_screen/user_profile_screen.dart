import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:social_light/application/provider/add_post.dart/get_post_provider.dart';
import 'package:social_light/application/provider/profile_provider/get_profile_data.dart';
import 'package:social_light/core/constant.dart';
import 'package:social_light/presentation/screens/chat_screen/chat_screen.dart';
import 'package:social_light/presentation/screens/profile_screen/profile_post_full_view.dart';
import 'package:social_light/presentation/screens/profile_screen/widget/common_button.dart';
import 'package:social_light/presentation/screens/profile_screen/widget/profile_image_widget.dart';
import 'package:social_light/presentation/widgets/follow_button.dart';
import 'package:social_light/presentation/widgets/shimmer.dart';

class OtherUserProfileScreen extends StatelessWidget {
  final String userId;
  const OtherUserProfileScreen({required this.userId, super.key});

  @override
  Widget build(BuildContext context) {
    var sizeQuery = MediaQuery.of(context).size;
    return Consumer<GetProfileDataProvider>(builder: (context, value, child) {
      return FutureBuilder(
          future: GetProfileDataProvider().getUserData(userId),
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const ShimmerLoading(itemCount: 3, containerHeight: 0);
            }

            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    )),
                //  elevation: 0,
                // backgroundColor: const Color.fromARGB(255, 226, 231, 231),
                backgroundColor: const Color(0xFF0AA091),
                title: Text(
                  userSnapshot.data!.name!,
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                    decorationThickness: 2.0,
                  ),
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                otherUserId: userId,
                              ),
                            ));
                      },
                      icon: const Icon(
                        FontAwesomeIcons.message,
                        color: Colors.white,
                      ))
                ],
              ),
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF0AA091),
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(sizeQuery.height * 0.05),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: sizeQuery.height * 0.03),
                          userSnapshot.data!.imgpath != null
                              ? ProfileImgWidget(
                                  imageType: ImageType.network,
                                  imagePath: userSnapshot.data!.imgpath!,
                                  sizeQuery: sizeQuery)
                              : ProfileImgWidget(
                                  imageType: ImageType.asset,
                                  imagePath:
                                      'assets/images/585e4bf3cb11b227491c339a.png',
                                  sizeQuery: sizeQuery),
                          SizedBox(height: sizeQuery.height * 0.02),
                          Text(
                            userSnapshot.data!.name!,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: sizeQuery.height * 0.02),
                          FollowButton(otherUserId: userId),
                          SizedBox(
                            width: sizeQuery.height * 0.02,
                          ),
                          SizedBox(height: sizeQuery.height * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              commonButton(
                                sizeQuery.width * 0.23,
                                'Followers',
                                userSnapshot.data!.followers!.length.toString(),
                              ),
                              SizedBox(
                                width: sizeQuery.height * 0.02,
                              ),
                              commonButton(
                                sizeQuery.width * 0.23,
                                'Following',
                                userSnapshot.data!.following!.length.toString(),
                              ),
                            ],
                          ),
                          SizedBox(height: sizeQuery.height * 0.01),
                        ],
                      ),
                    ),
                    Container(
                      height: sizeQuery.height * 0.007,
                      color: Colors.white,
                    ),
                    Consumer<GetPostProvider>(builder: (context, value, child) {
                      return FutureBuilder(
                          future: GetProfileDataProvider().getPost(userId),
                          builder: (context, postSnapshot) {
                            if (postSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return SizedBox(
                                height: sizeQuery.height * 0.3,
                                child: const ShimmerLoading(
                                    itemCount: 3, containerHeight: 0),
                              );
                            }
                            return GridView.builder(
                              padding: const EdgeInsets.all(0),
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: postSnapshot.data!.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 2,
                                      crossAxisSpacing: 2,
                                      crossAxisCount: 3),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PostFullView(userId: userId),
                                      )),
                                  child: SizedBox(
                                      child: Image.network(
                                          postSnapshot.data![index].imgUrl!,
                                          fit: BoxFit.fill)),
                                );
                              },
                            );
                          });
                    })
                  ],
                ),
              ),
            );
          });
    });
  }
}
