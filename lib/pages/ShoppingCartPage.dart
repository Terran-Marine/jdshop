import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdshop/pages/order/CheckOutPage.dart';
import 'package:jdshop/provider/ShoppingCartProvider.dart';
import 'package:jdshop/tools/LoggerTool.dart';
import 'package:jdshop/widget/ShoppingItemWidget.dart';
import 'package:jdshop/widget/TextRadiusBtnWidget.dart';
import 'package:nav_router/nav_router.dart';
import 'package:provider/provider.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  bool _isEditMode = false;

  @override
  Widget build(BuildContext context) {
    ShoppingCartProvider shoppingCartProvider =
        context.watch<ShoppingCartProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text("我的购物车"),
        actions: <Widget>[
          IconButton(
            icon: Icon(_isEditMode ? Icons.check : Icons.mode_edit),
            onPressed: () {
              setState(() {
                _isEditMode = !_isEditMode;
              });
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.black12,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return shoppingCartWidget(
                      shoppingCartProvider.productList[index],
                      shoppingCartProvider);
                },
                itemCount: shoppingCartProvider.productList.length,
              ),
            ),
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
                  value: shoppingCartProvider.allProductSelect,
                  checkColor: Colors.white,
                  onChanged: (bool b) {
                    shoppingCartProvider.changeAllProductSelect(b);
//                    setState(() {
//                      _allSelectFlag = b;
//                    });
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
                  _isEditMode
                      ? "删除"
                      : "结算 ¥${shoppingCartProvider.productTotalPrice}",
                  () {
                    if (_isEditMode) {
                      logger.info("删除");
                      shoppingCartProvider.removeCheckProduct();
                    } else {

                      if(shoppingCartProvider.productList.isEmpty){
                        BotToast.showText(text: "为选择商品");
                      }else{
                        routePush(CheckOutPage(shoppingCartProvider.productList));

                      }

                    }
                  },
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
