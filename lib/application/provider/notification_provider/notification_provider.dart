import 'package:flutter/foundation.dart';
import 'package:social_light/domain/notification_model/notification_model.dart';
import 'package:social_light/infrastructure/notification/notification.dart';

class NotificationProvider extends ChangeNotifier {
  addNotificationProvider(String toId, String status) {
    addNotification(toId, status);
    notifyListeners();
  }

  Future<List<NotificationModel>> getNotificationProvider() async {
    List<NotificationModel> notificationList;
    notificationList = await getNotification();
    notifyListeners();
    return notificationList;
  }
}
