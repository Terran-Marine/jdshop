import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdshop/pages/product/ProductContentDesc.dart';
import 'package:jdshop/pages/product/ProductContentEval.dart';
import 'package:jdshop/pages/product/ProductContentHome.dart';
import 'package:jdshop/tools/LoggerTool.dart';
import 'package:jdshop/widget/TextRadiusBtnWidget.dart';
import 'package:popup_menu/popup_menu.dart';

class ProductContentPage extends StatefulWidget {
  String productId;

  ProductContentPage({this.productId});

  @override
  _ProductContentPageState createState() => _ProductContentPageState();
}

class _ProductContentPageState extends State<ProductContentPage> {
  PopupMenu menu;

  GlobalKey menuBtnKey = GlobalKey();

  void onClickMenu(MenuItemProvider item) {
    logger.info('Click menu -> ${item.menuTitle}');
  }

  void onDismiss() {
    logger.info('Menu is dismiss');
  }

  @override
  void initState() {
    super.initState();

    menu = PopupMenu(
        backgroundColor: Colors.black12,
        lineColor: Colors.white70,
        maxColumn: 1,
        items: [
          MenuItem(
            title: 'Home',
            textStyle: TextStyle(fontSize: 14.0, color: Colors.white),
          ),
          MenuItem(
            title: 'Mail',
            textStyle: TextStyle(fontSize: 14.0, color: Colors.white),
          ),
        ],
        onClickMenu: onClickMenu,
        onDismiss: onDismiss);
  }

  @override
  Widget build(BuildContext context) {
    PopupMenu.context = context;
    PopupMenu.itemHeight = ScreenUtil().setWidth(45);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Container(
            width: ScreenUtil().setWidth(260),
            child: TabBar(
              indicatorColor: Colors.red,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: <Widget>[
                Tab(
                  child: Text('商品'),
                ),
                Tab(
                  child: Text('详情'),
                ),
                Tab(
                  child: Text('评价'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            IconButton(
              key: menuBtnKey,
              icon: Icon(Icons.more_horiz),
              onPressed: () {
                menu.show(widgetKey: menuBtnKey);
              },
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: TabBarView(
                children: <Widget>[
                  ProductContentHome(widget.productId),
                  ProductContentDesc(widget.productId),
                  ProductContentEval(),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border:
                      Border(top: BorderSide(color: Colors.black12, width: 1))),
              height: ScreenUtil().setWidth(65),
              child: _bottomBarWidget(),
            )
          ],
        ),
      ),
    );
  }

  Widget _bottomBarWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 100,
          height: ScreenUtil().setWidth(65),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.shopping_cart,
                size: 20,
              ),
              Text(
                "购物车",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
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
    );
  }
}
