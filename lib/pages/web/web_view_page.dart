import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  WebViewPage({Key? key, required this.title, required this.url, required this.showBackButton})
      : super(key: key);

  final String url;
  final String title;
  final bool showBackButton;

  @override
  _WebViewTabState createState() => _WebViewTabState();
}

class _WebViewTabState extends State<WebViewPage> {
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
            }
          ),
        )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  void didUpdateWidget(WebViewPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    controller.loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            widget.title,
            style: TextStyle(
              color: Colors.black,
            )
          ),
          leading: widget.showBackButton  ? _BackButton() : null,

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

class _BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}
