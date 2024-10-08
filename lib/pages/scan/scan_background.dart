import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pola_flutter/theme/colors.dart';

class ScanBackground extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
     return Positioned.fill(
          child: Container(
            color: AppColors.text.withOpacity(0.5),
          ),
      );
  }
}