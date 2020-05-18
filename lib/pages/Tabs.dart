import 'package:flutter/material.dart';
import 'package:jdshop/pages/Home.dart';
import 'package:jdshop/pages/Category.dart';
import 'package:jdshop/pages/Cart.dart';
import 'package:jdshop/pages/User.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdshop/AppConfig.dart';


class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex=0;

  List _PageList=[HomePage(),CategoryPage(),CartPage(),UserPage()];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: STANDARD_WIDTH, height: STANDARD_HEIGHT);
    return Scaffold(
      appBar: AppBar(
        title: Text("标题"),
      ),
      body: _PageList[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.indigo,
        currentIndex: _currentIndex,
        onTap: (index){
          setState(() {
            _currentIndex=index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("首页")),
          BottomNavigationBarItem(icon: Icon(Icons.category), title: Text("分类")),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), title: Text("购物车")),
          BottomNavigationBarItem(icon: Icon(Icons.people), title: Text("我的")),
        ],
      ),
    );
  }
}
