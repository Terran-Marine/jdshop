import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Text(
        "暂无数据",
        textAlign: TextAlign.end,
        style: TextStyle(color: Colors.black54,fontSize: 16),
      ),
    );
  }
}
