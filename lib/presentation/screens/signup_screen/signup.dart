import 'dart:async';
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_light/application/provider/image_picker_provider/image_picker.dart';
import 'package:social_light/application/provider/signup_provider/signup_provider.dart';

import 'package:social_light/presentation/widgets/custom_text_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back,
            size: 32,
            color: Color.fromARGB(255, 78, 69, 206),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign Up for Social Light',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Consumer<ImagePickProvider>(
              builder: (context, value, child) {
                return GestureDetector(
                  onTap: () {
                    value.getImage(ImageSource.gallery);
                  },
                  child: ClipOval(
                    child: Container(
                      width: size.width * 0.3,
                      height: size.height * 0.15,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: value.imagePath != null
                                  ? FileImage(File(value.imagePath!))
                                  : const AssetImage(
                                          'assets/images/download (1).jpeg')
                                      as ImageProvider),
                          //color: Colors.black,
                          border: Border.all(
                              width: 3,
                              color: const Color.fromARGB(255, 78, 69, 206)),
                          shape: BoxShape.circle),
                    ),
                  ),
                );
              },
            ),
            Column(
              children: [
                const SizedBox(height: 15),
                CustomTextField(
                  dataController:
                      Provider.of<SignUpProvider>(context).nameController,
                  secure: false,
                  icon: const Icon(Icons.person),
                  hintText: 'Full name',
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  dataController:
                      Provider.of<SignUpProvider>(context).userNameController,
                  secure: false,
                  icon: const Icon(Icons.person),
                  hintText: 'User name',
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  dataController:
                      Provider.of<SignUpProvider>(context).emailController,
                  secure: false,
                  icon: const Icon(Icons.email),
                  hintText: 'email',
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  dataController:
                      Provider.of<SignUpProvider>(context).passwordController,
                  secure: true,
                  icon: const Icon(Icons.lock),
                  hintText: 'Password',
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                await Provider.of<SignUpProvider>(context, listen: false)
                    .signUpUser(
                        context,
                        Provider.of<ImagePickProvider>(context, listen: false)
                                .imageUrl ??
                            'no image');
                Timer(const Duration(seconds: 3), () {
                  Provider.of<ImagePickProvider>(context, listen: false)
                      .clearImage();
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 78, 69, 206),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Sign Up',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                    text: TextSpan(children: [
                  const TextSpan(
                    text: 'Already have an account? ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pop(context);
                      },
                    text: ' Log in',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 78, 69, 206),
                      fontSize: 15,
                    ),
                  )
                ])),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
