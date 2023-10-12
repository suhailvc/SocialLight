import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:social_light/application/provider/login_provider/login_provider.dart';
import 'package:social_light/infrastructure/sign_in/temp.dart';

import 'package:social_light/presentation/screens/signup_screen/signup.dart';
import 'package:social_light/presentation/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60.0),
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 90),
              Text(
                'Social Light',
                style: GoogleFonts.pacifico(fontSize: 30),
              ),
              const SizedBox(height: 6),
              const Text(
                'Log in our account',
                style: TextStyle(
                    fontSize: 15, color: Color.fromARGB(255, 78, 69, 206)),
              ),
              const SizedBox(
                height: 40,
              ),
              CustomTextField(
                dataController: context.read<LogInProvider>().emailController,
                secure: false,
                icon: const Icon(Icons.email),
                hintText: 'Email',
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                dataController:
                    context.read<LogInProvider>().passwordController,
                secure: true,
                icon: const Icon(Icons.lock),
                hintText: 'Password',
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forgot your password?',
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(221, 78, 69, 206)),
                      )),
                ],
              ),
              const SizedBox(height: 19),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(221, 78, 69, 206),
                      minimumSize: const Size(100, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  onPressed: () {
                    Provider.of<LogInProvider>(context, listen: false)
                        .loginUser(context);
                  },
                  child: const Text('Log In')),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Expanded(
                    child: Divider(
                      endIndent: 10,
                      height: 1.4,
                      thickness: 2,
                      color: Color.fromARGB(221, 78, 69, 206),
                    ),
                  ),
                  Text(
                    'Or with',
                    style: TextStyle(
                        fontSize: 16, color: Color.fromARGB(221, 78, 69, 206)),
                  ),
                  Expanded(
                    child: Divider(
                      indent: 10,
                      color: Color.fromARGB(221, 78, 69, 206),
                      height: 1.4,
                      thickness: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  signinWithGoogle(context: context);
                },
                child: Container(
                  width: size.width * 0.7,
                  height: size.height * 0.06,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(221, 78, 69, 206),
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    border: Border.all(
                      color: const Color.fromARGB(221, 78, 69, 206),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'G  ',
                        style: GoogleFonts.roboto(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Login with google',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(children: [
                  const TextSpan(
                      text: "Don't have account? Lets  ",
                      style: TextStyle(color: Colors.black, fontSize: 15)),
                  TextSpan(
                    text: 'Sign Up',
                    style: const TextStyle(
                        color: Color.fromARGB(221, 78, 69, 206), fontSize: 15),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ));
                      },
                  )
                ]),
              )
            ],
          ),
        ),
      )),
    );
  }
}
