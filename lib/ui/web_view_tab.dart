import 'package:flutter/material.dart';
import 'package:pola_flutter/pages/web/web_view_page.dart';
import 'package:pola_flutter/theme/colors.dart';
import 'package:pola_flutter/theme/fonts.gen.dart';

class WebViewTab extends StatefulWidget {
  final String title;
  final String url;
  /// Optional key to access the [WebViewPageState] from outside, for example to call [WebViewPageState.popToRootPage].
  final GlobalKey<WebViewPageState>? pageKey;

  WebViewTab({Key? key, required this.title, required this.url, this.pageKey})
      : super(key: key);

  @override
  State<WebViewTab> createState() => _WebViewTabState();
}

class _WebViewTabState extends State<WebViewTab> {
  late final ValueNotifier<bool> canGoBackNotifier;

  @override
  void initState() {
    super.initState();
    canGoBackNotifier = ValueNotifier<bool>(false);
  }

  @override
  void dispose() {
    canGoBackNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: ValueListenableBuilder<bool>(
          valueListenable: canGoBackNotifier,
          builder: (context, canGoBack, _) {
            return AppBar(
              automaticallyImplyLeading: false,
              leading: (canGoBack || Navigator.of(context).canPop()) ? BackButton() : null,
              title: Text(
                widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: FontFamily.lato,
                  color: AppColors.text,
                ),
              ),
            );
          },
        ),
      ),
      body: Center(
        child: WebViewPage(
          key: widget.pageKey,
          url: widget.url,
          canGoBackNotifier: canGoBackNotifier,
        ),
      ),
    );
  }
}
