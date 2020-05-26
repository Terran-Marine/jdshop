import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdshop/provider/Counter.dart';
import 'package:jdshop/tools/LoggerTool.dart';
import 'package:jdshop/widget/ShoppingItemWidget.dart';
import 'package:jdshop/widget/TextRadiusBtnWidget.dart';
import 'package:provider/provider.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  bool _allSelectFlag = false;

  @override
  Widget build(BuildContext context) {
    Counter counter = context.watch<Counter>();
    return Scaffold(
      appBar: AppBar(
        title: Text("我的购物车"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              logger.info("分享");
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(color: Colors.black12,child: ListView.builder(
              itemBuilder: (context, index) {
                return shoppingCartWidget();
              },
              itemCount: 10,
            ),),
          ),
          Divider(
            height: 1,
          ),
          Container(
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Checkbox(
                  activeColor: Colors.redAccent,
                  value: _allSelectFlag,
                  checkColor: Colors.white,
                  onChanged: (bool b) {
                    setState(() {
                      _allSelectFlag = b;
                    });
                  },
                ),
                Text("全选"),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                TextRadiusBtnWidget(
                  Colors.redAccent,
                  Colors.white,
                  ScreenUtil().setWidth(10.0),
                  "结算",
                  () {},
                  height: ScreenUtil().setHeight(60),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
