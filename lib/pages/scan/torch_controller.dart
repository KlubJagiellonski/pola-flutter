import 'package:mobile_scanner/mobile_scanner.dart';

abstract class TorchController {
  void toggleTorch();
}

class TorchControllerImpl implements TorchController {
  final MobileScannerController _cameraController;

  TorchControllerImpl({required MobileScannerController cameraController})
      : _cameraController = cameraController;

  @override
  void toggleTorch() {
    _cameraController.toggleTorch();
  }
}
