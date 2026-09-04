import 'dart:convert';

import 'package:pola_flutter/models/product_search_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProductSearchHistoryStore {
  Future<List<ProductSearchItem>> loadHistory();
  Future<List<ProductSearchItem>> addProduct(ProductSearchItem product);
  Future<List<ProductSearchItem>> clearHistory();
  List<ProductSearchItem> filterHistory(
    List<ProductSearchItem> history,
    String query,
  );
}

class ProductSearchHistoryService implements ProductSearchHistoryStore {
  static const _historyKey = 'product_search_history';
  static const _maxHistorySize = 50;

  final SharedPreferences _prefs;

  ProductSearchHistoryService(this._prefs);

  static Future<ProductSearchHistoryService> create() async {
    final prefs = await SharedPreferences.getInstance();
    return ProductSearchHistoryService(prefs);
  }

  @override
  Future<List<ProductSearchItem>> loadHistory() async {
    final rawHistory = _prefs.getString(_historyKey);
    if (rawHistory == null || rawHistory.isEmpty) {
      return [];
    }

    try {
      final decoded = jsonDecode(rawHistory) as List<dynamic>;
      return decoded
          .map(
            (item) => ProductSearchItem.fromJson(item as Map<String, dynamic>),
          )
          .toList();
    } on FormatException {
      await clearHistory();
      return [];
    } on TypeError {
      await clearHistory();
      return [];
    }
  }

  @override
  Future<List<ProductSearchItem>> addProduct(ProductSearchItem product) async {
    final existing = await loadHistory();
    final updated = [
      product,
      ...existing.where((item) => item.code != product.code),
    ].take(_maxHistorySize).toList();

    await _save(updated);
    return updated;
  }

  @override
  Future<List<ProductSearchItem>> clearHistory() async {
    await _prefs.remove(_historyKey);
    return [];
  }

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

  Future<void> _save(List<ProductSearchItem> history) async {
    final encoded = jsonEncode(
      history.map((product) => product.toJson()).toList(),
    );
    await _prefs.setString(_historyKey, encoded);
  }
}
