import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductContentHome extends StatefulWidget {
  @override
  _ProductContentHomeState createState() => _ProductContentHomeState();
}

class _ProductContentHomeState extends State<ProductContentHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              "https://oimagea7.ydstatic.com/image?id=2223816700015246366&product=adpublish",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
            child: Text(
              "所有服务已兑换为 Trojan 版本，请使用支持 Trojan 协议的客户端重新设置服务器信息。设置指南请访问：https://portal.shadowsocks.nz/knowledgebase/151/",
              style: TextStyle(color: Colors.black87, fontSize: 18),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
            child: Text(
              "所有服务已兑换为 Trojan 版本，请使用支持 Trojan 协议的客户端重新设置服务器信息。设置指南请访问：https://portal.shadowsocks.nz/knowledgebase/151/",
              style: TextStyle(color: Colors.black38, fontSize: 12),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "原价:",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough),
                ),
                Text(
                  "￥9999999",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Text(
                  "特价:",
                  style: TextStyle(fontSize: 20, color: Colors.red),
                ),
                Text(
                  "￥0.01",
                  style: TextStyle(fontSize: 20, color: Colors.red),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
            child: InkWell(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "已选:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Text(
                    "115,heise,xl,1建",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              onTap: () {},
            ),
          ),
          Divider(),
          Container(
            margin: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "运费:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text(
                  "免运费",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          Divider()
        ],
      ),
      padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
    );
  }
}
