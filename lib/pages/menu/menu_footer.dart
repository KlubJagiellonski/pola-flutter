import 'package:flutter/widgets.dart';
import 'package:pola_flutter/i18n/strings.g.dart';
import 'package:pola_flutter/pages/menu/version_widget.dart';
import 'package:pola_flutter/theme/fonts.gen.dart';
import 'package:pola_flutter/theme/text_size.dart';

class MenuFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Translations t = Translations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Row(
        children: [
          Text(
            t.menu.footer,
            style: TextStyle(
              fontSize: TextSize.smallTitle,
              fontWeight: FontWeight.w600,
              fontFamily: FontFamily.lato
            ),
          ),
          Expanded(child: Container()),
          VersionWidget(),
        ],
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
      )
    );
  }
}
