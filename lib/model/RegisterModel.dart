class RegisterModel {
  bool success;
  String message;
  List<Serinfo> serinfo;

  RegisterModel({this.success, this.message, this.serinfo});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['serinfo'] != null) {
      serinfo = new List<Serinfo>();
      json['serinfo'].forEach((v) {
        serinfo.add(new Serinfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.serinfo != null) {
      data['serinfo'] = this.serinfo.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Serinfo {
  String sId;
  String username;
  String tel;
  String salt;

  Serinfo({this.sId, this.username, this.tel, this.salt});

  Serinfo.fromJson(Map<String, dynamic> json) {
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
