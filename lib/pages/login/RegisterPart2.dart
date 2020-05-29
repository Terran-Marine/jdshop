import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:jdshop/AppConfig.dart';
import 'package:jdshop/model/VCodeModel.dart';
import 'package:jdshop/pages/login/RegisterPart3.dart';
import 'package:jdshop/tools/HttpTool.dart';
import 'package:jdshop/tools/LoggerTool.dart';
import 'package:jdshop/widget/GetVCodeBtnWidget.dart';
import 'package:jdshop/widget/TextRadiusBtnWidget.dart';
import 'package:nav_router/nav_router.dart';

class RegisterPart2 extends StatefulWidget {
  final String phoneNumber;

  RegisterPart2(this.phoneNumber);

  @override
  _RegisterPart2State createState() => _RegisterPart2State();
}

class _RegisterPart2State extends State<RegisterPart2> {
  final TextEditingController _controller = TextEditingController();

  String _vCode;

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
              "请输入${widget.phoneNumber}收到的验证码",
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
                      inputFormatters: [LengthLimitingTextInputFormatter(4)],
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        hintText: "验证码",
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54)),
                      ),
                    )),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  height: ScreenUtil().setWidth(40),
                  child: GetVCodeBtnWidget(
                    countdown: 60,
                    onTapCallback: () {
                      _sendCode();
                    },
                    available: true,
                    height: ScreenUtil().setWidth(40),
                  ),
                ),
              ),
              SizedBox(
                width: ScreenUtil().setWidth(ScreenUtil().setWidth(15)),
              )
            ],
          ),
          SizedBox(
            height: ScreenUtil().setWidth(50),
          ),
          TextRadiusBtnWidget(
              Colors.red, Colors.white, ScreenUtil().setWidth(20), "下一步", () {
            String vCode = _controller.text;

            if (vCode.length == 4) {
              if (vCode == _vCode) {
                pop();
                routePush(RegisterPart3(widget.phoneNumber, vCode));
              } else {
                BotToast.showText(text: "请输入正确验证码");
              }
            } else {
              BotToast.showText(text: "请输入4位验证码");
            }
          }),
        ],
      ),
    );
  }

  void _sendCode() async {
    Response respons =
        await dio.post(API_SENDCODE, data: {"tel": widget.phoneNumber});

    if (respons.statusCode == 200) {
      VCodeModel vCode = VCodeModel.fromJson(respons.data);

      if (vCode.success) {
        _vCode = vCode.code;
        BotToast.showText(text: vCode.message + vCode.code);
        logger.info("验证码:${_vCode}");
      } else {
        BotToast.showText(text: vCode.message);
      }
    }
  }
}
