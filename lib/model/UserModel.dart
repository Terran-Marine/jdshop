class UserModel {
  bool success;
  String message;
  List<Userinfo> userinfo;

  UserModel({this.success, this.message, this.userinfo});

  UserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['userinfo'] != null) {
      userinfo = new List<Userinfo>();
      json['userinfo'].forEach((v) {
        userinfo.add(new Userinfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.userinfo != null) {
      data['userinfo'] = this.userinfo.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Userinfo {
  String sId;
  String username;
  String tel;
  String salt;

  Userinfo({this.sId, this.username, this.tel, this.salt});

  Userinfo.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    tel = json['tel'];
    salt = json['salt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['tel'] = this.tel;
    data['salt'] = this.salt;
    return data;
  }
}
