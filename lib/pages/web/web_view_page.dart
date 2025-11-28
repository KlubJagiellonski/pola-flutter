import 'package:flutter/material.dart';
import 'package:pola_flutter/theme/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  WebViewPage({Key? key, required this.url, this.canGoBackNotifier})
      : super(key: key);

  final String url;
  final ValueNotifier<bool>? canGoBackNotifier;

  @override
  WebViewPageState createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  late final WebViewController controller;

  var loadingPercentage = 0;
  ValueNotifier<bool>? _internalCanGoBackNotifier;

  ValueNotifier<bool> get _canGoBackNotifier =>
      widget.canGoBackNotifier ??
      (_internalCanGoBackNotifier ??= ValueNotifier<bool>(false));

  void popToRootPage() async {
    while (await controller.canGoBack()) {
      await controller.goBack();
    }
    _updateCanGoBack();
  }

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
          _updateCanGoBack();
        }, onPageFinished: (String url) {
          setState(() {
            loadingPercentage = 100;
          });
          _updateCanGoBack();
        }),
      )
      ..setBackgroundColor(AppColors.white)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  void didUpdateWidget(WebViewPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateCanGoBack();
  }

  @override
  void dispose() {
    _internalCanGoBackNotifier?.dispose();
    super.dispose();
  }

  Future<void> _updateCanGoBack() async {
    final canGoBack = await controller.canGoBack();
    if (!mounted) {
      return;
    }
    if (_canGoBackNotifier.value != canGoBack) {
      _canGoBackNotifier.value = canGoBack;
    }
  }

  void _handlePopInvokedWithResult(bool didPop, dynamic result) async {
    if (!didPop) {
      final canGoBack = await controller.canGoBack();
      if (canGoBack) {
        await controller.goBack();
        _updateCanGoBack();
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
