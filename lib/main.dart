import 'package:flutter/material.dart';
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


  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: onGenerateRoute,
    );
  }
}
