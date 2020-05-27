import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdshop/model/ProductDescModel.dart';
import 'package:jdshop/provider/ShoppingCartProvider.dart';
import 'package:provider/provider.dart';

class ShoppingItemNumberWidget extends StatefulWidget {
  ProductDescItemModel productDescModel;


  ShoppingItemNumberWidget({this.productDescModel});

  @override
  _ShoppingItemNumberWidgetState createState() =>
      _ShoppingItemNumberWidgetState();
}

class _ShoppingItemNumberWidgetState extends State<ShoppingItemNumberWidget> {


  @override
  Widget build(BuildContext context) {


    ShoppingCartProvider shoppingCartProvider =
    context.watch<ShoppingCartProvider>();

    return Container(
      height: ScreenUtil().setWidth(30),
      width: ScreenUtil().setWidth(100),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: Colors.grey,
        ),
        boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(2.0, 2.0))],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: InkWell(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "-",
                  textAlign: TextAlign.center,
                ),
              ),
              onTap: () {
                if (widget.productDescModel.count > 1) {

                  shoppingCartProvider.lessProductNumber(widget.productDescModel.sId);

//                  setState(() {
//                    --widget.productDescModel.count;
//                  });
                }
              },
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(width: 1, color: Colors.grey),
                      right: BorderSide(width: 1, color: Colors.grey))),
              child: Text("${widget.productDescModel.count}"),
            ),
          ),
          Expanded(
            flex: 2,
            child: InkWell(child: Container(
              alignment: Alignment.center,
              child: Text(
                "+",
                textAlign: TextAlign.center,
              ),
            ),onTap: (){

              shoppingCartProvider.addProductNumber(widget.productDescModel.sId);
//              setState(() {
//                ++widget.productDescModel.count;
//              });
            },),
          ),
        ],
      ),
    );
  }
}
