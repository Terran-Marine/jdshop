import 'package:flutter/material.dart';
import 'package:banner_widget/widget/banner_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dio/dio.dart';
import 'package:jdshop/model/FocusModel.dart';
import 'package:jdshop/model/ProductModel.dart';

import '../AppConfig.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FocusItemModel> bannerData = [];
  List<ProductItemModel> yourData = [];
  List<ProductItemModel> bestData = [];

  Dio dio = new Dio();

  @override
  void initState() {
    super.initState();
    _getBannerData();
    _getHotProductData();
    _getBaseProductData();
  }

  _getBannerData() async {
    Response respons = await dio.get(API_FOCUS);

    try {
      if (respons.statusCode == 200 && respons.data['result'] != null) {
        bannerData.clear();

        FocusModel focusModel = FocusModel.fromJson(respons.data);

        setState(() {
          bannerData = focusModel.result;

          _convertBannerData();
        });
      }
    } catch (e) {
      print(e);
    }
  }

  _getHotProductData() async {
    Response respons = await dio.get(API_PLIST, queryParameters: {"is_hot": 1});

    if (respons.statusCode == 200 && respons.data != null) {
      ProductModel productModel = ProductModel.fromJson(respons.data);
      setState(() {
        yourData = productModel.result;
      });
    }
  }

  void _getBaseProductData() async {
    Response respons =
        await dio.get(API_PLIST, queryParameters: {"is_best": 1});

    if (respons.statusCode == 200 && respons.data != null) {
      ProductModel productModel = ProductModel.fromJson(respons.data);
      setState(() {
        bestData = productModel.result;
      });
    }
  }

  List<BannerItem> _convertBannerData() {
    List<BannerItem> temp = new List<BannerItem>();
    if (bannerData.length > 0) {
      bannerData.forEach((element) {
        temp.add(BannerItem.defaultBannerItem(
            "${BASE_URL}${element.pic.replaceAll('\\', '/')}", element.title));
      });
    }

    return temp;
  }

  //猜你喜欢
  Widget _getYourProduct() {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil().setWidth(10.0)),
      height: ScreenUtil().setHeight(200.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            width: 100,
            child: Column(
              children: <Widget>[
                Container(
                  height: ScreenUtil().setHeight(140),
                  width: ScreenUtil().setHeight(140),
                  margin: EdgeInsets.only(
                      left: ScreenUtil().setWidth(10.0),
                      right: ScreenUtil().setWidth(10.0)),
                  child: Image.network(
                    "${BASE_URL}${yourData[index].sPic.replaceAll("\\", "/")}",
                    fit: BoxFit.contain,
                  ),
                ),
                Center(
                  child: Container(
                    child: Text(
                      "¥ ${yourData[index].price}",
                      maxLines: 1,
                      style: TextStyle(color: Colors.red),
                    ),
                    margin: EdgeInsets.only(top: 5.0),
                  ),
                )
              ],
            ),
//            decoration: BoxDecoration(
//                border: Border.all(color: Colors.black12, width: 1)),
          );
        },
        itemCount: yourData.length,
      ),
    );
  }

  Widget _getBanner() {
    return Container(
      child: AspectRatio(
        aspectRatio: 2 / 1,
        child: BannerWidget(
          _convertBannerData(),
          duration: 2500,
          height: 200.0,
          onBannerItemClick: (int position, BannerItem item) {
            print("position: ${position}   item:${item}");
          },
        ),
      ),
    );
  }

  Widget _titleWidget(String titleText) {
    return Container(
      margin: EdgeInsets.only(
          left: ScreenUtil().setWidth(10.0), top: ScreenUtil().setHeight(10.0)),
      padding: EdgeInsets.only(left: 10.0),
      child: Text(
        titleText,
        style: TextStyle(color: Colors.black54),
      ),
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
                  color: Colors.red, width: ScreenUtil().setWidth(4.0)))),
    );
  }

  //主要商品
  Widget _getHotProduct() {
    return Container(
      child: Wrap(
        children: _recProductList(),
        runSpacing: ScreenUtil().setWidth(10),
        spacing: ScreenUtil().setWidth(10),
      ),
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(10),
          top: ScreenUtil().setWidth(10),
          right: ScreenUtil().setWidth(10.0),
          bottom: ScreenUtil().setWidth(5.0)),
    );
  }

  List<Widget> _recProductList() {
    num width = (ScreenUtil.screenWidthDp - 30) / 2;

//    List<Widget> temp = new List<Widget>();

//    bestData.forEach((element) {
//      temp.add(Container(
//        decoration: BoxDecoration(
//            border: Border.all(
//                color: Color.fromRGBO(233, 233, 233, 0.8), width: 1)),
//        width: width,
//        padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
//        child: Column(
//          children: <Widget>[
//            Container(
//              width: double.infinity,
//              child: Image.network(
//                "${BASE_URL}${element.pic.replaceAll("\\", "/")}",
//                fit: BoxFit.contain,
//              ),
//            ),
//            Padding(
//              padding: EdgeInsets.only(top: ScreenUtil().setHeight(5)),
//              child: Text(
//                "${element.title}",
//                maxLines: 2,
//                overflow: TextOverflow.ellipsis,
//                style: TextStyle(color: Colors.black54, fontSize: 12),
//              ),
//            ),
//            Padding(
//              padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
//              child: Stack(
//                children: <Widget>[
//                  Align(
//                    alignment: Alignment.centerLeft,
//                    child: Text(
//                      "¥${element.price}",
//                      style: TextStyle(color: Colors.red, fontSize: 16),
//                    ),
//                  ),
//                  Align(
//                    alignment: Alignment.centerRight,
//                    child: Text("¥${element.oldPrice}",
//                        style: TextStyle(
//                            color: Colors.black54,
//                            fontSize: 14,
//                            decoration: TextDecoration.lineThrough)),
//                  ),
//                ],
//              ),
//            ),
//          ],
//        ),
//      ));
//    });

    return bestData
        .map((element) => Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromRGBO(233, 233, 233, 0.8), width: 1)),
              width: width,
              padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 200,
                    child: Image.network(
                      "${BASE_URL}${element.pic.replaceAll("\\", "/")}",
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: ScreenUtil().setHeight(5)),
                    child: Text(
                      "${element.title}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black54, fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "¥${element.price}",
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text("¥${element.oldPrice}",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                  decoration: TextDecoration.lineThrough)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ))
        .toList();

//    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _getBanner(),
        _titleWidget("猜你喜欢"),
        _getYourProduct(),
        _titleWidget("热门商品"),
        _getHotProduct(),
      ],
    );
  }
}
