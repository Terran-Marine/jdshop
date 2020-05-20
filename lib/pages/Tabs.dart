import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jdshop/pages/Home.dart';
import 'package:jdshop/pages/Category.dart';
import 'package:jdshop/pages/Cart.dart';
import 'package:jdshop/pages/Search.dart';
import 'package:jdshop/pages/User.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdshop/AppConfig.dart';
import 'package:nav_router/nav_router.dart';

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;

  List<Widget> _PageList = [HomePage(), CategoryPage(), CartPage(), UserPage()];

  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: _currentIndex, keepPage: false);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: STANDARD_WIDTH, height: STANDARD_HEIGHT);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.center_focus_weak),
          onPressed: () {},
        ),
        title: InkWell(
          child: Container(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(10),
                right: ScreenUtil().setWidth(10)),
            decoration: BoxDecoration(
                color: Color.fromRGBO(233, 233, 233, 0.8),
                borderRadius: BorderRadius.circular(80)),
            height: ScreenUtil().setHeight(76),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.search),
                Text(
                  "搜索",
                  style: TextStyle(fontSize: ScreenUtil().setSp(20)),
                )
              ],
            ),
          ),
          onTap: (){
            routePush(SearchPage());
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.message,
              size: 28,
              color: Colors.black,
            ),
            onPressed: () {},
          )
        ],
      ),
//      body: _PageList[_currentIndex],
      body: PageView(
        controller: _pageController,
        children: _PageList,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.indigo,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(_currentIndex);
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("首页")),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), title: Text("分类")),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), title: Text("购物车")),
          BottomNavigationBarItem(icon: Icon(Icons.people), title: Text("我的")),
        ],
      ),
    );
  }
}
