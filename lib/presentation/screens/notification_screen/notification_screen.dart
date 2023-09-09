import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 226, 231, 231),
        title: const Text('Notification',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 5),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: CircleAvatar(radius: 30),
                      title: Row(
                        children: [
                          Text(
                            'Username,  ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('started following you'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
