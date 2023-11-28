import 'package:flutter/material.dart';

class AboutListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Icon icon;
  const AboutListTile(
      {super.key,
      required this.icon,
      required this.subtitle,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(title,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
      subtitle: Text(subtitle,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
    );
  }
}
