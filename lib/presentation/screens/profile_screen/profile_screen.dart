import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:social_light/application/provider/profile_provider/get_profile_data.dart';
import 'package:social_light/domain/user_model/post_model.dart';
import 'package:social_light/presentation/screens/chat_screen/widget/on_user_login.dart';
import 'package:social_light/presentation/screens/edit_profile/edit_profile.dart';
import 'package:social_light/presentation/screens/login_screen/login.dart';
import 'package:social_light/presentation/screens/post_comment_screen/post_comment_screen.dart';
import 'package:social_light/presentation/screens/profile_screen/widget/common_button.dart';
import 'package:social_light/presentation/screens/profile_screen/widget/more_horiz_sheet.dart';
import 'package:social_light/presentation/widgets/shimmer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var sizeQuery = MediaQuery.of(context).size;
    return Consumer<GetProfileDataProvider>(
        builder: (context, profileValue, child) {
      return FutureBuilder(
        future: GetProfileDataProvider()
            .getUserData(FirebaseAuth.instance.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: ShimmerLoading(itemCount: 9, containerHeight: 0),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.hasError}'),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text('No user Found'),
            );
          }
          return Scaffold(
            appBar: AppBar(
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    onPressed: () => Scaffold.of(context).openDrawer(),
                    icon: const Icon(
                      Icons.menu,
                    ),
                  );
                },
              ),
              backgroundColor: const Color(0xFF0AA091),
              // backgroundColor: const Color.fromARGB(255, 226, 231, 231),
              title: Text(
                'Profile',
                style: GoogleFonts.roboto(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                  decorationThickness: 2.0,
                ),
              ),
              centerTitle: true,
            ),
            backgroundColor: Colors.white,
            drawer: Drawer(
                child: DrawerWidget(
              imgPath: snapshot.data!.imgpath,
              name: snapshot.data!.name!,
            )),
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
                        CircleAvatar(
                            radius: 50,
                            child: snapshot.data!.imgpath != null
                                ? ClipOval(
                                    child: Image.network(
                                    snapshot.data!.imgpath!,
                                    width: sizeQuery.height * 0.13,
                                    height: sizeQuery.height * 0.13,
                                    fit: BoxFit.cover,
                                  ))
                                : ClipOval(
                                    child: Image.asset(
                                    "assets/images/585e4bf3cb11b227491c339a.png",
                                    width: sizeQuery.height * 0.13,
                                    height: sizeQuery.height * 0.13,
                                    fit: BoxFit.cover,
                                  ))),
                        SizedBox(height: sizeQuery.height * 0.02),
                        Text(
                          snapshot.data!.name!,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: sizeQuery.height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            commonButton(
                              sizeQuery.width * 0.23,
                              'Followers',
                              snapshot.data!.followers!.length.toString(),
                            ),
                            SizedBox(
                              width: sizeQuery.height * 0.02,
                            ),
                            commonButton(
                              sizeQuery.width * 0.23,
                              'Following',
                              snapshot.data!.following!.length.toString(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: sizeQuery.height * 0.01,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: sizeQuery.height * 0.007,
                    color: Colors.white,
                  ),
                  Consumer<GetProfileDataProvider>(
                    builder: (context, value, child) {
                      return FutureBuilder<List<PostModel>>(
                        future: GetProfileDataProvider()
                            .getPost(FirebaseAuth.instance.currentUser!.uid),
                        builder: (context, postSnapshot) {
                          log(postSnapshot.data.toString());
                          if (postSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return SizedBox(
                                height: sizeQuery.height * 0.3,
                                child: const ShimmerLoading(
                                    itemCount: 3, containerHeight: 0));
                          } else if (postSnapshot.data == null &&
                              snapshot.data == []) {
                            return const Center(
                              child: Text(
                                'No data',
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          }
                          var postData = postSnapshot.data!;
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
                                onLongPress: () {
                                  moreHorizBottomSheet(
                                      context,
                                      postSnapshot.data![index].postId!,
                                      FirebaseAuth.instance.currentUser!.uid);
                                  // showDialog(
                                  //   context: context,
                                  //   builder: (context) => AlertDialog(
                                  //     title: const Text('Delete'),
                                  //     content: const Text('Do yo want to delete'),
                                  //     actions: <Widget>[
                                  //       TextButton(
                                  //         child: const Text('CANCEL',
                                  //             style:
                                  //                 TextStyle(color: Colors.teal)),
                                  //         onPressed: () {
                                  //           Navigator.of(context).pop();
                                  //         },
                                  //       ),
                                  //       TextButton(
                                  //         child: const Text(
                                  //           'DELETE',
                                  //           style: TextStyle(color: Colors.red),
                                  //         ),
                                  //         onPressed: () async {
                                  //           context
                                  //               .read<GetProfileData>()
                                  //               .deletePost(
                                  //                   uid,
                                  //                   snapshot
                                  //                       .data![index].postId!);
                                  //           Navigator.pop(context);
                                  //         },
                                  //       ),
                                  //     ],
                                  //   ),
                                  // );
                                },
                                onTap: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PostCommentScreen(
                                                  userId: FirebaseAuth.instance
                                                      .currentUser!.uid,
                                                  postId: postSnapshot
                                                      .data![index].postId!,
                                                  name: snapshot.data!.name!)
                                          // PostFullView(
                                          //     index: index.toDouble(),
                                          //     userId: FirebaseAuth
                                          //         .instance.currentUser!.uid),
                                          ));
                                },
                                child: SizedBox(
                                    child: Image.network(
                                        postData[index].imgUrl!,
                                        fit: BoxFit.fill)),
                              );
                            },
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          );
        },
      );
    });
  }
}

class DrawerWidget extends StatelessWidget {
  final String? imgPath;
  final String name;
  const DrawerWidget({required this.imgPath, required this.name, super.key});

  @override
  Widget build(BuildContext context) {
    var sizeQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20.0),
              ),
            ),
            width: double.infinity,
            height: sizeQuery.height * 0.4,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: sizeQuery.height * 0.07),
                imgPath != null
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(imgPath!),
                        radius: sizeQuery.height * 0.076,
                      )
                    : CircleAvatar(
                        backgroundImage: const AssetImage(
                            'assets/images/585e4bf3cb11b227491c339a.png'),
                        radius: sizeQuery.height * 0.076,
                      ),
                SizedBox(height: sizeQuery.height * 0.03),
                Text(name,
                    style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditProfileScreen(),
                          ));
                    },
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    )),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: sizeQuery.height * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Theme',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.toggle_on,
                          size: 38,
                        ))
                  ],
                ),
                SizedBox(height: sizeQuery.height * 0.0001),
                const Text(
                  'Privacy Policy',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: sizeQuery.height * 0.02),
                const Text(
                  'Share App',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: sizeQuery.height * 0.02),
                const Text(
                  'About Us',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: sizeQuery.height * 0.02),
                GestureDetector(
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Do yo want to LogOut'),
                          actions: [
                            ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.teal)),
                                onPressed: () async {
                                  final navigator = Navigator.of(context);
                                  log(FirebaseAuth.instance.currentUser
                                      .toString());
                                  await FirebaseAuth.instance.signOut();
                                  log(FirebaseAuth.instance.currentUser
                                      .toString());
                                  onUserLogout();
                                  navigator.pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen(),
                                      ),
                                      (route) => false);
                                },
                                child: const Text('Yes')),
                            ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.teal)),
                                onPressed: () => Navigator.pop(context),
                                child: const Text('No'))
                          ],
                        );
                      },
                    );
                  },
                  child: const Text(
                    'Log Out',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
