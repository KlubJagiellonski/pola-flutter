import 'package:flutter/material.dart';
import 'package:pola_flutter/theme/assets.gen.dart';
import 'package:pola_flutter/theme/colors.dart';

const double _rectangleHeight = 187.0;

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
        height: _rectangleHeight,
        child: _BlackContainer(),
      ),
    );
  }
}

class _BlackOpacity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(child: _BlackContainer());
  }
}

class _BlackContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.text.withValues(alpha: 0.7),
    );
  }
}

class _RedRectangle extends StatefulWidget {
  @override
  State<_RedRectangle> createState() => _RedRectangleState();
}

class _RedRectangleState extends State<_RedRectangle>
    with SingleTickerProviderStateMixin {
  static const double _verticalMargin = 16.0;

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
    return Stack(
      children: [
        Assets.menuPage.rectangle.svg(),
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            final laserTop = _verticalMargin +
                _animation.value * (_rectangleHeight - _verticalMargin * 2);
            return Positioned(
              top: laserTop,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
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
