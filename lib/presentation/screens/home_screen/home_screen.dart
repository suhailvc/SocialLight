import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:social_light/application/provider/add_post.dart/get_post_provider.dart';
import 'package:social_light/application/provider/home_screen_appbar/home_screen_app_bar.dart';
import 'package:social_light/domain/user_model/post_model.dart';
import 'package:social_light/infrastructure/push_notification/push_notification.dart';
import 'package:social_light/presentation/screens/chat_screen/widget/on_user_login.dart';
import 'package:social_light/presentation/screens/home_screen/widget/post_image.dart';
import 'package:social_light/presentation/screens/notification_screen/notification_screen.dart';
import 'package:social_light/presentation/widgets/shimmer.dart';
import 'package:social_light/presentation/widgets/single_widget_shimmer.dart';
// import 'package:social_light/presentation/widgets/shimmer.dart';

ScrollDirection direction = ScrollDirection.reverse;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onUserLogin();
    saveToken();
  }

  @override
  Widget build(BuildContext context) {
    bool initialLoading = true;
    var sizeQuery = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<AppBarProvider>(builder: (context, value, child) {
          return SafeArea(
              child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              AnimatedOpacity(
                opacity: visibleAppBar ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 600),
                child: Visibility(
                  visible: visibleAppBar,
                  child: SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SizedBox(
                          width: 40,
                        ),
                        Text(
                          'Social Light',
                          style: GoogleFonts.pacifico(fontSize: 30),
                        ),
                        IconButton(
                            onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const NotificationScreen())),
                            icon: const Icon(
                              Icons.notifications_none_outlined,
                              size: 30,
                            ))
                      ],
                    ),
                  ),
                ),
              ),
              FutureBuilder<List<PostModel>>(
                  future: GetPostProvider().getPost(),
                  builder: (context, postSnapshot) {
                    if (postSnapshot.connectionState ==
                            ConnectionState.waiting &&
                        initialLoading) {
                      return Expanded(
                        child: ShimmerLoading(
                          containerHeight: sizeQuery.height * 0.2,
                          itemCount: 3,
                        ),
                      );
                    }
                    initialLoading = false;
                    if (postSnapshot.connectionState == ConnectionState.none) {
                      return const Center(child: Text('connect to internet'));
                    }

                    if (postSnapshot.hasError) {
                      return Text('Error: ${postSnapshot.error}');
                    } else if (!postSnapshot.hasData ||
                        postSnapshot.data!.isEmpty) {
                      return const Center(
                        child: Text('No data'),
                      );
                    }

                    return NotificationListener<UserScrollNotification>(
                        onNotification: (notification) {
                          direction = notification.direction;
                          value.scrollDirectioProvider();
                          return true;
                        },
                        child: Expanded(
                          child: RefreshIndicator(
                            onRefresh: () => Provider.of<GetPostProvider>(
                                    context,
                                    listen: false)
                                .getPost(),
                            child: ListView.builder(
                              itemCount: postSnapshot.data!.length,
                              itemBuilder: (context, index) {
                                return PostImage(
                                  postId: postSnapshot.data![index].postId!,
                                  descContent:
                                      postSnapshot.data![index].caption,
                                  time: postSnapshot.data![index].time!,
                                  userId: postSnapshot.data![index].userId!,
                                  postImage: postSnapshot.data![index].imgUrl!,
                                );
                              },
                            ),
                          ),
                        ));
                  }),
            ],
          ));
        }));
  }
}
