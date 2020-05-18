import 'package:flutter/material.dart';
import 'package:banner_widget/widget/banner_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dio/dio.dart';
import 'package:jdshop/model/FocusModel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FocusItemModel> bannerData = [];

  @override
  void initState() {
    super.initState();
    _getBannerData();
  }

  _getBannerData() async {
    Response respons = await Dio().get("http://jd.itying.com/api/focus");

    try {
      if (respons.statusCode == 200 && respons.data['result'] != null) {
        bannerData.clear();

        FocusModel focusModel = FocusModel.fromJson(respons.data);

        setState(() {
          bannerData = focusModel.result;
          print(bannerData[0].title);

          _convertBannerData();
        });
      }
    } catch (e) {
      print(e);
    }
  }

  List<BannerItem> _convertBannerData() {
    List<BannerItem> temp = new List<BannerItem>();
    if (bannerData.length > 0) {
      bannerData.forEach((element) {
        temp.add(BannerItem.defaultBannerItem("http://jd.itying.com/${element.pic.replaceAll('\\', '/')}", element.title));
      });
    }

    return temp;
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

  Widget _getYourProduct() {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil().setWidth(10.0)),
      height: ScreenUtil().setHeight(200.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              Container(
                height: ScreenUtil().setHeight(140),
                width: ScreenUtil().setHeight(140),
                margin: EdgeInsets.only(
                    left: ScreenUtil().setWidth(10.0),
                    right: ScreenUtil().setWidth(10.0)),
                child: Image.network(
                  "https://www.itying.com/images/flutter/hot${index + 1}.jpg",
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                child: Text("第${index}条"),
                margin: EdgeInsets.only(top: 5.0),
              )
            ],
          );
        },
        itemCount: 10,
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

  Widget _getHotProduct() {
    return Container(
      child: Wrap(
        children: <Widget>[
          _recProductList(),
          _recProductList(),
          _recProductList(),
          _recProductList(),
          _recProductList(),
          _recProductList(),
          _recProductList()
        ],
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

  _recProductList() {
    num width = (ScreenUtil.screenWidthDp - 30) / 2;
//    num width = (ScreenUtil().setWidth(ScreenUtil.screenWidthDp) -
//            ScreenUtil().setWidth(30)) /
//        2;
//    print(ScreenUtil.screenWidthDp);
//    print(width);

    return Container(
      decoration: BoxDecoration(
          border:
              Border.all(color: Color.fromRGBO(233, 233, 233, 0.8), width: 1)),
      width: width,
      padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Image.network(
              "https://www.itying.com/images/flutter/list1.jpg",
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(5)),
            child: Text(
              "2019夏季新款气质高贵洋气阔太太有女人味中长款宽松大码",
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
                    "¥999998.0",
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text("¥19.0",
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
    );
  }
}
