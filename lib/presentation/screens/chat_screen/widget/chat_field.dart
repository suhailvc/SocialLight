import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:social_light/application/provider/message_provider/message_provider.dart';

class ChatField extends StatelessWidget {
  final String toUid;
  const ChatField({required this.toUid, super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();
    // return Column(children: [
    //   Container(
    //     height: 50,
    //     width: MediaQuery.of(context).size.width * .8,
    //     decoration: BoxDecoration(
    //         color: const Color(0xffFFFFFF),
    //         borderRadius: BorderRadius.circular(100)),
    //     child: TextField(
    //       decoration: const InputDecoration(
    //         prefixIcon: Padding(
    //           padding: EdgeInsets.only(left: 4, top: 5),
    //           child: Icon(
    //             Icons.emoji_emotions_outlined,
    //             color: Color(0xff8C8C8C),
    //           ),
    //         ),
    //         border: InputBorder.none,
    //         contentPadding: EdgeInsets.all(12),
    //         hintText: "Send a message",
    //         //   hintStyle: primaryfont()
    //       ),
    //       onSubmitted: (text) {},
    //     ),
    //   ),
    //   const SizedBox(
    //     width: 5,
    //   ),
    //   Container(
    //     height: 50,
    //     width: 50,
    //     decoration: BoxDecoration(
    //         color: const Color(0xff547981),
    //         borderRadius: BorderRadius.circular(100)),
    //     child: const Padding(
    //       padding: EdgeInsets.only(left: 3),
    //       child: Icon(
    //         Icons.send_rounded,
    //         color: Colors.white,
    //       ),
    //     ),
    //   )
    // ]);
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
