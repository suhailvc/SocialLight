import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_light/application/provider/home_screen_appbar/home_screen_app_bar.dart';
import 'package:social_light/application/provider/image_picker_provider/image_picker.dart';
import 'package:social_light/application/provider/login_provider/login_provider.dart';
import 'package:social_light/application/provider/signup_provider/signup_provider.dart';
import 'package:social_light/presentation/screens/login_screen/login.dart';
import 'package:social_light/presentation/screens/signup_screen/signup.dart';
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
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
