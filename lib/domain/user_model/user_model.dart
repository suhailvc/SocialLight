class UserDetails {
  String? name;
  String? username;
  String? email;
  String? password;
  String? imgpath;
  String? uid;

  UserDetails(
      {this.name,
      this.username,
      this.email,
      this.password,
      this.imgpath,
      this.uid});

  UserDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    imgpath = json['imgpath'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    data['password'] = password;
    data['imgpath'] = imgpath;
    data['uid'] = uid;
    return data;
  }
}
