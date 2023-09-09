import 'package:flutter/material.dart';
import 'package:social_light/presentation/screens/chat_screen/chat_screen.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 226, 231, 231),
          title: const Text('Messages',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ))
          ],
        ),
        body: ListView.builder(
          itemCount: 8,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChatScreen(),
                  )),
              child: Dismissible(
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  child: const Padding(
                    padding: EdgeInsets.all(23.0),
                    child: Text(
                      'Delete',
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
                key: Key(index.toString()),
                child: ListTile(
                  leading: CircleAvatar(
                    //backgroundImage: AssetImage('assets/images/download (1).jpeg',),
                    radius: 24,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/download (1).jpeg',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // ClipOval(
                  //     clipBehavior: Clip.antiAliasWithSaveLayer,
                  //     child: Image.asset(
                  //       'assets/images/download (1).jpeg',
                  //       fit: BoxFit.fill,
                  //     ),
                  //   ),
                  // ),
                  title: const Text(
                    'Suhail',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: const Text('last message'),
                  trailing: const Text('3h'),
                ),
              ),
            );
          },
        ));
  }
}
