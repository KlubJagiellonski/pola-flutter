import 'package:equatable/equatable.dart';
import 'package:pola_flutter/models/product_search_response.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchStarted extends SearchEvent {
  const SearchStarted();
}

class SearchQueryChanged extends SearchEvent {
  final String query;

  const SearchQueryChanged(this.query);

  @override
  List<Object?> get props => [query];
}

class SearchRetryRequested extends SearchEvent {
  const SearchRetryRequested();
}

class SearchNextPageRequested extends SearchEvent {
  const SearchNextPageRequested();
}

class SearchProductSelected extends SearchEvent {
  final ProductSearchItem product;

  const SearchProductSelected(this.product);

  @override
  List<Object?> get props => [product];
}

class SearchResultOpened extends SearchEvent {
  const SearchResultOpened();
}

class SearchSelectionErrorShown extends SearchEvent {
  const SearchSelectionErrorShown();
}

class SearchHistoryCleared extends SearchEvent {
  const SearchHistoryCleared();
}

class SearchRequested extends SearchEvent {
  final String query;

  const SearchRequested(this.query);

  @override
  List<Object?> get props => [query];
}
