import 'package:flutter/material.dart';
import 'package:banner_widget/widget/banner_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BannerItem> bannerData = [];

  @override
  void initState() {
    super.initState();
    bannerData.add(BannerItem.defaultBannerItem(
        'http://n.sinaimg.cn/sports/transform/0/w500h300/20190814/14d8-icapxpi4070373.jpg',
        'LeBron James'));
    bannerData.add(BannerItem.defaultBannerItem(
        'http://img.mp.itc.cn/upload/20170106/a87363f5c7e548ec8022b5cadfc1c216_th.jpg',
        'LeBron&Wade'));
    bannerData.add(BannerItem.defaultBannerItem(
        'http://02.imgmini.eastday.com/mobile/20180328/20180328212318_1ef989a9c001edab4c94578141c10f18_2.jpeg',
        'LeBron VS Wade'));
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    return ListView(
      children: <Widget>[
        _getBanner(),
        _titleWidget("猜你喜欢"),
      ],
    );
  }

  Widget _getBanner() {
    return Container(
      child: AspectRatio(
        aspectRatio: 2 / 1,
        child: BannerWidget(
          bannerData,
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
      margin: EdgeInsets.only(left: ScreenUtil().setWidth(10.0),top: ScreenUtil().setHeight(10.0)),
      padding: EdgeInsets.only(left: 10.0),
      child: Text(titleText,style: TextStyle(color: Colors.black54),),
      decoration: BoxDecoration(
          border: Border(left: BorderSide(color: Colors.red, width: ScreenUtil().setWidth(4.0)))),
    );
  }
}