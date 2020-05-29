import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:jdshop/pages/login/RegisterPart2.dart';
import 'package:jdshop/widget/TextRadiusBtnWidget.dart';
import 'package:nav_router/nav_router.dart';
import 'package:regexpattern/regexpattern.dart';

class RegisterPart1 extends StatefulWidget {
  @override
  _RegisterPart1State createState() => _RegisterPart1State();
}

class _RegisterPart1State extends State<RegisterPart1> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("手机快速注册"),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: ScreenUtil().setWidth(30),
          ),
          Container(
              margin: EdgeInsets.only(
                  left: ScreenUtil().setWidth(15),
                  right: ScreenUtil().setWidth(15)),
              child: TextField(
                controller: _controller,
                maxLength: 11,
                maxLines: 1,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixText: "+86",
                  hintText: "手机号",
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54)),
                ),
              )),
          SizedBox(
            height: ScreenUtil().setWidth(50),
          ),
          TextRadiusBtnWidget(
              Colors.red, Colors.white, ScreenUtil().setWidth(20), "下一步", () {
            String phoneNumber = _controller.text;

            if (RegexValidation.hasMatch(
                "+86" + phoneNumber, RegexPattern.phone)) {
              pop();
              routePush(RegisterPart2(phoneNumber));
            } else {
              BotToast.showText(text: "号码格式不正确");
            }
          }),
        ],
      ),
    );
  }
}
