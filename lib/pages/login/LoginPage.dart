import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdshop/AppConfig.dart';
import 'package:jdshop/control/UserControl.dart';
import 'package:jdshop/model/UserModel.dart';
import 'package:jdshop/pages/login/RegisterPart1.dart';
import 'package:jdshop/tools/HttpTool.dart';
import 'package:jdshop/tools/SharedPreferencesTool.dart';
import 'package:jdshop/widget/TextRadiusBtnWidget.dart';
import 'package:nav_router/nav_router.dart';
import 'package:regexpattern/regexpattern.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _accController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            pop();
          },
        ),
        actions: <Widget>[
          FlatButton(
            child: Text("客服"),
            onPressed: () {},
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: ScreenUtil().setWidth(250),
            child: Center(
              child: Container(
                color: Colors.white,
                child: Image.network(
                  "https://img10.360buyimg.com/img/jfs/t1/117726/20/7368/88789/5ec3777cE70ffaf64/47d8f5d0310958bd.gif",
                  fit: BoxFit.contain,
                ),
                height: ScreenUtil().setWidth(100),
                width: ScreenUtil().setWidth(140),
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(
                  left: ScreenUtil().setWidth(15),
                  right: ScreenUtil().setWidth(15)),
              child: TextField(
                controller: _accController,
                maxLength: 11,
                maxLines: 1,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "手机号",
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54)),
                ),
              )),
          Container(
              margin: EdgeInsets.only(
                  left: ScreenUtil().setWidth(15),
                  right: ScreenUtil().setWidth(15)),
              child: TextField(
                controller: _pwdController,
                maxLines: 1,
                keyboardType: TextInputType.number,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "请输入密码",
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54)),
                ),
              )),
          SizedBox(
            height: ScreenUtil().setWidth(20),
          ),
          Container(
            margin: EdgeInsets.only(
                left: ScreenUtil().setWidth(15),
                right: ScreenUtil().setWidth(15)),
            child: Row(
              children: <Widget>[
                Text("忘记密码"),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                InkWell(
                  child: Text("新用户注册"),
                  onTap: () {
                    routePush(RegisterPart1());
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: ScreenUtil().setWidth(50),
          ),
          TextRadiusBtnWidget(
              Colors.red, Colors.white, ScreenUtil().setWidth(20), "登陆", () {
            _login();
          }),
        ],
      ),
    );
  }

  void _login() async {
    String acc = _accController.text;
    String pwd = _pwdController.text;

    if (!RegexValidation.hasMatch("+86" + acc, RegexPattern.phone)) {
      BotToast.showText(text: "号码格式不正确");
      return;
    }

    if (pwd.length < 6) {
      BotToast.showText(text: "请输入六位以上密码");
      return;
    }

    Response respons = await dio.post(API_DOLOGIN, data: {
      "username": acc,
      "password": pwd,
    });

    if (respons.statusCode == 200) {
      UserModel userModel = UserModel.fromJson(respons.data);
      if (userModel.success) {
        BotToast.showText(text: userModel.message);

        UserControl.instance.setUserInfo(userModel);

        pop();
      } else {
        BotToast.showText(text: userModel.message);
      }
    }
  }
}
