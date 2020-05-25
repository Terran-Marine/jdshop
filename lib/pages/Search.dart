import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdshop/tools/DialogTool.dart';
import 'package:jdshop/tools/SharedPreferencesTool.dart';
import 'package:nav_router/nav_router.dart';
import 'package:jdshop/pages/product/ProductListPage.dart';
import 'package:nav_router/src/util.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _refreshHistoryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        title: Container(
//          child: TextField(
//            autofocus: true,
//            decoration: InputDecoration(
//                border: OutlineInputBorder(
//                    borderRadius: BorderRadius.circular(30),
//                    borderSide: BorderSide.none)),
//          ),
//          height: ScreenUtil().setHeight(68),
//          decoration: BoxDecoration(
//              color: Color.fromRGBO(233, 233, 233, 0.8),
//              borderRadius: BorderRadius.circular(30)),
//        ),
        title: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(15),
              right: ScreenUtil().setWidth(15)),
          decoration: BoxDecoration(
              color: Color.fromRGBO(233, 233, 233, 0.8),
              borderRadius: BorderRadius.circular(30)),
          height: ScreenUtil().setHeight(68),
          child: TextField(
            textInputAction: TextInputAction.search,
            onSubmitted: (keyWord) {
              _searchProduct(keyWord);
            },
            controller: _searchController,
            maxLines: 1,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0),
                border: OutlineInputBorder(borderSide: BorderSide.none)),
          ),
        ),
        actions: <Widget>[
          InkWell(
            child: Container(
              height: ScreenUtil().setWidth(60),
              width: ScreenUtil().setWidth(68),
              child: Center(
                child: Text(
                  "搜索",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            onTap: () {
              _searchProduct(_searchController.text);
            },
          )
        ],
      ),
      body: Center(
        child: _searchContent(),
      ),
    );
  }

  Widget _searchContent() {
    return ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
              left: ScreenUtil().setWidth(10), top: ScreenUtil().setWidth(10)),
          child: Text("热搜"),
        ),
        Divider(),
        Wrap(
          children: _hotListWidget(),
        ),
        Container(
          height: ScreenUtil().setWidth(20),
          child: Column(
            children: <Widget>[
              Container(
                height: ScreenUtil().setWidth(1),
                color: Colors.black54,
              ),
              Expanded(
                child: Container(
                  color: Colors.grey,
                ),
              ),
              Container(
                height: ScreenUtil().setWidth(1),
                color: Colors.black54,
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: ScreenUtil().setWidth(10), top: ScreenUtil().setWidth(10)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("历史"),
              Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              InkWell(
                child: Icon(
                  Icons.delete,
                  size: 26,
                ),
                onTap: () {
                  SharedPreferencesTool.getInstance()
                      .cleanStringList(SEARCH_HISTORY);
                  setState(() {
                    searchHistoryList.clear();
                  });
                },
              ),
              SizedBox(
                width: ScreenUtil().setWidth(6),
              )
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            child: searchHistoryList.length > 0
                ? ListView.builder(
                    itemCount: searchHistoryList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onLongPress: () {
                            ConfirmCancelDialog(
                                context, "确认删除 ${searchHistoryList[index]} ",
                                () {
                              _removeHistoryData(searchHistoryList[index]);
                            }, () {});
                          },
                          child: Column(
                            children: <Widget>[
                              Text(
                                searchHistoryList[index],
                                textAlign: TextAlign.start,
                              ),
                              Divider()
                            ],
                          ));
                    })
                : Center(
                    child: Text("暂无搜索数据"),
                  ),
          ),
        )
      ],
    );
  }

  List<String> searchHistoryList = [];

  _removeHistoryData(String keyWord) {
    SharedPreferencesTool spt = SharedPreferencesTool.getInstance();

    if (spt.removeStringList(SEARCH_HISTORY, keyWord)) {
      setState(() {
        searchHistoryList.remove(keyWord);
      });
    }
  }

  _refreshHistoryData() {
    SharedPreferencesTool spt = SharedPreferencesTool.getInstance();

    List<String> temp = spt.getStringList(SEARCH_HISTORY);
    if (temp != null && temp.length != 0) {
      setState(() {
        searchHistoryList = spt.getStringList(SEARCH_HISTORY);
      });
    }
  }

  List<Widget> _hotListWidget() {
    List<Widget> temp = [];

    for (int i = 0; i < 9; i++) {
      temp.add(Container(
        margin: EdgeInsets.only(
          left: ScreenUtil().setWidth(8),
          right: ScreenUtil().setWidth(8),
          bottom: ScreenUtil().setWidth(10),
        ),
        padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(10),
          top: ScreenUtil().setWidth(5),
          right: ScreenUtil().setWidth(10),
          bottom: ScreenUtil().setWidth(5),
        ),
        decoration: BoxDecoration(
            color: Color.fromRGBO(233, 233, 233, 0.9),
            borderRadius: BorderRadius.circular(18)),
        child: Text("EBR75"),
      ));
    }

    return temp;
  }

  //搜索跳转
  void _searchProduct(String keyWord) {
//    removeRoute(routerUtil(type:RouterType.cupertino,widget:ProductListPage(arguments:{"search": keyWord})));
    SharedPreferencesTool.getInstance().addStringList(SEARCH_HISTORY, keyWord);

    pop();
    routePush(
      ProductListPage(arguments: {"search": keyWord}),
    );
  }
}
