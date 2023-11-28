import 'package:flutter/material.dart';
import 'package:social_light/infrastructure/user_registration/google_login_user_registration.dart';

class GoogleLoginSignUpProvider extends ChangeNotifier {
  bool isLoading = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  googleLoginProvider(BuildContext context, String? imagePath) {
    googleUserRegistration(
        context, imagePath, nameController, userNameController);
    notifyListeners();
  }
}
