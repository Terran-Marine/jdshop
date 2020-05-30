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

class _AddressListPageState extends State<AddressListPage>   with WidgetsBindingObserver  {
  List<AddressItemModel> _addressList = [];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("收货地址列表"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: _addressList.isEmpty
                ? EmptyWidget()
                : ListView.builder(
              itemBuilder: (context, index) {
                return addressItem(_addressList[index]);
              },
              itemCount: _addressList.length,
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

  Widget addressItem(AddressItemModel addressModel) {
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
              addressModel.defaultAddress == 1
                  ? Icon(
                Icons.check,
                color: Colors.redAccent,
              )
                  : SizedBox(),
              SizedBox(
                width: ScreenUtil().setWidth(15),
              ),

              Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(addressModel.name),
                      Text(addressModel.address,maxLines: 1,)
                    ],
                  ) ,
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


  _refreshData() async {
    Userinfo userinfo = UserControl.instance.getUserInfo();

    Map<String, dynamic> parame = {
      "uid": userinfo.sId,
      "salt": "${userinfo.salt}"
    };


    Response respons = await dio.get(
        API_ADDRESSLIST, queryParameters: getSignParame(parame));

    if (respons.statusCode == 200 && respons.data != null) {
      AddressModel addressModel = AddressModel.fromJson(respons.data);

      setState(() {
        _addressList.clear();
        _addressList.addAll(addressModel.result);
      });
    }
  }


@override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _refreshData();
  }


  @override
  void reassemble() {
    super.reassemble();
    logger.info('reassemble');
  }
  @override
  void deactivate() {
    super.deactivate();
    logger.info('deactivate');
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.addObserver(this);
    logger.info('dispose');
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    logger.info(state.toString());
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    logger.info('didChangeDependencies');
  }


}
