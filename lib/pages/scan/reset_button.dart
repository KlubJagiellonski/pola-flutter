import 'package:flutter/material.dart';
import 'package:pola_flutter/theme/assets.gen.dart';

class ResetButton extends StatelessWidget {
  final VoidCallback onTap;

  const ResetButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(boxShadow: []),
        child: Assets.scan.historyButton.svg(),
      ),
    );
  }
}
