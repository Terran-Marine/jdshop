import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jdshop/AppConfig.dart';
import 'package:jdshop/tools/LoggerTool.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProductContentDesc extends StatefulWidget {
 final String productId;

  ProductContentDesc(this.productId);

  @override
  _ProductContentDescState createState() => _ProductContentDescState();
}

class _ProductContentDescState extends State<ProductContentDesc> with AutomaticKeepAliveClientMixin{
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: "${HTML_PCONTENT}${widget.productId}",
      javascriptMode: JavascriptMode.disabled,
      onWebViewCreated: (WebViewController webViewController) {
        _controller.complete(webViewController);
      },
      onPageStarted: (String url) {
        logger.info('Page started loading: $url');
      },
      onPageFinished: (String url) {
        logger.info('Page finished loading: $url');
      },
      onWebResourceError: (WebResourceError e){
        logger.info('Err:  ${e.description}\n${e.domain}');
      },
    );
  }

  @override
  bool get wantKeepAlive =>true;
}
