import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:jdshop/tools/LoggerTool.dart';

Map<String,dynamic> getSignParame(Map<String,dynamic> data){
  data["sign"] = getSign(data);
  return data;
}

String getSign(Map json) {
  List jsonKeys = json.keys.toList();
  jsonKeys.sort();
//  logger.info(jsonKeys);
  StringBuffer sb = new StringBuffer();
  jsonKeys.forEach((element) {
    sb.write("${element}${json[element]}");
//    logger.info("${element}${json[element]}");
  });

//  logger.info(sb.toString());
  return md5Sting2String(sb.toString());
}

String md5Sting2String(String s) {
  return md5.convert(Utf8Encoder().convert(s)).toString();
}