import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Icon icon;
  final String? hintText;
  final String? labelText;
  final bool secure;
  final TextEditingController? dataController;
  const CustomTextField(
      {required this.secure,
      required this.icon,
      this.dataController,
      this.hintText,
      this.labelText,
      super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.7,
      height: size.height * 0.076,
      decoration: BoxDecoration(
          border: Border.all(
              color: const Color.fromARGB(221, 78, 69, 206), width: 1.9),
          borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        controller: dataController,
        obscureText: secure,
        decoration: InputDecoration(
            prefixIcon: icon,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: const TextStyle(
                fontSize: 16, color: Color.fromARGB(221, 78, 69, 206)),
            labelText: labelText),
      ),
    );
  }
}
