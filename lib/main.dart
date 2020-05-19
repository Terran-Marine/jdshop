import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jdshop/tools/HttpTool.dart';
import 'AppConfig.dart';
import 'pages/Tabs.dart';
import 'package:jdshop/routers/router.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    _initHttpDio();
  }

  void _initHttpDio() {
    dio.options.receiveTimeout=RECEIVE_TIMEOUT;//接收数据的最长时限
    dio.options.baseUrl=BASE_URL;//请求基地址,可以包含子路径，如: "https://www.google.com/api/".
    dio.interceptors.add(LogInterceptor(responseBody: true)); //开启请求日志
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: onGenerateRoute,
    );
  }
}
