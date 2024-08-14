import 'package:flutter/material.dart';
import 'package:pola_flutter/pages/web/web_view_page.dart';
import 'package:pola_flutter/theme/colors.dart';
import 'package:pola_flutter/theme/fonts.gen.dart';

class WebViewTab extends StatelessWidget {
  final String title;
  final String url;

  WebViewTab({Key? key, required this.title, required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontFamily: FontFamily.lato,
            color: AppColors.textColor,
          ),
        ),
      ),
      body: Center(
        child: WebViewPage(url: url),
      ),
    );
  }
}
