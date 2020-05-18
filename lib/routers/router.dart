import 'package:flutter/material.dart';
import 'package:jdshop/pages/Tabs.dart';
import 'package:jdshop/pages/Search.dart';

//配置路由
final routes = {
  '/': (context) => Tabs(),
  '/search': (context) => SearchPage(),
};

//固定写法
var onGenerateRoute = (settings) {
// 统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
