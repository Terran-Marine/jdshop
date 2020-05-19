import 'package:dio/dio.dart';

final Dio dio =new Dio();

final CustomInterceptors myInterceptorsWrapper=new CustomInterceptors ();

class CustomInterceptors extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) {
    print("要求[${options?.method}] => PATH: ${options?.path}");
    return super.onRequest(options);
  }
  @override
  Future onResponse(Response response) {
    print("响应[${response?.statusCode}] => PATH: ${response?.request?.path}");
    return super.onResponse(response);
  }
  @override
  Future onError(DioError err) {
    print("网络异常[${err?.response?.statusCode}] => PATH: ${err?.request?.path}");
    return super.onError(err);
  }
}