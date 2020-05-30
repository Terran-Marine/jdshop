import 'dart:convert';
import 'package:crypto/crypto.dart';

String getSign(Map json) {
  List jsonKeys = json.keys.toList();
  jsonKeys.sort();
  StringBuffer sb = new StringBuffer();
  jsonKeys.forEach((element) {
    sb.write("${element}${json[element]}");
  });
  return md5Sting2String(sb.toString());
}

String md5Sting2String(String s) {
  return md5.convert(Utf8Encoder().convert(s)).toString();
}