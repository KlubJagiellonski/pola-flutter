import 'package:flutter/material.dart';
import 'package:pola_flutter/theme/assets.gen.dart';

class TorchButton extends StatelessWidget {
  final bool isTorchOn;
  final VoidCallback onTap;

  TorchButton({required this.isTorchOn, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [],
        ),
        child: isTorchOn
            ? Assets.scan.flashlightOn.svg()
            : Assets.scan.flashlightOff.svg(),
      ),
    );
  }
}
