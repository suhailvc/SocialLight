import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:social_light/application/provider/message_provider/get_all_chat_users.dart';
import 'package:social_light/application/provider/message_provider/message_provider.dart';
import 'package:social_light/domain/message_model/message_model.dart';
import 'package:social_light/presentation/screens/chat_screen/chat_screen.dart';
import 'package:social_light/presentation/widgets/shimmer.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool initialLoading = true;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 226, 231, 231),
          title: Text(
            'Messages',
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
              decorationThickness: 2.0,
            ),
          ),
          centerTitle: true,
        ),
        body: //Consumer<GetAllChatUsersProvider>(
            //builder: (context, chatUserValue, child) {
            //return
            FutureBuilder(
                future: GetAllChatUsersProvider().getChatUsersProvider(),
                builder: (context, chatUserSnapshot) {
                  if (chatUserSnapshot.connectionState ==
                          ConnectionState.waiting &&
                      initialLoading) {
                    return const ShimmerLoading(
                        itemCount: 8, containerHeight: 0);
                  }
                  initialLoading = false;
                  if (!chatUserSnapshot.hasData) {
                    return const Center(
                      child: Text('No Message'),
                    );
                  }
                  return ListView.builder(
                    itemCount: chatUserSnapshot.data!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                  otherUserName:
                                      chatUserSnapshot.data![index].username!,
                                  otherUserId:
                                      chatUserSnapshot.data![index].uid!),
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
                          child: FutureBuilder<MessageModel?>(
                              future: MessageProvider().getLastMessageProvider(
                                  chatUserSnapshot.data![index].uid!),
                              builder: (context, lastMessageSnapshot) {
                                if (lastMessageSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (!lastMessageSnapshot.hasData) {
                                  return const Center(
                                      child: Text('No messages'));
                                }
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: const AssetImage(
                                      'assets/images/download (1).jpeg',
                                    ),
                                    radius: 23,
                                    child: ClipOval(
                                      child: chatUserSnapshot
                                                  .data![index].imgpath !=
                                              null
                                          ? Image.network(
                                              chatUserSnapshot
                                                  .data![index].imgpath
                                                  .toString(),
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              "assets/images/585e4bf3cb11b227491c339a.png",
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                  title: Text(
                                    chatUserSnapshot.data![index].name!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  subtitle:
                                      Text(lastMessageSnapshot.data!.message!),
                                  // }),
                                  trailing:
                                      Text(lastMessageSnapshot.data!.sentTime!),
                                );
                              }),
                        ),
                      );
                    },
                  );
                })
        //}//)
        );
  }
}
