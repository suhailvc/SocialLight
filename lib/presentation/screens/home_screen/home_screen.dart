import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:social_light/application/provider/home_screen_appbar/home_screen_app_bar.dart';
import 'package:social_light/presentation/screens/notification_screen/notification_screen.dart';
import 'package:social_light/presentation/screens/post_comment_screen/post_comment_screen.dart';
import 'package:social_light/presentation/screens/profile_screen/user_profile_screen.dart';

ScrollDirection direction = ScrollDirection.reverse;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //var size = MediaQuery.of(context).size;
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
              NotificationListener<UserScrollNotification>(
                onNotification: (notification) {
                  direction = notification.direction;
                  value.scrollDirectioProvider();
                  return true;
                },
                child: Expanded(
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const PostImage();
                    },
                  ),
                ),
              )
            ],
          ));
        }));
  }
}

class PostImage extends StatelessWidget {
  const PostImage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserProfileScreen(),
                ));
          },
          child: const ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.amber,
              backgroundImage: AssetImage('assets/images/download (1).jpeg'),
            ),
            title: Text(
              'Namee',
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
            ),
            subtitle: Text('time'),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PostCommentScreen(),
                ));
          },
          child: Container(
            width: double.infinity,
            height: 300,
            decoration: const BoxDecoration(
              color: Colors.amber,
            ),
            child: Image.asset(
              'assets/images/download (2).jpeg',
              fit: BoxFit
                  .fill, // I thought this would fill up my Container but it doesn't
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: size.width * 0.05),
            const Icon(FontAwesomeIcons.heart),
            SizedBox(width: size.width * 0.05),
            const Icon(FontAwesomeIcons.comment),
            SizedBox(width: size.width * 0.05),
            const Icon(FontAwesomeIcons.shareFromSquare)
          ],
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}
