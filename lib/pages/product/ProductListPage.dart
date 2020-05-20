import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdshop/AppConfig.dart';
import 'package:jdshop/model/ProductModel.dart';
import 'package:jdshop/tools/HttpTool.dart';
import 'package:jdshop/tools/ImageTool.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProductListPage extends StatefulWidget {
  Map arguments;

  ProductListPage({Key key, this.arguments}) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  List<ProductItemModel> productList = [];
  int _page = 1;
  String _sort = "all_-1";
  final int _pageSize = 10;

  List _subHeaderList = [
    {
      "id": 1,
      "title": "综合",
      "fileds": "all",
      "sort":
          -1, //排序     升序：price_1     {price:1}        降序：price_-1   {price:-1}
    },
    {"id": 2, "title": "销量", "fileds": 'salecount', "sort": -1},
    {"id": 3, "title": "价格", "fileds": 'price', "sort": -1},
    {"id": 4, "title": "筛选"}
  ];

  int _selectTagIndex = 0;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _getProductListData(false);
    _selectTagIndex = _subHeaderList[0]['id'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("商品列表"),
        actions: <Widget>[Text("")],
      ),
      endDrawer: Drawer(
        child: Container(
          child: Center(child: Text("筛选侧边栏")),
        ),
      ),
      body: Stack(
        children: <Widget>[
          _productListWidget(),
          _productTagWidget(),
        ],
      ),
    );
  }

  Widget _productTagWidget() {
    return Positioned(
      top: 0,
      height: ScreenUtil().setWidth(50),
      width: ScreenUtil.screenWidthDp,
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1, color: Color.fromRGBO(233, 233, 233, 0.9)))),
        width: double.infinity,
        child: Row(
          children: _getTagsWidgetList(),
        ),
      ),
    );
  }

  void _tagsChange(e) {
    if (e['id'] == 4) {
      _scaffoldKey.currentState.openEndDrawer();
    } else {
      _sort = "${e['fileds']}_${e['sort']}";
      _getProductListData(false);
    }

    setState(() {
      print(e['id']);
      _selectTagIndex = e['id'];
    });
  }

  List<Widget> _getTagsWidgetList() {
//    _selectTagIndex = _subHeaderList[0]['id'];
    return _subHeaderList
        .map((e) => Expanded(
              flex: 1,
              child: InkWell(
                child: Text(
                  e['title'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: _selectTagIndex == e['id']
                          ? Colors.red
                          : Colors.black54),
                ),
                onTap: () {
                  _tagsChange(e);
                },
              ),
            ))
        .toList();
  }

  Widget _productListWidget() {
    return productList.length == 0
        ? LoadingFlipping.circle()
        : Container(
            margin: EdgeInsets.only(top: ScreenUtil().setWidth(50)),
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: WaterDropHeader(),
              footer: CustomFooter(
                builder: (BuildContext context, LoadStatus mode) {
                  Widget body;
                  if (mode == LoadStatus.idle) {
                    body = Text("上拉加载");
                  } else if (mode == LoadStatus.loading) {
                    body = CupertinoActivityIndicator();
                  } else if (mode == LoadStatus.failed) {
                    body = Text("加载失败！点击重试！");
                  } else if (mode == LoadStatus.canLoading) {
                    body = Text("松手,加载更多!");
                  } else {
                    body = Text("没有更多数据了!");
                  }
                  return Container(
                    height: 55.0,
                    child: Center(child: body),
                  );
                },
              ),
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return _productItemWidget(index);
                },
                itemCount: productList.length,
              ),
            ),
          );
  }

  Container _productItemWidget(int index) {
    return Container(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(5), right: ScreenUtil().setWidth(5)),
//              color: index%2==0?Colors.blueGrey:Colors.white,
      height: ScreenUtil().setWidth(130),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: ScreenUtil().setWidth(110),
                width: ScreenUtil().setWidth(110),
                child: Image.network(
                  formatImageUrl(productList[index].pic),
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(left: ScreenUtil().setWidth(5)),
                  height: ScreenUtil().setWidth(110),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        productList[index].title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                              height: ScreenUtil().setWidth(30),
                              margin: EdgeInsets.only(right: 10),
                              padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                              //注意 如果Container里面加上decoration属性，这个时候color属性必须得放在BoxDecoration
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromRGBO(230, 230, 230, 0.9),
                              ),
                              child: Center(
                                child: Text("4g"),
                              )),
                          Container(
                              height: ScreenUtil().setWidth(30),
                              margin: EdgeInsets.only(right: 10),
                              padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                              //注意 如果Container里面加上decoration属性，这个时候color属性必须得放在BoxDecoration
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromRGBO(230, 230, 230, 0.9),
                              ),
                              child: Center(
                                child: Text("256"),
                              )),
                        ],
                      ),
                      Text(
                        "￥ ${productList[index].price}",
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Divider(
            height: 1,
          )
        ],
      ),
    );
  }

  void _onRefresh() async {
    _getProductListData(false);
  }

  void _onLoading() async {
    _getProductListData(true);
  }

  void _getProductListData(bool isMore) async {
    if (isMore) {
      _page++;
    } else {
      _page = 1;
      productList.clear();
    }

    Response respons = await dio.get(API_PLIST, queryParameters: {
      "cid": widget.arguments['cid'],
      "page": _page,
      "pageSize": _pageSize,
      "sort": _sort,
    });

    if (respons.statusCode == 200 && respons.data != null) {
      ProductModel productModel = ProductModel.fromJson(respons.data);
      setState(() {
        if (isMore) {
          if (productModel.result.length < _pageSize) {
            _refreshController.loadNoData();
          } else {
            _refreshController.loadComplete();
          }
        } else {
          _refreshController.refreshCompleted();
          //刷新之后把状态设置位初始状态,否则不能再次加载更多
          _refreshController.footerMode.value = LoadStatus.idle;
        }

        productList.addAll(productModel.result);
      });
    }
  }
}
