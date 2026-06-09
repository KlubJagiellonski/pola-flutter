import 'package:flutter/material.dart';

class FlavorBanner extends StatelessWidget {
  const FlavorBanner({required this.flavor, required this.child});

  final String flavor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final banner = switch (flavor.toLowerCase()) {
      'dev' => (message: 'DEV', color: Colors.blue),
      'qa' => (message: 'QA', color: Colors.orange),
      _ => null,
    };

    if (banner == null) return child;

    return Banner(
      message: banner.message,
      location: BannerLocation.topEnd,
      color: banner.color,
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 11,
        fontWeight: FontWeight.w700,
      ),
      child: child,
    );
  }
}
