import 'package:flutter/material.dart';
import 'package:social_light/infrastructure/login/reset_password.dart';
import 'package:social_light/presentation/widgets/custom_text_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 22),
            child: Text(
              "Enter your Email and we will send you a password reset link",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            dataController: emailController,
            secure: false,
            icon: const Icon(Icons.email),
            hintText: 'Email',
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(221, 78, 69, 206),
                  minimumSize: const Size(100, 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
              onPressed: () async {
                await resetPassword(emailController.text.trim());
                emailController.text = '';
              },
              child: const Text("Reset Password"))
        ],
      ),
    );
  }
}
