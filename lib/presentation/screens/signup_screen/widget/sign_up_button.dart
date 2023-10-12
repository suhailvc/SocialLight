import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_light/application/provider/image_picker_provider/image_picker.dart';
import 'package:social_light/application/provider/signup_provider/signup_provider.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await Provider.of<SignUpProvider>(context, listen: false).signUpUser(
            context,
            Provider.of<ImagePickProvider>(context, listen: false).imageUrl);
        Timer(
          const Duration(seconds: 3),
          () {
            Provider.of<ImagePickProvider>(context, listen: false).clearImage();
          },
        );
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
