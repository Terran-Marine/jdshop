import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdshop/AppConfig.dart';
import 'package:jdshop/control/UserControl.dart';
import 'package:jdshop/model/DefaultAddressModel.dart';
import 'package:jdshop/model/ProductDescModel.dart';
import 'package:jdshop/model/UserModel.dart';
import 'package:jdshop/pages/address/AddressListPage.dart';
import 'package:jdshop/pages/order/PayPage.dart';
import 'package:jdshop/tools/HttpTool.dart';
import 'package:jdshop/tools/LoggerTool.dart';
import 'package:jdshop/tools/SignTools.dart';
import 'package:jdshop/widget/CheckOutItemWidget.dart';
import 'package:jdshop/widget/TextRadiusBtnWidget.dart';
import 'package:nav_router/nav_router.dart';

class CheckOutPage extends StatefulWidget {
  final List<ProductDescItemModel> productList;

  CheckOutPage(this.productList);

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  DefaultAddressItemModel _defaultAddressItemModel;
  Userinfo userinfo = UserControl.instance.getUserInfo();
  double _total = 0;

  @override
  void initState() {
    super.initState();
    _getDefault();
  }

  @override
  Widget build(BuildContext context) {
    for (var value in widget.productList) {
      if (value.isCheck) {
        _total += double.parse(value.price) * value.count;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("结算页面"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: _defaultAddressItemModel != null
                ? InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: ScreenUtil().setWidth(30),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  _defaultAddressItemModel?.name ?? "",
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setWidth(8),
                                ),
                                Text(_defaultAddressItemModel?.address ?? "")
                              ],
                            ),
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios),
                        SizedBox(
                          width: ScreenUtil().setWidth(30),
                        ),
                      ],
                    ),
                    onTap: () {
                      logger.info("添加收货地址");
                      routePush(AddressListPage());
                    },
                  )
                : InkWell(
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
                    onTap: () {},
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
                  "¥${_total}元",
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
                    _doOrder();
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

  void _getDefault() async {
    Map<String, dynamic> parame = {
      "uid": userinfo.sId,
      "salt": "${userinfo.salt}"
    };

    Response respons = await dio.get(API_ONEADDRESSLIST,
        queryParameters: getSignParame(parame));

    if (respons.statusCode == 200 && respons.data != null) {
      DefaultAddressModel defaultAddressModel =
          DefaultAddressModel.fromJson(respons.data);

      logger.info(defaultAddressModel.toString());
      setState(() {
        _defaultAddressItemModel = defaultAddressModel.result[0];
      });
    }
  }

  void _doOrder() async {
    Map<String, dynamic> parame = {
      "uid": userinfo.sId,
      "salt": "${userinfo.salt}",
      "address": _defaultAddressItemModel.address,
      "phone": _defaultAddressItemModel.phone,
      "name": _defaultAddressItemModel.name,
      "all_price": _total.toStringAsFixed(1),
      "products": json.encode(widget.productList),
    };

    Response respons = await dio.post(API_DOORDER, data: getSignParame(parame));

    if (respons.statusCode == 200 && respons.data != null) {
      logger.info(respons.data);

      routePush(PayPage());
    }
  }
}
