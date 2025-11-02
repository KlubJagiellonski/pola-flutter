import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pola_flutter/models/replacement.dart';
import 'package:pola_flutter/models/search_result.dart';

part 'replacement_state.freezed.dart';

@freezed
class ReplacementState with _$ReplacementState {
  const factory ReplacementState({
    @Default(false) bool isLoading,
    SearchResult? result,
    Replacement? currentReplacement,
    @Default(false) bool isError,
    String? errorMessage,
  }) = Initial;
}
