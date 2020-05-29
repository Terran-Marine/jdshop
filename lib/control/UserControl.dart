import 'package:jdshop/model/UserModel.dart';
import 'package:jdshop/tools/SharedPreferencesTool.dart';

class UserControl {
  factory UserControl() => _getInstance();

  static UserControl get instance => _getInstance();
  static UserControl _instance;

  UserControl._internal() {
    // 初始化
  }

  static UserControl _getInstance() {
    if (_instance == null) {
      _instance = new UserControl._internal();
    }
    return _instance;
  }

  bool isLogin() {
    String userId = SharedPreferencesTool.getInstance().getString(USER_ID);
    return !(userId == null || userId.isEmpty);
  }

  Userinfo getUserInfo() {
    if (isLogin()) {
      Userinfo userinfo = new Userinfo();
      userinfo.sId = SharedPreferencesTool.getInstance().getString(USER_ID);
      userinfo.username =
          SharedPreferencesTool.getInstance().getString(USER_NAME);
      userinfo.tel = SharedPreferencesTool.getInstance().getString(USER_TEL);
      userinfo.salt = SharedPreferencesTool.getInstance().getString(USER_SALT);
      return userinfo;
    } else {
      return null;
    }
  }

  void setUserInfo(UserModel userModel) {
    SharedPreferencesTool.getInstance()
        .setString(USER_ID, userModel.userinfo[0].sId);
    SharedPreferencesTool.getInstance()
        .setString(USER_NAME, userModel.userinfo[0].username);
    SharedPreferencesTool.getInstance()
        .setString(USER_TEL, userModel.userinfo[0].tel);
    SharedPreferencesTool.getInstance()
        .setString(USER_SALT, userModel.userinfo[0].salt);
  }


 void cleanUserInfo(){
   SharedPreferencesTool.getInstance().remove(USER_ID);
  }
}
