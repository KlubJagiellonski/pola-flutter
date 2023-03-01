import 'package:vibration/vibration.dart';

abstract class ScanVibration {
  void vibrate();
}

class ScanVibrationImpl implements ScanVibration {
  @override
  void vibrate() {
    Vibration.vibrate(duration: 200);
  }
}
