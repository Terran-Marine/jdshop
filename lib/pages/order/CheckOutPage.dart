import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdshop/model/ProductDescModel.dart';
import 'package:jdshop/tools/LoggerTool.dart';
import 'package:jdshop/widget/CheckOutItemWidget.dart';
import 'package:jdshop/widget/TextRadiusBtnWidget.dart';

class CheckOutPage extends StatefulWidget {
  final List<ProductDescItemModel> productList;

  CheckOutPage(this.productList);

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  @override
  Widget build(BuildContext context) {
    double total = 0;
    for (var value in widget.productList) {
      if (value.isCheck) {
        total += double.parse(value.price) * value.count;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("结算页面"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: ScreenUtil().setWidth(30),
                ),
                Icon(Icons.location_on),
                Expanded(
                  child: Center(
                    child: Text("请添加您的收货地址"),
                  ),
                ),
                Icon(Icons.arrow_forward_ios),
                SizedBox(
                  width: ScreenUtil().setWidth(30),
                ),
              ],
            ),
            height: ScreenUtil().setWidth(100),
          ),
          Container(
            height: ScreenUtil().setWidth(30),
            color: Colors.black12,
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return checkOutItemWidget(
                  widget.productList[index],
                );
              },
              itemCount: widget.productList.length,
            ),
          ),
          Container(
            height: 1,
            color: Colors.black12,
          ),
          Container(
            height: ScreenUtil().setWidth(50),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: ScreenUtil().setWidth(15),
                ),
                Text("实付款:"),
                SizedBox(
                  width: ScreenUtil().setWidth(3),
                ),
                Text(
                  "¥${total}元",
                  style: TextStyle(color: Colors.red),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                TextRadiusBtnWidget(
                  Colors.red,
                  Colors.white,
                  ScreenUtil().setWidth(20),
                  "立即下单",
                  () {
                    logger.info("立即下单");
                  },
                  height: ScreenUtil().setWidth(30),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
