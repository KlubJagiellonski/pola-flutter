import 'package:flutter/material.dart';
import 'package:pola_flutter/pages/web/web_view_page.dart';
import 'package:pola_flutter/theme/assets.gen.dart';
import 'package:pola_flutter/theme/colors.dart';
import 'package:pola_flutter/theme/text_size.dart';

showWebViewDialog({required BuildContext context, required String url, required String title}) {
  showDialog(
    context: context,
    useSafeArea: false,
    builder: (context) {
      return _WebViewDialog(url: url, title: title);
    },
  );
}

class _WebViewDialog extends StatelessWidget {
  final String url;
  final String title;

  const _WebViewDialog({Key? key, required this.url, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      minChildSize: 0.3,
      maxChildSize: 1.0,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
          ),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 19.0, right: 17.0, top: 19.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Assets.icLauncher.image(width: 35, height: 35),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: TextSize.newsTitle,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Assets.back.image(width: 32, height: 32),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: WebViewPage(url: url),
              ),
            ],
          ),
        );
      },
    );
  }
}
