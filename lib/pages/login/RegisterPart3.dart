import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:jdshop/AppConfig.dart';
import 'package:jdshop/model/RegisterModel.dart';
import 'package:jdshop/tools/HttpTool.dart';
import 'package:jdshop/widget/TextRadiusBtnWidget.dart';
import 'package:nav_router/nav_router.dart';

import 'RegisterPart2.dart';

class RegisterPart3 extends StatefulWidget {
  final String phoneNumber;
  final String vCode;

  RegisterPart3(this.phoneNumber, this.vCode);

  @override
  _RegisterPart3State createState() => _RegisterPart3State();
}

class _RegisterPart3State extends State<RegisterPart3> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("手机快速注册"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: ScreenUtil().setWidth(30),
          ),
          Container(
            margin: EdgeInsets.only(
                left: ScreenUtil().setWidth(15),
                right: ScreenUtil().setWidth(15)),
            child: Text(
              "请设置6-20位密码",
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setWidth(30),
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Container(
                    alignment: Alignment.center,
                    height: ScreenUtil().setWidth(40),
                    margin: EdgeInsets.only(
                        left: ScreenUtil().setWidth(15),
                        right: ScreenUtil().setWidth(15)),
                    child: TextField(
                      textAlign: TextAlign.center,
                      style: TextStyle(textBaseline: TextBaseline.alphabetic),
                      controller: _controller,
                      inputFormatters: [LengthLimitingTextInputFormatter(20)],
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        hintText: "设置密码",
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54)),
                      ),
                    )),
              ),
            ],
          ),
          SizedBox(
            height: ScreenUtil().setWidth(50),
          ),
          TextRadiusBtnWidget(
              Colors.red, Colors.white, ScreenUtil().setWidth(20), "下一步", () {
            String pwd = _controller.text;

            if (pwd.length >= 6) {
              _register(pwd);
            } else {
              BotToast.showText(text: "请输入6位验证码");
            }
          }),
        ],
      ),
    );
  }

  _register(String pwd) async {
    Response respons = await dio.post(API_REGISTER, data: {
      "tel": widget.phoneNumber,
      "password": pwd,
      "code": widget.vCode
    });

    if (respons.statusCode == 200) {
      RegisterModel model = RegisterModel.fromJson(respons.data);

      BotToast.showText(text: model.message);
      pop();
    }
  }
}
