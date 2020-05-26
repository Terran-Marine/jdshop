import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jdshop/pages/HomePage.dart';
import 'package:jdshop/pages/CategoryPage.dart';
import 'package:jdshop/pages/ShoppingCartPage.dart';
import 'package:jdshop/pages/SearchPage.dart';
import 'package:jdshop/pages/UserPage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdshop/AppConfig.dart';
import 'package:jdshop/widget/MainAppBarWidget.dart';
import 'package:nav_router/nav_router.dart';

class HomeTabsPage extends StatefulWidget {
  @override
  _HomeTabsPageState createState() => _HomeTabsPageState();
}

class _HomeTabsPageState extends State<HomeTabsPage> {
  int _currentIndex = 0;

  List<Widget> _PageList = [HomePage(), CategoryPage(), ShoppingCartPage(), UserPage()];

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
