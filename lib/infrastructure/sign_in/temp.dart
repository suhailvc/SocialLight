import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_light/presentation/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:social_light/presentation/screens/signup_screen/google_sign-up.dart';
import 'package:social_light/presentation/widgets/warning.dart';

Future<void> signinWithGoogle({required BuildContext context}) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

  if (googleSignInAccount != null) {
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);

    try {
      await auth.signInWithCredential(credential);

      String userId = FirebaseAuth.instance.currentUser!.uid;
      final DocumentSnapshot<Map<String, dynamic>> googleSnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .get();

      if (googleSnapshot.exists) {
        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const BottomNavScreen(
                      count: 0,
                    )));
      } else {
        // ignore: use_build_context_synchronously
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const GoogleUser()));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        // ignore: use_build_context_synchronously
        warning(context, 'account exist with different credential');
      } else if (e.code == 'invalid-credential') {
        // ignore: use_build_context_synchronously
        warning(context, 'invalid credential');
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      warning(context, 'something else');
    }
  } else {
    // ignore: use_build_context_synchronously
    warning(context, 'error');
  }
}
