import 'package:flutter/material.dart';
import 'package:social_light/domain/user_model/user_model.dart';
import 'package:social_light/infrastructure/message/get_all_chat_users.dart';

class GetAllChatUsersProvider extends ChangeNotifier {
  Future<List<UserDetails>> getChatUsersProvider() async {
    List<UserDetails> allChatUsers = [];
    allChatUsers = await getMessageUserList();
    notifyListeners();
    return allChatUsers;
  }
}
