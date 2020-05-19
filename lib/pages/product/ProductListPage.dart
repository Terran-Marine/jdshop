import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductListPage extends StatefulWidget {
  Map arguments;

  ProductListPage({Key key, this.arguments}) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey=new GlobalKey();

  int _selectTagIndex = 0;

  @override
  void initState() {
    super.initState();
    print(widget.arguments.toString());
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
          children: <Widget>[
            Expanded(
              flex: 1,
              child: InkWell(
                child: Text(
                  "综合",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color:
                          _selectTagIndex == 0 ? Colors.red : Colors.black54),
                ),
                onTap: () {
                  setState(() {
                    _selectTagIndex = 0;
                  });
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: Text(
                  "销量",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color:
                          _selectTagIndex == 1 ? Colors.red : Colors.black54),
                ),
                onTap: () {
                  setState(() {
                    _selectTagIndex = 1;
                  });
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: Text(
                  "价格",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color:
                          _selectTagIndex == 2 ? Colors.red : Colors.black54),
                ),
                onTap: () {
                  setState(() {
                    _selectTagIndex = 2;
                  });
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: Text(
                  "筛选",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color:
                          _selectTagIndex == 3 ? Colors.red : Colors.black54),
                ),
                onTap: () {
                  _scaffoldKey.currentState.openEndDrawer();
                  setState(() {
                    _selectTagIndex = 3;

                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _productListWidget() {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil().setWidth(50)),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(5),
                right: ScreenUtil().setWidth(5)),
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
                        "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1589879206800&di=7c4e11640f2776ef633682abbd56b7dd&imgtype=0&src=http%3A%2F%2Fimg3.doubanio.com%2Fview%2Fphoto%2Fl%2Fpublic%2Fp2524166120.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding:
                            EdgeInsets.only(left: ScreenUtil().setWidth(5)),
                        height: ScreenUtil().setWidth(110),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              "戴尔(DELL)灵越3670 英特尔酷睿i5 高性能 台式电脑整机(九代i5-9400 8G 256G)",
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
                              "¥990",
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
        },
        itemCount: 20,
      ),
    );
  }
}
