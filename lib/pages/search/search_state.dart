import 'package:equatable/equatable.dart';
import 'package:pola_flutter/models/product_search_response.dart';
import 'package:pola_flutter/models/search_result.dart';

enum SearchRequestState { idle, typing, loading, loadingMore, error }

class SearchState extends Equatable {
  static const minimumQueryLength = 2;
  static const _unset = Object();

  final String query;
  final List<ProductSearchItem> results;
  final int totalItems;
  final String? nextPageToken;
  final List<ProductSearchItem> history;
  final SearchRequestState requestState;
  final bool isOpeningResult;
  final ProductSearchItem? openingProduct;
  final SearchResult? resultToOpen;
  final String? searchErrorMessage;
  final String? selectionErrorMessage;

  const SearchState({
    this.query = '',
    this.results = const [],
    this.totalItems = 0,
    this.nextPageToken,
    this.history = const [],
    this.requestState = SearchRequestState.idle,
    this.isOpeningResult = false,
    this.openingProduct,
    this.resultToOpen,
    this.searchErrorMessage,
    this.selectionErrorMessage,
  });

  bool get hasQuery => query.trim().isNotEmpty;
  bool get hasSearchableQuery => query.trim().length >= minimumQueryLength;
  bool get hasResults => results.isNotEmpty;
  bool get canLoadMore =>
      hasSearchableQuery &&
      nextPageToken != null &&
      requestState != SearchRequestState.typing &&
      requestState != SearchRequestState.loading &&
      requestState != SearchRequestState.loadingMore;

  SearchState copyWith({
    String? query,
    List<ProductSearchItem>? results,
    int? totalItems,
    Object? nextPageToken = _unset,
    List<ProductSearchItem>? history,
    SearchRequestState? requestState,
    bool? isOpeningResult,
    Object? openingProduct = _unset,
    Object? resultToOpen = _unset,
    Object? searchErrorMessage = _unset,
    Object? selectionErrorMessage = _unset,
  }) {
    return SearchState(
      query: query ?? this.query,
      results: results ?? this.results,
      totalItems: totalItems ?? this.totalItems,
      nextPageToken: identical(nextPageToken, _unset)
          ? this.nextPageToken
          : nextPageToken as String?,
      history: history ?? this.history,
      requestState: requestState ?? this.requestState,
      isOpeningResult: isOpeningResult ?? this.isOpeningResult,
      openingProduct: identical(openingProduct, _unset)
          ? this.openingProduct
          : openingProduct as ProductSearchItem?,
      resultToOpen: identical(resultToOpen, _unset)
          ? this.resultToOpen
          : resultToOpen as SearchResult?,
      searchErrorMessage: identical(searchErrorMessage, _unset)
          ? this.searchErrorMessage
          : searchErrorMessage as String?,
      selectionErrorMessage: identical(selectionErrorMessage, _unset)
          ? this.selectionErrorMessage
          : selectionErrorMessage as String?,
    );
  }

  @override
  List<Object?> get props => [
    query,
    results,
    totalItems,
    nextPageToken,
    history,
    requestState,
    isOpeningResult,
    openingProduct,
    resultToOpen,
    searchErrorMessage,
    selectionErrorMessage,
  ];

  @override
  String toString() {
    return 'SearchState('
        'query: $query, '
        'requestState: $requestState, '
        'results: ${results.length}, '
        'totalItems: $totalItems, '
        'hasNextPage: ${nextPageToken != null}, '
        'history: ${history.length}, '
        'isOpeningResult: $isOpeningResult, '
        'openingProductCode: ${openingProduct?.code}, '
        'hasResultToOpen: ${resultToOpen != null}, '
        'hasSearchError: ${searchErrorMessage != null}, '
        'hasSelectionError: ${selectionErrorMessage != null}'
        ')';
  }
}
