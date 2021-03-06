import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JdText extends StatelessWidget {

  final String text;
  final bool password;
  final Object onChanged;
  final int maxLines;
  final double height;
  final TextEditingController controller;

  JdText({Key key,this.text="输入内容",this.password=false,this.onChanged=null,this.maxLines=1,this.height=68,this.controller=null}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller:controller,
        maxLines:this.maxLines ,
        obscureText: this.password,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
            hintText: this.text,
            alignLabelWithHint: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none)),
        onChanged: this.onChanged,
      ),
      height: ScreenUtil().setHeight(this.height),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 1,
                  color: Colors.black12
              )
          )
      ),
    );
  }
}
