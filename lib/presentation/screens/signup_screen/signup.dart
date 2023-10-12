import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_light/application/provider/image_picker_provider/image_picker.dart';
import 'package:social_light/application/provider/signup_provider/signup_provider.dart';
import 'package:social_light/presentation/screens/login_screen/login.dart';
import 'package:social_light/presentation/screens/signup_screen/widget/sign_up_button.dart';

import 'package:social_light/presentation/widgets/custom_text_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
            Provider.of<ImagePickProvider>(context, listen: false).clearImage();
          },
          child: const Icon(
            Icons.arrow_back,
            size: 32,
            color: Color.fromARGB(255, 78, 69, 206),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
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
                  //   String? imgPath = value.imagePath;
                  return Container(
                    width: size.width * 0.3,
                    height: size.height * 0.15,
                    decoration: BoxDecoration(
                      border: Border.all(width: 5, color: Colors.blue),
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: GestureDetector(
                        onTap: () => value.getImage(ImageSource.gallery),
                        child: value.imagePath != null
                            ? ClipOval(
                                child: Container(
                                  width: size.width * 0.4,
                                  height: size.height * 0.15,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: FileImage(
                                          File(value.imagePath!),
                                        )),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              )
                            : ClipOval(
                                child: Container(
                                  width: size.width * 0.3,
                                  height: size.height * 0.15,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      FontAwesomeIcons.userTie,
                                      size: 50,
                                    ),
                                  ),
                                ),
                              ),
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
              const SignUpButton(),
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
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                              (route) => false);
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
      ),
    );
  }
}
