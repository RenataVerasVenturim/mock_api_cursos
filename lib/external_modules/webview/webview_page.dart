import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ActivityWebViewPage extends StatefulWidget {
  final String url;
  final String titulo;

  const ActivityWebViewPage({
    super.key,
    required this.url,
    required this.titulo,
  });

  @override
  State<ActivityWebViewPage> createState() => _ActivityWebViewPageState();
}

class _ActivityWebViewPageState extends State<ActivityWebViewPage> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) => setState(() => _isLoading = true),
          onPageFinished: (url) => setState(() => _isLoading = false),
          onNavigationRequest: (request) => NavigationDecision.navigate,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titulo),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
