import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_light/application/provider/add_post.dart/add_post_provider.dart';
import 'package:social_light/application/provider/add_post.dart/get_post_provider.dart';
import 'package:social_light/application/provider/add_post.dart/select_post_img.dart';
import 'package:social_light/application/provider/follow_provider/follow_provider.dart';
import 'package:social_light/application/provider/home_screen_appbar/home_screen_app_bar.dart';
import 'package:social_light/application/provider/image_picker_provider/image_picker.dart';
import 'package:social_light/application/provider/login_provider/login_provider.dart';
import 'package:social_light/application/provider/message_provider/get_all_chat_users.dart';
import 'package:social_light/application/provider/message_provider/message_provider.dart';
import 'package:social_light/application/provider/notification_provider/notification_provider.dart';
import 'package:social_light/application/provider/post_like_provider/post_like_provider.dart';
import 'package:social_light/application/provider/profile_provider/get_profile_data.dart';
import 'package:social_light/application/provider/search_provider/search_provider.dart';
import 'package:social_light/application/provider/signup_provider/signup_provider.dart';
import 'package:social_light/presentation/screens/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppBarProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SignUpProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ImagePickProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LogInProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SelectPostImgProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetProfileDataProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddPostProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SelectPostImgProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetPostProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserSearchProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FollowProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MessageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PostLikeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetAllChatUsersProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NotificationProvider(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        //home: PostFullView(),
        home: SplashScreen(),
      ),
    );
  }
}
