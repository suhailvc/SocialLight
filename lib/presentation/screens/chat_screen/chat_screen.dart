import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:social_light/application/provider/message_provider/message_provider.dart';
import 'package:social_light/application/provider/profile_provider/get_profile_data.dart';
import 'package:social_light/presentation/screens/chat_screen/widget/chat_field.dart';
import 'package:social_light/presentation/widgets/shimmer.dart';

class ChatScreen extends StatelessWidget {
  final String otherUserId;
  const ChatScreen({required this.otherUserId, super.key});

  @override
  Widget build(BuildContext context) {
    bool initialLoading = true;
    var size = MediaQuery.of(context).size;

    return FutureBuilder(
        future: GetProfileDataProvider().getUserData(otherUserId),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting &&
              initialLoading) {
            return const ShimmerLoading(itemCount: 8, containerHeight: 0);
          }
          initialLoading = false;
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
            body: Consumer<MessageProvider>(builder: (context, value, child) {
              String currentUId = FirebaseAuth.instance.currentUser!.uid;
              String combineId = otherUserId + currentUId;
              var sortId = combineId.split('');
              sortId.sort();
              String uniqueId = sortId.join();
              return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("message")
                      .doc(uniqueId)
                      .collection("chat")
                      .snapshots(),
                  builder: (context, chatSnapshot) {
                    if (chatSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const ShimmerLoading(
                          itemCount: 5, containerHeight: 0);
                    }
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            itemCount: chatSnapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              DateTime messageDateTime = DateTime.parse(
                                  chatSnapshot.data!.docs[index]["sentTime"]);
                              return Column(
                                crossAxisAlignment: chatSnapshot
                                            .data!.docs[index]["userId"] !=
                                        FirebaseAuth.instance.currentUser!.uid
                                    ? CrossAxisAlignment.start
                                    : CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.teal[300],
                                      borderRadius: chatSnapshot.data!
                                                  .docs[index]["userId"] !=
                                              FirebaseAuth
                                                  .instance.currentUser!.uid
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
                                    child: Text(
                                      chatSnapshot.data!.docs[index]["message"],
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(
                                      timeago
                                          .format(messageDateTime,
                                              allowFromNow: true)
                                          .toString(),
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (context, index) =>
                                SizedBox(height: size.height * 0.02),
                          ),
                        ),
                        SizedBox(height: size.height * 0.1),
                        //ChatField(toUid: otherUserId)
                      ],
                    );
                  });
            }),
            bottomSheet: Padding(
                padding: const EdgeInsets.all(10),
                child: ChatField(
                  toUid: otherUserId,
                )),
          );
        });
  }
}
