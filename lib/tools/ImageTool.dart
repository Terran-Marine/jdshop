import 'package:jdshop/AppConfig.dart';

String formatImageUrl(String url) {
  if(url==null||url.isEmpty){
    return "";
  }
  return "${BASE_URL}${url.replaceAll("\\", "/")}";
}