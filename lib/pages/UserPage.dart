import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdshop/pages/login/LoginPage.dart';
import 'package:jdshop/provider/ShoppingCartProvider.dart';
import 'package:nav_router/nav_router.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    ShoppingCartProvider counter = context.watch<ShoppingCartProvider>();

    return Container(
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/user_bg.jpg'),
                    fit: BoxFit.cover)),
            padding: EdgeInsets.only(
              top: ScreenUtil().setWidth(20),
              left: ScreenUtil().setWidth(10),
              right: ScreenUtil().setWidth(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                    child: Image.asset(
                  'images/user.png',
                  fit: BoxFit.contain,
                )),
                SizedBox(
                  width: ScreenUtil().setWidth(20),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    child: Text(
                      "登陆/注册",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onTap: () {
                      routePush(LoginPage());
                    },
                  ),
                ),

//                Expanded(
//                  flex: 1,
//                  child: Container(
//                    height: ScreenUtil().setWidth(80),
//                    child: Column(
//                      children: <Widget>[
//                        Expanded(
//                          flex: 1,
//                          child: Container(
//                            alignment: Alignment.centerLeft,
//                            child: Text(
//                              "title",
//                              textAlign: TextAlign.center,
//                              style:
//                                  TextStyle(color: Colors.white, fontSize: 18),
//                            ),
//                          ),
//                        ),
//                        Expanded(
//                          flex: 1,
//                          child: Container(
//                            alignment: Alignment.centerLeft,
//                            child: Text(
//                              "title",
//                              textAlign: TextAlign.center,
//                              style: TextStyle(color: Colors.white),
//                            ),
//                          ),
//                        ),
//                      ],
//                    ),
//                  ),
//                ),

                SizedBox(
                  width: ScreenUtil().setWidth(20),
                ),
              ],
            ),
            height: ScreenUtil().setWidth(180),
          ),
          Expanded(
            flex: 1,
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.assessment,
                    color: Colors.red,
                  ),
                  title: Text("全部订单"),
                ),
                Divider(
                  height: 1,
                  color: Colors.black12,
                ),
                ListTile(
                  leading: Icon(
                    Icons.payment,
                    color: Colors.green,
                  ),
                  title: Text("待付款"),
                ),
                Divider(
                  height: 1,
                  color: Colors.black12,
                ),
                ListTile(
                  leading: Icon(
                    Icons.local_car_wash,
                    color: Colors.orange,
                  ),
                  title: Text("待发货"),
                ),
                Divider(
                  color: Colors.black12,
                  thickness: ScreenUtil().setWidth(10),
                ),
                ListTile(
                  leading: Icon(
                    Icons.favorite,
                    color: Colors.lightGreen,
                  ),
                  title: Text("我的收藏"),
                ),
                Divider(
                  height: 1,
                  color: Colors.black12,
                ),
                ListTile(
                  leading: Icon(
                    Icons.people,
                    color: Colors.black54,
                  ),
                  title: Text("现在客服"),
                ),
                Divider(
                  height: 1,
                  color: Colors.black12,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
