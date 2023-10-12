import 'package:flutter/material.dart';
import 'package:social_light/domain/message_model/message_model.dart';
import 'package:social_light/infrastructure/message/get_last_message.dart';
import 'package:social_light/infrastructure/message/get_message.dart';
import 'package:social_light/infrastructure/message/send_message.dart';

class MessageProvider extends ChangeNotifier {
  // List<MessageModel> messageList = [];
  sendMessageProvider(String toUid, String message) {
    sendMessageFireBase(toUid, message);
    notifyListeners();
  }

  Future<List<MessageModel>> getMessage(String userId) async {
    List<MessageModel> listMessage = await getMessagefirebase(userId);
    notifyListeners();
    return listMessage;
  }

  Future<MessageModel?> getLastMessageProvider(String userId) async {
    MessageModel? lastMessage = await getLastMessage(userId);
    notifyListeners();
    return lastMessage;
  }
}
