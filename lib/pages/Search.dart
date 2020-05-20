import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdshop/widget/JdText.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
              left: ScreenUtil().setWidth(10),
              right: ScreenUtil().setWidth(10)),
          decoration: BoxDecoration(
              color: Color.fromRGBO(233, 233, 233, 0.8),
              borderRadius: BorderRadius.circular(30)),
          height: ScreenUtil().setHeight(68),
          child: TextField(
            maxLines: 1,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none)),
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
            onTap: () {},
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
                child: Icon(Icons.delete,size: 26,),
                onTap: (){
                  print("清空记录");
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
            child: ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      Text(
                        "lt-432",
                        textAlign: TextAlign.start,
                      ),
                      Divider()
                    ],
                  );
                }),
          ),
        )
      ],
    );
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
}
