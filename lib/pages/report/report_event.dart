import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_event.freezed.dart';

@freezed
class ReportEvent with _$ReportEvent {
  const factory ReportEvent.submitted(String description) = ReportSubmitted;
  const factory ReportEvent.systemInfoToggled(bool value) = ReportSystemInfoToggled;
  const factory ReportEvent.descriptionChanged() = ReportDescriptionChanged;
}
