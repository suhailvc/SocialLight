import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:social_light/presentation/screens/home_screen/home_screen.dart';

bool visibleAppBar = true;

class AppBarProvider extends ChangeNotifier {
  scrollDirectioProvider() {
    if (direction == ScrollDirection.forward) {
      visibleAppBar = true;
    } else if (direction == ScrollDirection.reverse) {
      visibleAppBar = false;
    }
    notifyListeners();
  }
}
