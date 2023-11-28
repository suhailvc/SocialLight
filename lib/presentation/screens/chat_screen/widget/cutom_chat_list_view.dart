import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_light/application/provider/message_provider/message_provider.dart';
import 'package:social_light/presentation/screens/chat_screen/widget/message_delete_dialog.dart';
import 'package:social_light/presentation/widgets/shimmer.dart';

Consumer<MessageProvider> cutomChatListView(String otherUserId,
    bool initialLoading, ScrollController _scrollController, Size size) {
  return Consumer<MessageProvider>(builder: (context, value, child) {
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
          if (chatSnapshot.connectionState == ConnectionState.waiting &&
              initialLoading == true) {
            initialLoading = false;
            return const ShimmerLoading(
              itemCount: 5,
              containerHeight: 0,
            );
          }
          DateTime? previousMessageDate;
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: chatSnapshot.data!.docs.length + 1,
                  itemBuilder: (context, index) {
                    if (index == chatSnapshot.data!.docs.length) {
                      return SizedBox(
                        height: size.height * 0.05,
                      );
                    }
                    DateTime messageDateTime = DateTime.parse(
                        chatSnapshot.data!.docs[index]["sentTime"]);
                    final chatDate =
                        TimeOfDay.fromDateTime(messageDateTime).format(context);
                    bool showDate = previousMessageDate == null ||
                        previousMessageDate!.day != messageDateTime.day ||
                        previousMessageDate!.month != messageDateTime.month ||
                        previousMessageDate!.year != messageDateTime.year;

                    previousMessageDate = messageDateTime;
                    return Column(
                      crossAxisAlignment: chatSnapshot.data!.docs[index]
                                  ["userId"] !=
                              FirebaseAuth.instance.currentUser!.uid
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        if (showDate)
                          Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                "${messageDateTime.day}/${messageDateTime.month}/${messageDateTime.year}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.teal,
                                ),
                              ),
                            ),
                          ),
                        GestureDetector(
                          onLongPress: () {
                            if (chatSnapshot.data!.docs[index]["userId"] ==
                                FirebaseAuth.instance.currentUser!.uid) {
                              deleteMessageDialog(context, otherUserId,
                                  chatSnapshot.data!.docs[index]["sentTime"]);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: chatSnapshot.data!.docs[index]["userId"] !=
                                      FirebaseAuth.instance.currentUser!.uid
                                  ? Colors.teal[300]
                                  : const Color.fromARGB(255, 2, 105, 95),
                              borderRadius: chatSnapshot.data!.docs[index]
                                          ["userId"] !=
                                      FirebaseAuth.instance.currentUser!.uid
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
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            chatDate.toString(),
                            // timeago
                            //     .format(messageDateTime,
                            //         allowFromNow: true)
                            //     .toString(),
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
            ],
          );
        });
  });
}
