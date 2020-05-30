import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdshop/AppConfig.dart';
import 'package:jdshop/control/UserControl.dart';
import 'package:jdshop/model/AddressModel.dart';
import 'package:jdshop/model/UserModel.dart';
import 'package:jdshop/pages/address/AddressAddPage.dart';
import 'package:jdshop/tools/HttpTool.dart';
import 'package:jdshop/tools/LoggerTool.dart';
import 'package:jdshop/tools/SignTools.dart';
import 'package:jdshop/widget/EmptyWidget.dart';
import 'package:nav_router/nav_router.dart';
import 'package:city_pickers/city_pickers.dart';

class AddressListPage extends StatefulWidget {
  @override
  _AddressListPageState createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  List<AddressModel> addressList = [];

  @override
  Widget build(BuildContext context) {
    addressList.clear();
    addressList.add(AddressModel("傻子", "12345678901", "地址地址地址地址", false));
    addressList.add(AddressModel("傻子", "12345678901", "地址地址地址地址", false));
    addressList.add(AddressModel("傻子", "12345678901", "地址地址地址地址", false));
    addressList.add(AddressModel("傻子", "12345678901", "地址地址地址地址", false));
    addressList.add(AddressModel("傻子", "12345678901", "地址地址地址地址", false));
    addressList.add(AddressModel("傻子", "12345678901", "地址地址地址地址", false));

    return Scaffold(
      appBar: AppBar(
        title: Text("收货地址列表"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: addressList.isEmpty
                ? EmptyWidget()
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return addressItem(addressList[index]);
                    },
                    itemCount: addressList.length,
                  ),
          ),
          Container(
            color: Colors.redAccent,
            height: ScreenUtil().setWidth(50),
            alignment: Alignment.center,
            child: InkWell(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(5),
                    ),
                    Text(
                      "新增收货地址",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              onTap: () {
                routePush(AddressAddPage());
              },
            ),
          )
        ],
      ),
    );
  }

  Widget addressItem(AddressModel addressModel) {
    return Column(
      children: <Widget>[
        Container(
          height: ScreenUtil().setWidth(75),
          color: Colors.white,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: ScreenUtil().setWidth(15),
              ),
              addressModel.isSelect
                  ? Icon(
                      Icons.check,
                      color: Colors.redAccent,
                    )
                  : SizedBox(),
              SizedBox(
                width: ScreenUtil().setWidth(15),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(addressModel.userName),
                  Text(addressModel.userAddress)
                ],
              ),
              Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Icon(
                Icons.edit,
                color: Colors.blue,
              ),
              SizedBox(
                width: ScreenUtil().setWidth(15),
              )
            ],
          ),
        ),
        Divider(
          height: 1,
        )
      ],
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _refreshData();
  }

  _refreshData() async {
    Userinfo userinfo = UserControl.instance.getUserInfo();
    Response respons = await dio.get(API_ADDRESSLIST, queryParameters: {
      "uid": userinfo.sId,
      "sign": getSign({"uid": userinfo.sId})
    });

    if (respons.statusCode == 200 && respons.data != null) {}
  }
}
