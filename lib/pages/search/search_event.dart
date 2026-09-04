import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pola_flutter/models/product_search_response.dart';

part 'search_event.freezed.dart';

@freezed
sealed class SearchEvent with _$SearchEvent {
  const factory SearchEvent.started() = SearchStarted;
  const factory SearchEvent.queryChanged(String query) = SearchQueryChanged;
  const factory SearchEvent.retryRequested() = SearchRetryRequested;
  const factory SearchEvent.nextPageRequested() = SearchNextPageRequested;
  const factory SearchEvent.productSelected(ProductSearchItem product) =
      SearchProductSelected;
  const factory SearchEvent.resultOpened() = SearchResultOpened;
  const factory SearchEvent.selectionErrorShown() = SearchSelectionErrorShown;
  const factory SearchEvent.historyCleared() = SearchHistoryCleared;
  const factory SearchEvent.requested(String query) = SearchRequested;
}
