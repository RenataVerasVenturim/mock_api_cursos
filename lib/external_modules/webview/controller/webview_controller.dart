import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../utils/ui_components/custom_alert_dialog.dart';
//import '../../../utils/ui_components/uri_launcher_helper.dart';

class ActivityWebViewController extends GetxController {
  void goDocPage() {
    customAlertDialog(Get.context!, title: 'page_under_development'.tr).show();
  }

  late final String url;
  late final String title;

  RxBool isLoading = true.obs;
  late WebViewController wvc;

  @override
  void onInit() {
    super.onInit();

    url = Get.arguments['url'];
    title = Get.arguments['title'];

    wvc = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => isLoading.value = true,
          onPageFinished: (_) => isLoading.value = false,
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  Future<bool> onExit() async {
    if (await wvc.canGoBack()) {
      wvc.goBack();
      return false;
    }
    return true;
  }
}
