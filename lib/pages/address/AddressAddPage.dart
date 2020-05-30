import 'package:bot_toast/bot_toast.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdshop/AppConfig.dart';
import 'package:jdshop/control/UserControl.dart';
import 'package:jdshop/model/UserModel.dart';
import 'package:jdshop/tools/HttpTool.dart';
import 'package:jdshop/tools/LoggerTool.dart';
import 'package:jdshop/tools/SignTools.dart';
import 'package:jdshop/widget/TextRadiusBtnWidget.dart';

class AddressAddPage extends StatefulWidget {
  @override
  _AddressAddPageState createState() => _AddressAddPageState();
}

class _AddressAddPageState extends State<AddressAddPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String _address = "省/市/区";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("增加收货地址"),
      ),
      body: ListView(
        children: <Widget>[
          TextField(
            controller: _nameController,
            inputFormatters: [LengthLimitingTextInputFormatter(10)],
//            maxLength: 11,
            maxLines: 1,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(
                    ScreenUtil().setWidth(15), 0, ScreenUtil().setWidth(15), 0),
                hintText: "收件人姓名",
                border: InputBorder.none),
          ),
          Divider(
            height: 1,
          ),
          TextField(
            controller: _phoneController,
            inputFormatters: [LengthLimitingTextInputFormatter(11)],
//            maxLength: 11,
            maxLines: 1,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(
                    ScreenUtil().setWidth(15), 0, ScreenUtil().setWidth(15), 0),
                hintText: "收件人电话号码",
                border: InputBorder.none),
          ),
          Divider(
            height: 1,
          ),
          Container(
            alignment: Alignment.centerLeft,
            height: ScreenUtil().setWidth(55),
            child: InkWell(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: ScreenUtil().setWidth(10),
                  ),
                  Icon(Icons.location_on),
                  SizedBox(
                    width: ScreenUtil().setWidth(5),
                  ),
                  Text(_address)
                ],
              ),
              onTap: () {
                _showCityPick();
              },
            ),
          ),
          Divider(
            height: 1,
          ),
          TextField(
            controller: _addressController,
            inputFormatters: [LengthLimitingTextInputFormatter(11)],
//            maxLength: 11,
            maxLines: 3,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(
                    ScreenUtil().setWidth(15), 0, ScreenUtil().setWidth(15), 0),
                hintText: "详细地址",
                border: InputBorder.none),
          ),
          Divider(
            height: 1,
          ),
          SizedBox(
            height: ScreenUtil().setWidth(80),
          ),
          TextRadiusBtnWidget(
              Colors.red, Colors.white, ScreenUtil().setWidth(20), "添 加", () {
            logger.info(
                "${_nameController.text} \n${_phoneController.text}\n${_addressController.text}\n${_address}");

            if (_nameController.text.isEmpty ||
                _phoneController.text.isEmpty ||
                _addressController.text.isEmpty ||
                _address == "省/市/区") {
              BotToast.showText(text: "填全再点！");
            } else {
              _addressAdd();
            }
          }),
        ],
      ),
    );
  }

  void _showCityPick() async {
    Result result =
        await CityPickers.showCityPicker(context: context, theme: ThemeData());

    setState(() {
      _address =
          "${result.provinceName} - ${result.areaName} - ${result.cityName}";
    });
  }

  void _addressAdd() async {
    Userinfo userinfo = UserControl.instance.getUserInfo();

    Map<String,dynamic> parame = {
      "uid": userinfo.sId,
      "name": _nameController.text,
      "phone": _phoneController.text,
      "address": "${_address}-${_addressController.text}"
    };

    parame["sign"] = getSign(parame);

    Response respons = await dio.post(API_ADDADDRESS, data: parame);

    if (respons.statusCode == 200 && respons.data != null) {}
  }
}