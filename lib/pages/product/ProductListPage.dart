import 'package:flutter/material.dart';

class ProductListPage extends StatefulWidget {
  Map arguments;

  ProductListPage({Key key,this.arguments}):super(key:key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {

  @override
  void initState() {
    super.initState();
    widget.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("商品列表"),),
    );
  }
}
