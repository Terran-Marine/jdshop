import 'package:flutter/material.dart';
import 'package:jdshop/provider/Counter.dart';
import 'package:provider/provider.dart';



class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    Counter counter  = context.watch<Counter>();


    return Container(
      child: Center(
        child: Text("用户页面 ${counter.count}"),
      ),
    );
  }
}
