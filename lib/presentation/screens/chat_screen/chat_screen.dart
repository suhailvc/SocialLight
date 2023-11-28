import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_light/presentation/screens/chat_screen/widget/call_button.dart';
import 'package:social_light/presentation/screens/chat_screen/widget/cutom_chat_list_view.dart';
import 'package:flutter/material.dart';
import 'package:social_light/application/provider/profile_provider/get_profile_data.dart';
import 'package:social_light/presentation/screens/chat_screen/widget/chat_field.dart';

class ChatScreen extends StatelessWidget {
  final String otherUserId;
  final String otherUserName;
  const ChatScreen(
      {required this.otherUserName, required this.otherUserId, super.key});

  @override
  Widget build(BuildContext context) {
    var docName = FirebaseAuth.instance.currentUser!.uid + otherUserId;
    List<String> charList = docName.split('');
    charList.sort();
    ScrollController scrollController = ScrollController();
    // initialScrollOffset: _scrollController.position.maxScrollExtent);
    bool initialLoading = true;
    var size = MediaQuery.of(context).size;

    return FutureBuilder(
        future: GetProfileDataProvider().getUserData(otherUserId),
        builder: (context, userSnapshot) {
          if (!userSnapshot.hasData) {
            return const SizedBox();
          }
          if (!userSnapshot.hasData) {
            return const Center(
              child: Text(
                'no data',
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 20,
                    decoration: TextDecoration.none,
                    color: Colors.black),
              ),
            );
          }

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
              title: Text(userSnapshot.data!.name!,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              centerTitle: true,
              actions: [
                actionButton(true, otherUserId, otherUserName,
                    Size(size.height * 0.05, size.height * 0.07)),
                const SizedBox(
                  width: 20,
                ),
                actionButton(false, otherUserId, otherUserName,
                    Size(size.height * 0.05, size.height * 0.07)),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
            body: cutomChatListView(
                otherUserId, initialLoading, scrollController, size),
            bottomSheet: Padding(
                padding: const EdgeInsets.all(10),
                child: ChatField(
                  scrollScontroller: scrollController,
                  toUid: otherUserId,
                )),
          );
        });
  }
}
