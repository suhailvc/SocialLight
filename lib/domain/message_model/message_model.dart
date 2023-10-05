class MessageModel {
  String? userId;
  String? toId;
  String? messageId;
  String? message;
  String? read;
  String? sentTime;

  MessageModel(
      {this.userId,
      this.toId,
      this.messageId,
      this.message,
      this.read,
      this.sentTime});

  MessageModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    toId = json['toId'];
    messageId = json['messageId'];
    message = json['message'];
    read = json['read'];
    sentTime = json['sentTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['toId'] = toId;
    data['messageId'] = messageId;
    data['message'] = message;
    data['read'] = read;
    data['sentTime'] = sentTime;
    return data;
  }
}
