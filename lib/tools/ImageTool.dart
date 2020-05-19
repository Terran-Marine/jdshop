import 'package:jdshop/AppConfig.dart';

String formatImageUrl(String url) {
  assert (url.isNotEmpty);
  return "${BASE_URL}${url.replaceAll("\\", "/")}";
}