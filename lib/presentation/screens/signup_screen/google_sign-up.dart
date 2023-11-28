import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';
import 'package:social_light/application/provider/image_picker_provider/image_picker.dart';
import 'package:social_light/application/provider/signup_provider/google_login.dart';
import 'package:social_light/presentation/screens/signup_screen/widget/google_sign_up.dart';
//import 'package:social_light/presentation/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:social_light/presentation/screens/signup_screen/widget/sign_up_button.dart';
import 'package:social_light/presentation/widgets/custom_text_field.dart';

class GoogleUser extends StatelessWidget {
  const GoogleUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ))
                  // ico(
                  //   size: size,
                  //   backFunction: () => Navigator.pop(context),
                  // ),
                  ),
            ],
          ),
          SizedBox(height: size.height * 0.01),
          //  const AppLogo(size: 50, color: Colors.white),
          const Text(
            'Add your Details',
            style: TextStyle(
                color: Color.fromARGB(221, 78, 69, 206), fontSize: 20),
          ),
          SizedBox(height: size.height * 0.05),
          Consumer<ImagePickProvider>(
            builder: (context, value, child) {
              //   String? imgPath = value.imagePath;
              return Container(
                width: size.width * 0.3,
                height: size.height * 0.15,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 5, color: const Color.fromARGB(221, 78, 69, 206)),
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

          SizedBox(height: size.height * 0.05),

          CustomTextField(
            dataController:
                Provider.of<GoogleLoginSignUpProvider>(context, listen: false)
                    .nameController,
            secure: false,
            icon: const Icon(Icons.person),
            hintText: 'name',
          ),

          SizedBox(height: size.height * 0.029),
          CustomTextField(
            dataController:
                Provider.of<GoogleLoginSignUpProvider>(context, listen: false)
                    .userNameController,
            secure: false,
            icon: const Icon(Icons.person),
            hintText: 'User name',
          ),
          SizedBox(height: size.height * 0.029),

          const GoogleSignUpButton(),
          // RoundedTealTextFormField(
          //     controller: Provider.of<SignUpProvider>(context)
          //         .usernameController,
          //     labelText: 'username'),
          // SizedBox(height: size.height * 001),
          // //  SpaceWithHeight(size: size),
          // TealLoginButton(
          //     onPressed: () async {
          //       Provider.of<SignUpProvider>(context, listen: false)
          //           .signUpUser(
          //               context, imagepic.imageUrl.toString());

          //       Navigator.pushAndRemoveUntil(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) =>
          //                 const BottomNavScreen(count: 0),
          //           ),
          //           (route) => false);
          //     },
          //     text: 'Add',
          //     isLoading:
          //         Provider.of<GoogleInProvider>(context).isLoading),
        ],
      ),
    )));
  }
}
