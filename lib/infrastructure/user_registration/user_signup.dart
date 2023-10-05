import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_light/infrastructure/user_login/user_login.dart';

signUp(String emailAddress, String password) async {
  try {
    credential1 = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      log('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      log('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}
