import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pola_flutter/models/product_search_response.dart';
import 'package:pola_flutter/models/search_result.dart';

part 'search_state.freezed.dart';

enum SearchRequestState { idle, typing, loading, loadingMore, error }

@freezed
abstract class SearchState with _$SearchState {
  static const minimumQueryLength = 2;

  const SearchState._();

  const factory SearchState({
    @Default('') String query,
    @Default([]) List<ProductSearchItem> results,
    @Default(0) int totalItems,
    String? nextPageToken,
    @Default([]) List<ProductSearchItem> history,
    @Default(SearchRequestState.idle) SearchRequestState requestState,
    @Default(false) bool isOpeningResult,
    ProductSearchItem? openingProduct,
    SearchResult? resultToOpen,
    String? searchErrorMessage,
    String? selectionErrorMessage,
  }) = _SearchState;

  bool get hasQuery => query.trim().isNotEmpty;
  bool get hasSearchableQuery => query.trim().length >= minimumQueryLength;
  bool get hasResults => results.isNotEmpty;
  bool get canLoadMore =>
      hasSearchableQuery &&
      nextPageToken != null &&
      requestState != SearchRequestState.typing &&
      requestState != SearchRequestState.loading &&
      requestState != SearchRequestState.loadingMore;
}
