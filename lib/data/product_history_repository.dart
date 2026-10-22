import 'dart:convert';

import 'package:pola_flutter/models/product_search_response.dart';
import 'package:pola_flutter/models/search_result.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProductHistoryRepository {
  Stream<List<ProductSearchItem>> watchHistory();
  Future<List<ProductSearchItem>> loadHistory();
  Future<List<ProductSearchItem>> addProduct(ProductSearchItem product);
  Future<List<ProductSearchItem>> addScannedProduct(
    SearchResult result, {
    required String barcode,
  });
  Future<List<ProductSearchItem>> clearHistory();
  Future<void> dispose();
  List<ProductSearchItem> filterHistory(
    List<ProductSearchItem> history,
    String query,
  );
}

class SharedPreferencesProductHistoryRepository
    implements ProductHistoryRepository {
  static const _historyKey = 'product_search_history';
  static const _maxHistorySize = 50;

  final SharedPreferences _prefs;
  final BehaviorSubject<List<ProductSearchItem>> _history;
  Future<void> _pendingWrite = Future.value();

  SharedPreferencesProductHistoryRepository(this._prefs)
    : _history = BehaviorSubject.seeded(_readHistory(_prefs));

  static Future<SharedPreferencesProductHistoryRepository> create() async {
    final prefs = await SharedPreferences.getInstance();
    return SharedPreferencesProductHistoryRepository(prefs);
  }

  @override
  Stream<List<ProductSearchItem>> watchHistory() => _history.stream;

  @override
  Future<List<ProductSearchItem>> loadHistory() async => _history.value;

  static List<ProductSearchItem> _readHistory(SharedPreferences prefs) {
    final rawHistory = prefs.getString(_historyKey);
    if (rawHistory == null || rawHistory.isEmpty) {
      return const [];
    }

    try {
      final decoded = jsonDecode(rawHistory) as List<dynamic>;
      return List.unmodifiable(
        decoded
            .map(
              (item) =>
                  ProductSearchItem.fromJson(item as Map<String, dynamic>),
            )
            .take(_maxHistorySize),
      );
    } on FormatException {
      return const [];
    } on TypeError {
      return const [];
    }
  }

  @override
  Future<List<ProductSearchItem>> addProduct(ProductSearchItem product) {
    return _update(
      (existing) => [
        product,
        ...existing.where((item) => item.code != product.code),
      ].take(_maxHistorySize).toList(),
    );
  }

  @override
  Future<List<ProductSearchItem>> addScannedProduct(
    SearchResult result, {
    required String barcode,
  }) {
    final code = result.code?.isNotEmpty == true ? result.code! : barcode;
    final companies = result.companies;
    final company = companies == null || companies.isEmpty
        ? null
        : companies.first;
    final brands = company?.brands;
    final brand = brands == null || brands.isEmpty ? null : brands.first;
    return addProduct(
      ProductSearchItem(
        name: result.name?.isNotEmpty == true ? result.name! : code,
        code: code,
        company: company == null
            ? null
            : ProductSearchCompany(
                name: company.name ?? '',
                score: company.plScore,
              ),
        brand: brand?.name == null
            ? null
            : ProductSearchBrand(name: brand!.name!),
      ),
    );
  }

  @override
  Future<List<ProductSearchItem>> clearHistory() => _update((_) => []);

  @override
  List<ProductSearchItem> filterHistory(
    List<ProductSearchItem> history,
    String query,
  ) {
    final normalizedQuery = query.trim().toLowerCase();
    if (normalizedQuery.isEmpty) {
      return history;
    }

    return history.where((product) {
      return product.name.toLowerCase().contains(normalizedQuery) ||
          product.code.toLowerCase().contains(normalizedQuery) ||
          (product.company?.name.toLowerCase().contains(normalizedQuery) ??
              false) ||
          (product.brand?.name.toLowerCase().contains(normalizedQuery) ??
              false);
    }).toList();
  }

  Future<List<ProductSearchItem>> _update(
    List<ProductSearchItem> Function(List<ProductSearchItem>) update,
  ) {
    final operation = _pendingWrite.then((_) async {
      final updated = List<ProductSearchItem>.unmodifiable(
        update(_history.value),
      );
      if (updated.isEmpty) {
        await _prefs.remove(_historyKey);
      } else {
        await _prefs.setString(
          _historyKey,
          jsonEncode(updated.map((product) => product.toJson()).toList()),
        );
      }
      _history.add(updated);
      return updated;
    });
    _pendingWrite = operation.then<void>(
      (_) {},
      onError: (Object _, StackTrace _) {},
    );
    return operation;
  }

  @override
  Future<void> dispose() async {
    await _pendingWrite;
    await _history.close();
  }
}
