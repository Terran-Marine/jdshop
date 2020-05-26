import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdshop/pages/SearchPage.dart';
import 'package:nav_router/nav_router.dart';

AppBar mainAppBarWidget() {
  return AppBar(
    leading: IconButton(
      icon: Icon(Icons.center_focus_weak),
      onPressed: () {},
    ),
    title: InkWell(
      child: Container(
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(10), right: ScreenUtil().setWidth(10)),
        decoration: BoxDecoration(
            color: Color.fromRGBO(233, 233, 233, 0.8),
            borderRadius: BorderRadius.circular(80)),
        height: ScreenUtil().setHeight(76),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.search),
            Text(
              "搜索",
              style: TextStyle(fontSize: ScreenUtil().setSp(20)),
            )
          ],
        ),
      ),
      onTap: () {
        routePush(SearchPage());
      },
    ),
    actions: <Widget>[
      IconButton(
        icon: Icon(
          Icons.message,
          size: 28,
          color: Colors.black,
        ),
        onPressed: () {},
      )
    ],
  );
}