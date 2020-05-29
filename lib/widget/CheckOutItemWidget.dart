import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdshop/model/ProductDescModel.dart';
import 'package:jdshop/provider/ShoppingCartProvider.dart';
import 'package:jdshop/tools/ImageTool.dart';
import 'package:jdshop/tools/LoggerTool.dart';
import 'package:jdshop/widget/ShoppingItemNumberWidget.dart';
import 'package:provider/provider.dart';

Widget checkOutItemWidget(ProductDescItemModel product) {

  return Card(
    child: Container(
      height: ScreenUtil().setWidth(100),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: ScreenUtil().setWidth(15),
          ),
          Container(
            height: ScreenUtil().setWidth(80),
            width: ScreenUtil().setWidth(80),
            child: Image.network(
              formatImageUrl(product.pic),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(15),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Row(
                    children: <Widget>[Text(product.title)],

                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "¥${product.price}",
                        style: TextStyle(color: Colors.redAccent, fontSize: 18),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(),
                      ),

                      Text("x${product.count}"),

                      SizedBox(
                        width: ScreenUtil().setWidth(15),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    ),
  );
}




