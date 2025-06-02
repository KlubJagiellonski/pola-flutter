import 'package:flutter/material.dart';
import 'package:pola_flutter/theme/assets.gen.dart';
import 'package:pola_flutter/theme/colors.dart';

class ScanBackground extends StatefulWidget {
  @override
  State<ScanBackground> createState() => _ScanBackgroundState();
}

class _ScanBackgroundState extends State<ScanBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scanAreaSize = 250.0;
    final screenHeight = MediaQuery.of(context).size.height;
    final scanAreaTop = screenHeight / 2 - scanAreaSize / 2;

    final laserTopLimit = scanAreaTop + 16;
    final laserBottomLimit = scanAreaTop + scanAreaSize - 85;

    return Stack(
      children: [
        Column(
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
        ),
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            final laserTop = laserTopLimit +
                _animation.value * (laserBottomLimit - laserTopLimit);
            return Positioned(
              top: laserTop,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: scanAreaSize,
                  height: 2,
                  color: AppColors.defaultRed,
                ),
              ),
            );
          },
        ),
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
          color: AppColors.text.withValues(alpha: 0.7),
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
        color: AppColors.text.withValues(alpha: 0.7),
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
