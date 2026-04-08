import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_state.freezed.dart';

enum ReportRequestState {
  idle,
  loading,
  success,
  error,
  emptyDescription
}

@freezed
abstract class ReportState with _$ReportState {
  const factory ReportState({
    @Default(ReportRequestState.idle) ReportRequestState requestState,
    @Default('') String description,
    @Default(false) bool attachSystemInfo,
  }) = Initial;
}
