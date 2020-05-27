import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:jdshop/provider/ShoppingCartProvider.dart';
import 'package:jdshop/tools/EventBusTool.dart';
import 'package:jdshop/tools/LoggerTool.dart';
import 'package:jdshop/tools/SharedPreferencesTool.dart';
import 'package:jdshop/tools/HttpTool.dart';
import 'package:nav_router/nav_router.dart';
import 'package:simple_logger/simple_logger.dart';
import 'AppConfig.dart';
import 'pages/HomeTabsPage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _initLogger();
    _initHttpDio();
    SharedPreferencesTool.getInstance();
  }

  void _initLogger() {
    logger.setLevel(
      Level.INFO,
      includeCallerInfo: true,
    );
  }

  void _initHttpDio() {
    dio.options.receiveTimeout = RECEIVE_TIMEOUT; //接收数据的最长时限
    dio.options.baseUrl =
        BASE_URL; //请求基地址,可以包含子路径，如: "https://www.google.com/api/".
    dio.interceptors.add(networkLogInterceptor); //开启请求日志
  }



  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ShoppingCartProvider()),
      ],
      child: _refreshConfiguration(),
    );
  }

  RefreshConfiguration _refreshConfiguration() {
    return RefreshConfiguration(
      headerBuilder: () => WaterDropHeader(),
      // 配置默认头部指示器,假如你每个页面的头部指示器都一样的话,你需要设置这个
      footerBuilder: () => ClassicFooter(),
      // 配置默认底部指示器
      headerTriggerDistance: 80.0,
      // 头部触发刷新的越界距离
      springDescription:
          SpringDescription(stiffness: 170, damping: 16, mass: 1.9),
      // 自定义回弹动画,三个属性值意义请查询flutter api
      maxOverScrollExtent: 100,
      //头部最大可以拖动的范围,如果发生冲出视图范围区域,请设置这个属性
      maxUnderScrollExtent: 0,
      // 底部最大可以拖动的范围
      enableScrollWhenRefreshCompleted: true,
      //这个属性不兼容PageView和TabBarView,如果你特别需要TabBarView左右滑动,你需要把它设置为true
      enableLoadingWhenFailed: true,
      //在加载失败的状态下,用户仍然可以通过手势上拉来触发加载更多
      hideFooterWhenNotFull: false,
      // Viewport不满一屏时,禁用上拉加载更多功能
      enableBallisticLoad: true,
      // 可以通过惯性滑动触发加载更多
      child: _materialApp(),
    );
  }

  MaterialApp _materialApp() {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.white),
      localizationsDelegates: [
        // this line is important
        RefreshLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('zh'),
      ],
      localeResolutionCallback:
          (Locale locale, Iterable<Locale> supportedLocales) {
        //print("change language");
        return locale;
      },
      navigatorKey: navGK,
      home: HomeTabsPage(),
    );
  }


}
