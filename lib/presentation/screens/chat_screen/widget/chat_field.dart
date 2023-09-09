import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatField extends StatelessWidget {
  const ChatField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 1,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        fillColor: Colors.white,
        hintText: 'Message...',
        suffixIcon: InkWell(
          onTap: () {},
          child: const Icon(FontAwesomeIcons.paperPlane),
        ),
      ),
    );
  }
}
