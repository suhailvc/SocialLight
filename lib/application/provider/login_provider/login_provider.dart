import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_light/presentation/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:social_light/presentation/widgets/warning.dart';

class LogInProvider extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  loginUser(context) async {
    final String email = emailController.text;
    final String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      warning(context, 'Please fill in all the fields.');
      return;
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      warning(context, 'Please enter a valid email address.');
      return;
    }

    if (password.length < 6 || password.isEmpty) {
      warning(context, 'Password must be at least 6 characters long.');
      return;
    }
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      emailController.clear();
      passwordController.clear();
      notifyListeners();
      if (userCredential.user != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const BottomNavScreen(),
            ),
            (route) => false);
      }
    } catch (error) {
      warning(context, 'Invalid email or password. Please try again.');
    }
  }
}
