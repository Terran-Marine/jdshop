import 'package:dio/dio.dart';

import 'package:jdshop/tools/LoggerTool.dart';

final Dio dio = new Dio();

//final CustomInterceptors myInterceptorsWrapper=new CustomInterceptors ();
//
//class CustomInterceptors extends InterceptorsWrapper {
//  @override
//  Future onRequest(RequestOptions options) {
//    logger.info("要求[${options?.method}] => PATH: ${options?.path}");
//    return super.onRequest(options);
//  }
//  @override
//  Future onResponse(Response response) {
//    logger.info("响应[${response?.statusCode}] => PATH: ${response?.request?.path}");
//    return super.onResponse(response);
//  }
//  @override
//  Future onError(DioError err) {
//    logger.severe("网络异常[${err?.response?.statusCode}] => PATH: ${err?.request?.path}");
//    return super.onError(err);
//  }
//}

class NetworkLogInterceptor extends Interceptor {
  NetworkLogInterceptor({
    this.request = true,
    this.requestHeader = true,
    this.requestBody = false,
    this.responseHeader = true,
    this.responseBody = false,
    this.error = true,
  });

  /// Print request [Options]
  bool request;

  /// Print request header [Options.headers]
  bool requestHeader;

  /// Print request data [Options.data]
  bool requestBody;

  /// Print [Response.data]
  bool responseBody;

  /// Print [Response.headers]
  bool responseHeader;

  /// Print error message
  bool error;

  /// Log printer; defaults print log to console.
  /// In flutter, you'd better use debugPrint.
  /// you can also write log in a file, for example:
  ///```dart
  ///  var file=File("./log.txt");
  ///  var sink=file.openWrite();
  ///  dio.interceptors.add(LogInterceptor(logger.info: sink.writeln));
  ///  ...
  ///  await sink.close();
  ///```

  @override
  Future onRequest(RequestOptions options) async {
    logger.info('*** 请求 ***');
    printKV('uri', options.uri);

    if (request) {
      printKV('method', options.method);
      printKV('responseType', options.responseType?.toString());
      printKV('followRedirects', options.followRedirects);
      printKV('connectTimeout', options.connectTimeout);
      printKV('receiveTimeout', options.receiveTimeout);
      printKV('extra', options.extra);
    }
    if (requestHeader) {
      logger.info('headers:');
      options.headers.forEach((key, v) => printKV(' $key', v));
    }
    if (requestBody) {
      logger.info('data:');
      printAll(options.data);
    }
    logger.info('');
  }

  @override
  Future onError(DioError err) async {
    if (error) {
      logger.severe('*** 错误 ***:');
      logger.severe('uri: ${err.request.uri}');
      logger.severe('$err');
      if (err.response != null) {
        _printResponse(err.response);
      }
      logger.severe('');
    }
  }

  @override
  Future onResponse(Response response) async {
    logger.info('*** 响应 ***');
    _printResponse(response);
  }

  void _printResponse(Response response) {
    printKV('uri', response.request?.uri);
    if (responseHeader) {
      printKV('statusCode', response.statusCode);
      if (response.isRedirect == true) {
        printKV('redirect', response.realUri);
      }
      if (response.headers != null) {
        logger.info('headers:');
        response.headers.forEach((key, v) => printKV(' $key', v.join(',')));
      }
    }
    if (responseBody) {
      logger.info('响应 Text:');
      printAll(response.toString());
    }
    logger.info('');
  }

  void printKV(String key, Object v) {
    logger.info('$key: $v');
  }

  void printAll(msg) {
    msg.toString().split('\n').forEach((element) { logger.info(element);});
  }
}
