import 'dart:async';
import 'dart:io';
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
  late WebViewController _webViewController;

  var loadingPercentage = 0;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  void didUpdateWidget(WebViewTabPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    _webViewController.loadUrl(widget.url);
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
          WebView(
            initialUrl: widget.url,
            onWebViewCreated: (controller) {
              _webViewController = controller;
            },
            onPageStarted: (url) {
              setState(() {
                loadingPercentage = 0;
              });
            },
            onProgress: (progress) {
              setState(() {
                loadingPercentage = progress;
              });
            },
            onPageFinished: (url) {
              setState(() {
                loadingPercentage = 100;
              });
            },
          ),
          if (loadingPercentage < 100)
            LinearProgressIndicator(
              value: loadingPercentage / 100.0,
            ),
        ],
      )
    );
  }
}
