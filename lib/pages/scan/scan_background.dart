import 'package:flutter/material.dart';
import 'package:pola_flutter/theme/colors.dart';

class ScanBackground extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
     return 
     Positioned.fill(
          child:
           Row(
            children: [
              _BlackOpacity(),
              Column(
                children: [
                  _BlackOpacity(),
                  _RedRectangle(),
                  _BlackOpacity(),
                ],
              ),
              _BlackOpacity(),
            ]
          )
     );
  }
}

class _BlackOpacity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: AppColors.text.withOpacity(0.9),
      ),
    );
  }
}

class _RedRectangle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
 return Container(
      width: 250,
      height: 187,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red, width: 2),
        borderRadius: BorderRadius.circular(15), // Zaokrąglenie narożników
      ),
    );
  }
}
