import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pola_flutter/data/api_response.dart';
import 'package:pola_flutter/data/pola_api_repository.dart';
import 'package:pola_flutter/data/product_search_history_service.dart';
import 'package:pola_flutter/models/product_search_response.dart';
import 'package:pola_flutter/pages/search/search_event.dart';
import 'package:pola_flutter/pages/search/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final PolaApi _repository;
  final ProductSearchHistoryStore _historyStore;
  final Duration _debounceDuration;
  final Map<String, _CachedSearchResults> _resultsCache = {};
  Timer? _debounceTimer;
  bool _paginationInFlight = false;
  int _queuedPaginationRequestsToIgnore = 0;

  SearchBloc(
    this._repository,
    this._historyStore, {
    Duration debounceDuration = const Duration(milliseconds: 500),
  }) : _debounceDuration = debounceDuration,
       super(const SearchState()) {
    on<SearchStarted>(_onStarted);
    on<SearchQueryChanged>(_onQueryChanged);
    on<SearchRequested>(_onSearchRequested);
    on<SearchRetryRequested>(_onRetryRequested);
    on<SearchNextPageRequested>(_onNextPageRequested);
    on<SearchProductSelected>(_onProductSelected);
    on<SearchResultOpened>(_onResultOpened);
    on<SearchSelectionErrorShown>(_onSelectionErrorShown);
    on<SearchHistoryCleared>(_onHistoryCleared);
  }

  List<ProductSearchItem> filterHistory(String query) {
    return _historyStore.filterHistory(state.history, query);
  }

  @override
  void onEvent(SearchEvent event) {
    if (event is SearchNextPageRequested && _paginationInFlight) {
      _queuedPaginationRequestsToIgnore++;
    }
    super.onEvent(event);
  }

  Future<void> _onStarted(
    SearchStarted event,
    Emitter<SearchState> emit,
  ) async {
    final history = await _historyStore.loadHistory();
    emit(state.copyWith(history: history));
  }

  void _onQueryChanged(SearchQueryChanged event, Emitter<SearchState> emit) {
    final query = event.query;
    final searchQuery = query.trim();
    final cacheKey = _cacheKeyFor(query);
    final previousCacheKey = _cacheKeyFor(state.query);

    if (cacheKey == previousCacheKey) {
      if (query != state.query) {
        emit(state.copyWith(query: query));
      }
      return;
    }

    _debounceTimer?.cancel();

    if (searchQuery.length < SearchState.minimumQueryLength) {
      emit(
        state.copyWith(
          query: query,
          results: [],
          totalItems: 0,
          nextPageToken: null,
          requestState: SearchRequestState.idle,
          searchErrorMessage: null,
        ),
      );
      return;
    }

    final cachedResults = _resultsCache[cacheKey];
    if (cachedResults != null) {
      emit(
        state.copyWith(
          query: query,
          results: cachedResults.results,
          totalItems: cachedResults.totalItems,
          nextPageToken: cachedResults.nextPageToken,
          requestState: SearchRequestState.idle,
          searchErrorMessage: null,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        query: query,
        results: [],
        totalItems: 0,
        nextPageToken: null,
        requestState: SearchRequestState.typing,
        searchErrorMessage: null,
      ),
    );

    _debounceTimer = Timer(_debounceDuration, () {
      if (!isClosed) {
        add(SearchRequested(searchQuery));
      }
    });
  }

  Future<void> _onSearchRequested(
    SearchRequested event,
    Emitter<SearchState> emit,
  ) async {
    final cacheKey = _cacheKeyFor(event.query);
    if (cacheKey != _cacheKeyFor(state.query)) {
      return;
    }
    if (event.query.length < SearchState.minimumQueryLength) {
      return;
    }

    emit(
      state.copyWith(
        requestState: SearchRequestState.loading,
        searchErrorMessage: null,
      ),
    );

    final response = await _repository.searchProducts(event.query);
    if (cacheKey != _cacheKeyFor(state.query)) {
      return;
    }

    if (response.status == Status.completed) {
      final data = response.data;
      _resultsCache[cacheKey] = _CachedSearchResults(
        results: data.products,
        totalItems: data.totalItems,
        nextPageToken: data.nextPageToken,
      );
      emit(
        state.copyWith(
          results: data.products,
          totalItems: data.totalItems,
          nextPageToken: data.nextPageToken,
          requestState: SearchRequestState.idle,
          searchErrorMessage: null,
        ),
      );
    } else {
      emit(
        state.copyWith(
          requestState: SearchRequestState.error,
          searchErrorMessage: response.message,
        ),
      );
    }
  }

  Future<void> _onRetryRequested(
    SearchRetryRequested event,
    Emitter<SearchState> emit,
  ) async {
    final query = state.query.trim();
    if (query.length < SearchState.minimumQueryLength) {
      return;
    }

    _debounceTimer?.cancel();
    emit(
      state.copyWith(
        requestState: SearchRequestState.loading,
        results: [],
        totalItems: 0,
        nextPageToken: null,
        searchErrorMessage: null,
      ),
    );
    add(SearchRequested(query));
  }

  Future<void> _onNextPageRequested(
    SearchNextPageRequested event,
    Emitter<SearchState> emit,
  ) async {
    if (_queuedPaginationRequestsToIgnore > 0) {
      _queuedPaginationRequestsToIgnore--;
      return;
    }

    if (!state.canLoadMore) {
      return;
    }

    final query = state.query.trim();
    final cacheKey = _cacheKeyFor(query);
    final pageToken = state.nextPageToken;
    if (pageToken == null) {
      return;
    }

    _paginationInFlight = true;
    try {
      emit(
        state.copyWith(
          requestState: SearchRequestState.loadingMore,
          searchErrorMessage: null,
        ),
      );

      final response = await _repository.searchProducts(
        query,
        pageToken: pageToken,
      );
      if (cacheKey != _cacheKeyFor(state.query)) {
        return;
      }

      if (response.status == Status.completed) {
        final data = response.data;
        final results = _appendUniqueProducts(state.results, data.products);
        _resultsCache[cacheKey] = _CachedSearchResults(
          results: results,
          totalItems: data.totalItems,
          nextPageToken: data.nextPageToken,
        );
        emit(
          state.copyWith(
            results: results,
            totalItems: data.totalItems,
            nextPageToken: data.nextPageToken,
            requestState: SearchRequestState.idle,
            searchErrorMessage: null,
          ),
        );
      } else {
        emit(
          state.copyWith(
            requestState: SearchRequestState.error,
            searchErrorMessage: response.message,
          ),
        );
      }
    } finally {
      _paginationInFlight = false;
    }
  }

  Future<void> _onProductSelected(
    SearchProductSelected event,
    Emitter<SearchState> emit,
  ) async {
    if (state.isOpeningResult) {
      return;
    }

    emit(
      state.copyWith(
        isOpeningResult: true,
        openingProduct: event.product,
        resultToOpen: null,
        selectionErrorMessage: null,
      ),
    );

    final response = await _repository.getCompany(event.product.code);
    if (response.status == Status.completed) {
      final history = await _historyStore.addProduct(event.product);
      emit(
        state.copyWith(
          history: history,
          isOpeningResult: false,
          openingProduct: null,
          resultToOpen: response.data,
        ),
      );
    } else {
      emit(
        state.copyWith(
          isOpeningResult: false,
          openingProduct: null,
          selectionErrorMessage: response.message,
        ),
      );
    }
  }

  void _onResultOpened(SearchResultOpened event, Emitter<SearchState> emit) {
    emit(state.copyWith(resultToOpen: null));
  }

  void _onSelectionErrorShown(
    SearchSelectionErrorShown event,
    Emitter<SearchState> emit,
  ) {
    emit(state.copyWith(selectionErrorMessage: null));
  }

  Future<void> _onHistoryCleared(
    SearchHistoryCleared event,
    Emitter<SearchState> emit,
  ) async {
    final history = await _historyStore.clearHistory();
    emit(state.copyWith(history: history));
  }

  List<ProductSearchItem> _appendUniqueProducts(
    List<ProductSearchItem> existing,
    List<ProductSearchItem> nextPage,
  ) {
    final seenCodes = existing.map((product) => product.code).toSet();
    final uniqueNextPage = nextPage.where((product) {
      return seenCodes.add(product.code);
    });
    return [...existing, ...uniqueNextPage];
  }

  String _cacheKeyFor(String query) => query.trim().toLowerCase();

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}

class _CachedSearchResults {
  final List<ProductSearchItem> results;
  final int totalItems;
  final String? nextPageToken;

  const _CachedSearchResults({
    required this.results,
    required this.totalItems,
    required this.nextPageToken,
  });
}
