import 'package:api_flutter_project/utils/color_pallete.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../controller/webview_controller.dart';
import 'package:flutter/material.dart';

class WebViewPage extends StatelessWidget {
  const WebViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ActivityWebViewController>(
      init: ActivityWebViewController(), 
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
              backgroundColor: AppColors.darkBlue(),
              foregroundColor: Colors.white,
              automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 IconButton(onPressed: () async {
                    if (await controller.wvc.canGoBack()) {
                      controller.wvc.goBack();
                    } else {
                      Get.back();
                    }
                  }, icon: const Icon(Icons.arrow_back)),
                  Expanded(child: Center(child: Text('Inscrição na atividade'))),
                  IconButton(onPressed: () {Get.back();}, icon: const Icon(Icons.close)),                  
                  //controller.interrogation? IconButton(onPressed: (){controller.goDocPage();}, icon: const Icon(Icons.question_mark, color: Colors.white,)) : const SizedBox(width: 0,),                
              ],
            ),
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
