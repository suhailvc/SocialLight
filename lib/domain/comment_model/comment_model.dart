class CommentModel {
  String? commentId;
  String? commentedUserId;
  String? comment;
  String? time;

  CommentModel({this.commentId, this.commentedUserId, this.comment, this.time});

  CommentModel.fromJson(Map<String, dynamic> json) {
    commentId = json['commentId'];
    commentedUserId = json['commentedUserId'];
    comment = json['comment'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['commentId'] = commentId;
    data['commentedUserId'] = commentedUserId;
    data['comment'] = comment;
    data['time'] = time;
    return data;
  }
}
