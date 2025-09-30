import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../controller/webview_controller.dart';
import 'package:flutter/material.dart';

class ActivityWebViewPage extends StatelessWidget {
  const ActivityWebViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ActivityWebViewController>(
      init: ActivityWebViewController(), // aqui não precisa passar nada
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(controller.title),
          ),
          body: Stack(
            children: [
              WebViewWidget(controller: controller.wvc),
              Obx(() => controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : const SizedBox.shrink()),
            ],
          ),
        );
      },
    );
  }
}
