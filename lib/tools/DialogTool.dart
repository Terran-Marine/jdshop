import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:flutter/material.dart';


YYDialog ConfirmCancelDialog(BuildContext context,String msg,Function confirm,Function cancel) {
  return YYDialog().build(context)
    ..width = 220
    ..borderRadius = 4.0
    ..text(
      padding: EdgeInsets.all(25.0),
      alignment: Alignment.center,
      text:msg,
      color: Colors.black,
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
    )
    ..divider()
    ..doubleButton(
      padding: EdgeInsets.only(top: 10.0),
      gravity: Gravity.center,
      withDivider: true,
      text1: "取消",
      color1: Colors.grey,
      fontSize1: 14.0,
      fontWeight1: FontWeight.bold,
      onTap1: () {
        cancel();
      },
      text2: "确定",
      color2: Colors.blue,
      fontSize2: 14.0,
      fontWeight2: FontWeight.bold,
      onTap2: () {
        confirm();
      },
    )
    ..show();
}