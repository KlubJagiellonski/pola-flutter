import 'package:freezed_annotation/freezed_annotation.dart';

part 'scan_event.freezed.dart';

@freezed
class ScanEvent with _$ScanEvent {
  const factory ScanEvent.barcodeScanned(String barcode) = BarcodeScanned;
  const factory ScanEvent.alertDialogDismissed() = AlertDialogDismissed;
}
