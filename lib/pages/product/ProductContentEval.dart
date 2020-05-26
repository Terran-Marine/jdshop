import 'package:flutter/material.dart';

class ProductContentEval extends StatefulWidget {
  @override
  _ProductContentEvalState createState() => _ProductContentEvalState();
}

class _ProductContentEvalState extends State<ProductContentEval> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("评价页"),);
  }

  @override
  bool get wantKeepAlive => true;
}
