import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewTabPage extends StatefulWidget {
  WebViewTabPage({Key? key, required this.title, required this.url})
      : super(key: key);

  final String url;
  final String title;

  @override
  _WebViewTabState createState() => _WebViewTabState();
}

class _WebViewTabState extends State<WebViewTabPage> {
  late final WebViewController controller;

  var loadingPercentage = 0;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              setState(() {
                loadingPercentage = progress;
              });
            },
            onPageStarted: (String url) {
              setState(() {
                loadingPercentage = 0;
              });              
            },
            onPageFinished: (String url) {
              setState(() {
                loadingPercentage = 100;
              });
            },
            onWebResourceError: (WebResourceError error) {},
            onNavigationRequest: (NavigationRequest request) {
               return NavigationDecision.navigate;
            },
          ),
        )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  void didUpdateWidget(WebViewTabPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    controller.loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(widget.title,
              style: TextStyle(
                color: Colors.black,
              )),
        ),
        body: Stack(
        children: [
          WebViewWidget(controller: controller),
          if (loadingPercentage < 100)
            LinearProgressIndicator(
              value: loadingPercentage / 100.0,
            ),
        ],
      )
    );
  }
}
