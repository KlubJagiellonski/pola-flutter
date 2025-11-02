import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pola_flutter/models/replacement.dart';
import 'package:pola_flutter/models/search_result.dart';

part 'replacement_state.freezed.dart';

@freezed
class ReplacementState with _$ReplacementState {
  const factory ReplacementState({
    @Default({}) Map<String, SearchResult> results,
    Replacement? loadingReplacement,
    SearchResult? resultToPush,
    @Default(false) bool isError,
    String? errorMessage,
  }) = Initial;
}
