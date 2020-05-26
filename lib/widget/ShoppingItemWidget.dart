import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget shoppingCartWidget() {
  return Card(
    child: Container(
      height: ScreenUtil().setWidth(100),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Checkbox(
            activeColor: Colors.redAccent,
            value: true,
            checkColor: Colors.white,
            onChanged: (bool b) {},
          ),
          SizedBox(
            width: ScreenUtil().setWidth(15),
          ),
          Container(
            height: ScreenUtil().setWidth(80),
            width: ScreenUtil().setWidth(80),
            child: Image.network(
              "https://oimagea8.ydstatic.com/image?id=-5411507685289819532&product=adpublish&w=520&h=347",
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(15),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Row(
                    children: <Widget>[Text("标题标题")],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: <Widget>[Text("内容内容")],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
