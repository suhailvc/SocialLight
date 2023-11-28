import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:social_light/application/provider/message_provider/message_provider.dart';

class ChatField extends StatelessWidget {
  final ScrollController scrollScontroller;
  final String toUid;
  const ChatField(
      {required this.toUid, required this.scrollScontroller, super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();

    return TextField(
      controller: messageController,
      maxLines: 1,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        fillColor: Colors.white,
        hintText: 'Message...',
        suffixIcon: InkWell(
          onTap: () {
            scrollScontroller.animateTo(
                scrollScontroller.position.maxScrollExtent,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeOut);
            if (messageController.text.isNotEmpty) {
              Provider.of<MessageProvider>(context, listen: false)
                  .sendMessageProvider(toUid, messageController.text);
              messageController.text = '';
            }
          },
          child: const Icon(FontAwesomeIcons.paperPlane),
        ),
      ),
    );
  }
}
