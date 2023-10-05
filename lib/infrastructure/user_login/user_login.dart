import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

var credential1;
logIn(String emailAddress, String password) async {
  try {
    credential1 = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: emailAddress, password: password);
    log('success');
    log(credential1.toString());
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      log('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      log('Wrong password provided for that user.');
    }
  }
}
