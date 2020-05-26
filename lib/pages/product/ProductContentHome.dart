import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdshop/model/ProductDescModel.dart';
import 'package:jdshop/tools/HttpTool.dart';
import 'package:jdshop/tools/ImageTool.dart';
import 'package:jdshop/widget/TextRadiusBtnWidget.dart';

import '../../AppConfig.dart';

class ProductContentHome extends StatefulWidget {
  String productId;

  ProductContentHome(this.productId);

  @override
  _ProductContentHomeState createState() => _ProductContentHomeState();
}

class _ProductContentHomeState extends State<ProductContentHome> {
  String _title="";//商品标题
  String _price="";//价格
  String _oldPrice="";//原价
  String _pic="";//商品图片地址
  String _subTitle="";//内容

  List<Attr> _attrList=[];

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              formatImageUrl(_pic),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
            child: Text(
              _title,
              style: TextStyle(color: Colors.black87, fontSize: 18),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
            child: Text(
              _subTitle,
              style: TextStyle(color: Colors.black38, fontSize: 12),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "原价:",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough),
                ),
                Text(
                  "￥${_oldPrice}",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Text(
                  "特价:",
                  style: TextStyle(fontSize: 20, color: Colors.red),
                ),
                Text(
                  "￥${_price}",
                  style: TextStyle(fontSize: 20, color: Colors.red),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
            child: InkWell(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "已选:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Text(
                    "115,heise,xl,1建",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              onTap: () {
                _showBottomBar();
              },
            ),
          ),
          Divider(),
          Container(
            margin: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "运费:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text(
                  "免运费",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          Divider()
        ],
      ),
      padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
    );
  }

  Widget _bottomItemWidget(int index) {
    Attr item=_attrList[index];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(child:    Text("${item.cate}: ",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),margin: EdgeInsets.only(left: ScreenUtil().setWidth(8)),)
     ,
        SizedBox(width: ScreenUtil().setWidth(10),),
        Expanded(
          flex: 1,
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: _getAttrItemList(item.list),
          ),
        )
      ],
    );
  }

  List<Widget> _getAttrItemList(List<String > list){
  return  list.map((e) =>   Container(
      margin: EdgeInsets.only(
          left: ScreenUtil().setWidth(3),
          right: ScreenUtil().setWidth(3)),
      child: Chip(
        label: Text(e),
      ),
    )).toList();
  }

  _showBottomBar() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return GestureDetector(
            onTap: () {},
            child: Container(
//              height: ScreenUtil().setWidth(260),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return _bottomItemWidget(index);
                      },
                      itemCount: _attrList.length,
                    ),
                  ),
                  Divider(),
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: TextRadiusBtnWidget(
                            Colors.red,
                            Colors.white,
                            12.0,
                            "加入购物车",
                            () {},
                            height: ScreenUtil().setWidth(46),
                            marginLR: ScreenUtil().setWidth(10),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: TextRadiusBtnWidget(
                            Colors.deepOrangeAccent,
                            Colors.white,
                            12.0,
                            "立即购买",
                            () {},
                            height: ScreenUtil().setWidth(46),
                            marginLR: ScreenUtil().setWidth(10),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _refreshData() async{
    Response respons = await dio.get(API_PCONTENT, queryParameters: {"id":widget.productId});

    if (respons.statusCode == 200 && respons.data != null) {
      ProductDescModel productDescModel = ProductDescModel.fromJson(respons.data);
        setState(() {
          _title= productDescModel.result.title;
          _price= productDescModel.result.price;
          _oldPrice= productDescModel.result.oldPrice;
          _pic= productDescModel.result.pic;
          _subTitle= productDescModel.result.subTitle;
          _attrList= productDescModel.result.attr;
        });
    }
  }
}
