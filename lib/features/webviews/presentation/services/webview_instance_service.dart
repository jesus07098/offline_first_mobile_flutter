

import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebControllerSingleton {
  static final WebControllerSingleton _instance = WebControllerSingleton._internal();
  InAppWebViewController? webViewController;

  factory WebControllerSingleton() {
    return _instance;
  }

  WebControllerSingleton._internal();
}