import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_light/presentation/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:social_light/presentation/screens/login_screen/login.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:social_light/presentation/widgets/warning.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    wait(context);
    return Container(
      color: Colors.teal,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Social Light',
            style: GoogleFonts.pacifico(
              fontSize: 30,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}

wait(context) async {
  var connectivityResult = await Connectivity().checkConnectivity();
  await Future.delayed(const Duration(milliseconds: 3700));
  if (connectivityResult == ConnectivityResult.none) {
    warning(context, 'No Internet Connection');
  }
  Navigator.pushReplacement(context, MaterialPageRoute(
    builder: (context) {
      return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return const BottomNavScreen(count: 0,);
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.amber,
              ),
            );
          }
          return const LoginScreen();
        },
      );
    },
  ));
  // FirebaseAuth.instance.currentUser?.uid == null
  //     ? Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => const LoginScreen()))
  //     : Navigator.pushReplacement(context,
  //         MaterialPageRoute(builder: (context) => const BottomNavScreen()));
}
