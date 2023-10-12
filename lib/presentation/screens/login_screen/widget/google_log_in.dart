// import 'dart:developer';
// import 'dart:io';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// //login screen -- implements google sign in or sign up feature for app
// class GoogleLogIn extends StatefulWidget {
//   const GoogleLogIn({super.key});

//   @override
//   State<GoogleLogIn> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<GoogleLogIn> {
//   bool _isAnimate = false;

//   @override
//   void initState() {
//     super.initState();

//     //for auto triggering animation
//     Future.delayed(const Duration(milliseconds: 500), () {
//       setState(() => _isAnimate = true);
//     });
//   }

//   //sign out function
//   // _signOut() async {
//   //   await FirebaseAuth.instance.signOut();
//   //   await GoogleLogIn().signOut();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     //initializing media query (for getting device screen size)
//     var mq = MediaQuery.of(context).size;

//     return Scaffold(
//       //app bar
//       // appBar: AppBar(
//       //   automaticallyImplyLeading: false,
//       //   title: const Text('Welcome to We Chat'),
//       // ),

//       //body
//       body: Stack(children: [
//         //app logo
//         AnimatedPositioned(
//             top: mq.height * .15,
//             right: _isAnimate ? mq.width * .25 : -mq.width * .5,
//             width: mq.width * .5,
//             duration: const Duration(seconds: 1),
//             child: Image.asset('images/icon.png')),

//         //google login button
//         Positioned(
//             bottom: mq.height * .15,
//             left: mq.width * .05,
//             width: mq.width * .9,
//             height: mq.height * .06,
//             child: ElevatedButton.icon(
//                 style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color.fromARGB(255, 223, 255, 187),
//                     shape: const StadiumBorder(),
//                     elevation: 1),
//                 onPressed: () {},

//                 //google icon
//                 icon: Image.asset('assets/images/google.png',
//                     height: mq.height * .03),

//                 //login with google label
//                 label: RichText(
//                   text: const TextSpan(
//                       style: TextStyle(color: Colors.black, fontSize: 16),
//                       children: [
//                         TextSpan(text: 'Login with '),
//                         TextSpan(
//                             text: 'Google',
//                             style: TextStyle(fontWeight: FontWeight.w500)),
//                       ]),
//                 ))),
//       ]),
//     );
//   }
// }
