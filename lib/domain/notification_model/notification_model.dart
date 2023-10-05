class NotificationModel {
  String? id;
  String? toId;
  String? status;
  String? currentUserId;
  String? time;

  NotificationModel(
      {this.id, this.toId, this.status, this.currentUserId, this.time});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    toId = json['fromId'];
    status = json['status'];
    currentUserId = json['currentUserId'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fromId'] = toId;
    data['status'] = status;
    data['currentUserId'] = currentUserId;
    data['time'] = time;
    return data;
  }
}
