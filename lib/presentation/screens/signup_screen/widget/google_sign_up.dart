import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_light/application/provider/image_picker_provider/image_picker.dart';
import 'package:social_light/application/provider/signup_provider/google_login.dart';
import 'package:social_light/application/provider/signup_provider/signup_provider.dart';
import 'package:social_light/presentation/screens/bottom_nav_bar/bottom_nav_bar.dart';

class GoogleSignUpButton extends StatelessWidget {
  const GoogleSignUpButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await Provider.of<GoogleLoginSignUpProvider>(context, listen: false)
            .googleLoginProvider(
                context,
                Provider.of<ImagePickProvider>(context, listen: false)
                    .imageUrl);
        Timer(
          const Duration(seconds: 3),
          () {
            Provider.of<ImagePickProvider>(context, listen: false).clearImage();
          },
        );
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const BottomNavScreen(count: 0),
            ));
        // print(Provider.of<ImagePickProvider>(context, listen: false)
        //     .imageUrl);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 78, 69, 206),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Provider.of<SignUpProvider>(context).isLoading
          ? const CircularProgressIndicator()
          : const Text(
              'Sign Up',
              style: TextStyle(fontSize: 16),
            ),
    );
  }
}
