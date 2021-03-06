import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdshop/AppConfig.dart';
import 'package:jdshop/model/CateModel.dart';
import 'package:jdshop/pages/product/ProductListPage.dart';
import 'package:jdshop/tools/HttpTool.dart';
import 'package:jdshop/tools/ImageTool.dart';
import 'package:jdshop/widget/MainAppBarWidget.dart';
import 'package:nav_router/nav_router.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  List<CateItemModel> cateItemList = [];
  List<CateItemModel> cate2ItemList = [];

  int _selectIndex = 0;
  String _selectCateId = "";

  @override
  void initState() {
    super.initState();
    _getCateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBarWidget(),
      body: Row(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: ScreenUtil().setWidth(140),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return InkWell(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Center(
                          child: Text(
                            "${cateItemList[index].title}",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        width: double.infinity,
                        height: ScreenUtil().setHeight(80),
                        color: index == _selectIndex
                            ? Color.fromRGBO(240, 246, 246, 0.9)
                            : Colors.white,
                      ),
                      Divider(
                        color: Color.fromRGBO(240, 246, 246, 0.9),
                        height: 1,
                      )
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      _selectIndex = index;
                      _selectCateId = cateItemList[index].sId;
                      _getIndexPListData();
                    });
                  },
                );
              },
              itemCount: cateItemList.length,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(5),
                  right: ScreenUtil().setWidth(5)),
              height: double.infinity,
              color: Color.fromRGBO(240, 246, 246, 0.9),
              child: GridView.builder(
                  padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(10),
                      bottom: ScreenUtil().setHeight(10)),
                  itemCount: cate2ItemList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, childAspectRatio: 1 / 1.3),
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: Container(
                        padding: EdgeInsets.only(
                            left: ScreenUtil().setWidth(5),
                            right: ScreenUtil().setWidth(5)),
                        child: Column(
                          children: <Widget>[
                            AspectRatio(
                              aspectRatio: 1 / 1.1,
                              child: Image.network(
                                formatImageUrl(cate2ItemList[index].pic),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(cate2ItemList[index].title),
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        routePush(
                          ProductListPage(
                              arguments: {"cid": cate2ItemList[index].sId}),
                        );
//                      Navigator.pushNamed(context, '/productList',
//                          arguments: {"cid": cate2ItemList[index].sId});
                      },
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }

  _getCateData() async {
    Response respons = await dio.get(API_PCATE);
    if (respons.statusCode == 200) {
      CateModel cateModel = CateModel.fromJson(respons.data);
      cateItemList.clear();
      cateItemList = cateModel.result;

      setState(() {
        _selectIndex = 0;
        _selectCateId = cateItemList[0].sId;
        _getIndexPListData();
      });
    }
  }

  _getIndexPListData() async {
    if (_selectCateId.isNotEmpty) {
      Response respons =
          await dio.get(API_PCATE, queryParameters: {"pid": _selectCateId});
//      print(respons.data);
      if (respons.statusCode == 200) {
        CateModel cateModel = CateModel.fromJson(respons.data);
        setState(() {
          cate2ItemList = cateModel.result;
        });
      }
    }
  }

  @override
  bool get wantKeepAlive => true;
}
