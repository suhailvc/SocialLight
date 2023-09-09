import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_light/presentation/screens/chat_screen/widget/chat_field.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 226, 231, 231),
        title: const Text('Name',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                FontAwesomeIcons.phone,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                FontAwesomeIcons.video,
                color: Colors.black,
              ))
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.02,
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: index % 2 == 0
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.teal[300],
                        borderRadius: index % 2 == 0
                            ? const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              )
                            : const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                      ),
                      child: const Text(
                        'hello',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        '3:00 pm',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) =>
                  SizedBox(height: size.height * 0.02),
            ),
          )
        ],
      ),
      bottomSheet: const Padding(padding: EdgeInsets.all(10), child: ChatField()),
    );
  }
}
