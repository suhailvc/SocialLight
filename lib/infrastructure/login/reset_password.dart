import 'package:firebase_auth/firebase_auth.dart';

resetPassword(String email) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  } catch (e) {
    print("reset error $e");
  }
}
