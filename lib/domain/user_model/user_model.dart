class UserDetails {
  String? name;
  String? username;
  String? email;
  String? password;
  String? imgpath;
  String? uid;
  List<String>? followers;
  List<String>? following;
  String? pushToken;

  UserDetails(
      {this.name,
      this.username,
      this.email,
      this.password,
      this.imgpath,
      this.uid,
      this.followers,
      this.following,
      this.pushToken});

  UserDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    imgpath = json['imgpath'];
    uid = json['uid'];
    followers = json['followers'].cast<String>();
    following = json['following'].cast<String>();
    pushToken = json['pushToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    data['password'] = password;
    data['imgpath'] = imgpath;
    data['uid'] = uid;
    data['followers'] = followers;
    data['following'] = following;
    data['pushToken'] = pushToken;
    return data;
  }
}
