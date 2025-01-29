import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pola_flutter/models/search_result.dart';

part 'scan_state.freezed.dart';

@freezed
class ScanState with _$ScanState {
  const factory ScanState({
    @Default([]) List<SearchResult> list,
    @Default(false) bool isLoading,
    @Default(false) bool isError,
    @Default(false) bool isTorchOn
  }) = Initial;
}
