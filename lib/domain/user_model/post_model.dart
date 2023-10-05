class PostModel {
  String? caption;
  String? imgUrl;
  String? time;
  String? userId;
  String? postId;
  List<String>? like;

  PostModel(
      {this.caption,
      this.imgUrl,
      this.time,
      this.userId,
      this.postId,
      this.like});

  PostModel.fromJson(Map<String, dynamic> json) {
    caption = json['caption'];
    imgUrl = json['imgUrl'];
    time = json['time'];
    userId = json['userId'];
    postId = json['postId'];
    like = json['like'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['caption'] = caption;
    data['imgUrl'] = imgUrl;
    data['time'] = time;
    data['userId'] = userId;
    data['postId'] = postId;
    data['like'] = like;
    return data;
  }
}
