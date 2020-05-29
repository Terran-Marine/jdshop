import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdshop/control/UserControl.dart';
import 'package:jdshop/model/UserModel.dart';
import 'package:jdshop/pages/login/LoginPage.dart';
import 'package:jdshop/provider/ShoppingCartProvider.dart';
import 'package:jdshop/tools/LoggerTool.dart';
import 'package:jdshop/widget/TextRadiusBtnWidget.dart';
import 'package:nav_router/nav_router.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> with WidgetsBindingObserver {
  bool _isLogin = false;
  Userinfo _userinfo;

  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
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
                _isLogin
                    ? Expanded(
                        flex: 1,
                        child: Container(
                          height: ScreenUtil().setWidth(80),
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    _userinfo?.username ?? "",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Tel:${_userinfo?.username ?? ""}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Expanded(
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
                  title: Text("在线客服"),
                ),
                Divider(
                  height: 1,
                  color: Colors.black12,
                ),
              ],
            ),
          ),
          _isLogin
              ? Container(
                  padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(20)),
                  child: TextRadiusBtnWidget(Colors.red, Colors.white,
                      ScreenUtil().setWidth(20), "退出账号", () {
                    setState(() {
                      _isLogin = false;

                      UserControl.instance.cleanUserInfo();
                    });
                  }),
                )
              : SizedBox()
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    logger.info("didChangeDependencies");
    setState(() {
      _isLogin = UserControl.instance.isLogin();
      logger.info(_isLogin);

      if (_isLogin) {
        _userinfo = UserControl.instance.getUserInfo();
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.paused:
        break;

      case AppLifecycleState.resumed:
        setState(() {
          _isLogin = UserControl.instance.isLogin();
          logger.info(_isLogin);

          if (_isLogin) {
            _userinfo = UserControl.instance.getUserInfo();
          }
        });
        break;

      case AppLifecycleState.inactive:
        break;

      case AppLifecycleState.detached:
        break;
    }

    logger.info(state);
  }
}
