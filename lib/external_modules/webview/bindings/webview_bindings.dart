import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../controller/webview_controller.dart';

class WebViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebViewController>(() => WebViewController());
  }
}