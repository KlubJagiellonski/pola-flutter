import 'package:flutter/material.dart';
import 'package:pola_flutter/theme/colors.dart';

class CircleCheckbox extends StatelessWidget {
  final bool checked;

  const CircleCheckbox({super.key, required this.checked});

  @override
  Widget build(BuildContext context) {
    final color = checked ? AppColors.defaultRed : AppColors.inactive;
    return Container(
      width: 20.0,
      height: 20.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 1.5),
      ),
      child: checked
          ? const Icon(Icons.check, size: 13.0, color: AppColors.defaultRed)
          : null,
    );
  }
}
