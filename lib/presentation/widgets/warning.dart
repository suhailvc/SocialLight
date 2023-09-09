import 'package:flutter/material.dart';

warning(BuildContext context, String warning) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    // backgroundColor: Colors.red.withOpacity(0.7),
    shape: const StadiumBorder(),
    //elevation: 10,
    content: Text(warning),
  ));
}
