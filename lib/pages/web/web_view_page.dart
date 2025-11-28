import 'package:flutter/material.dart';
import 'package:pola_flutter/theme/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  WebViewPage({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  WebViewPageState createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  late final WebViewController controller;

  var loadingPercentage = 0;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(onProgress: (int progress) {
          setState(() {
            loadingPercentage = progress;
          });
        }, onPageStarted: (String url) {
          setState(() {
            loadingPercentage = 0;
          });
        }, onPageFinished: (String url) {
          setState(() {
            loadingPercentage = 100;
          });
        }),
      )
      ..setBackgroundColor(AppColors.white)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  void didUpdateWidget(WebViewPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    controller.loadRequest(Uri.parse(widget.url));
  }

  void _handlePopInvokedWithResult(bool didPop, dynamic result) async {
    if (!didPop) {
      final canGoBack = await controller.canGoBack();
      if (canGoBack) {
        await controller.goBack();
      } else {
        if (mounted && context.mounted) {
          Navigator.of(context).pop();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: _handlePopInvokedWithResult,
      child: Stack(
        children: [
          WebViewWidget(controller: controller),
          if (loadingPercentage < 100)
            LinearProgressIndicator(
              value: loadingPercentage / 100.0,
            ),
        ],
      ),
    );
  }
}
