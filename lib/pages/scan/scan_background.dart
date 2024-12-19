import 'package:flutter/material.dart';
import 'package:pola_flutter/theme/assets.gen.dart';
import 'package:pola_flutter/theme/colors.dart';

class ScanBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _BlackOpacity(),
        Row(
          children: [
            _SizedBlackOpacity(),
            _RedRectangle(),
            _SizedBlackOpacity(),
          ],
        ),
        _BlackOpacity(),
      ],
    );
  }
}

class _SizedBlackOpacity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 187,
        child: Container(
          color: getColorWithOpacity(AppColors.text, 0.7),
        ),
      ),
    );
  }
}

class _BlackOpacity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: getColorWithOpacity(AppColors.text, 0.7),
      ),
    );
  }
}

class _RedRectangle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Assets.menuPage.rectangle.svg();
  }
}

Color getColorWithOpacity(Color color, double opacity) {
  return color.withAlpha((opacity * 255).toInt());
}
