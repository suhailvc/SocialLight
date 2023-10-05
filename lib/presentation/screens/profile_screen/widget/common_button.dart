import 'package:flutter/material.dart';

Widget commonButton(
  double size,
  String title,
  String value,
) {
  return Container(
    padding: const EdgeInsets.all(8),
    width: size,
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 10, 126, 114),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}
