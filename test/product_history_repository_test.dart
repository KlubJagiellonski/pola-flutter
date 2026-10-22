import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pola_flutter/data/product_history_repository.dart';
import 'package:pola_flutter/models/product_search_response.dart';
import 'package:pola_flutter/models/search_result.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late SharedPreferences prefs;
  late ProductHistoryRepository repository;

  const searched = ProductSearchItem(
    name: 'Chocolate',
    code: '5901234567890',
    company: ProductSearchCompany(name: 'Producer', score: 80),
    brand: ProductSearchBrand(name: 'Brand'),
  );

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    repository = SharedPreferencesProductHistoryRepository(prefs);
  });

  tearDown(() => repository.dispose());

  test('retains history written by the previous search service', () async {
    await prefs.setString(
      'product_search_history',
      jsonEncode([searched.toJson()]),
    );
    final restored = SharedPreferencesProductHistoryRepository(prefs);
    addTearDown(restored.dispose);

    expect(await restored.loadHistory(), [searched]);
    expect(await restored.watchHistory().first, [searched]);
  });

  test(
    'scan maps product, company, score and brand into shared history',
    () async {
      final result = SearchResult.fromJson({
        'code': '5909876543210',
        'name': 'Milk',
        'companies': [
          {
            'name': 'Dairy',
            'plScore': 100,
            'brands': [
              {'name': 'Milk brand'},
            ],
          },
        ],
      });

      await repository.addScannedProduct(result, barcode: '5909876543210');

      expect(await repository.loadHistory(), [
        const ProductSearchItem(
          name: 'Milk',
          code: '5909876543210',
          company: ProductSearchCompany(name: 'Dairy', score: 100),
          brand: ProductSearchBrand(name: 'Milk brand'),
        ),
      ]);
    },
  );

  test('scan with missing fields falls back to the scanned barcode', () async {
    await repository.addScannedProduct(
      const SearchResult.empty(),
      barcode: '5901234567890',
    );
    expect(await repository.loadHistory(), [
      const ProductSearchItem(name: '5901234567890', code: '5901234567890'),
    ]);

    await repository.addScannedProduct(
      SearchResult.fromJson({'code': '', 'name': '', 'companies': []}),
      barcode: '5909876543210',
    );
    expect(
      (await repository.loadHistory()).first,
      const ProductSearchItem(name: '5909876543210', code: '5909876543210'),
    );
  });

  test(
    'reopening a product updates its data and moves it to the front',
    () async {
      await repository.addProduct(searched);
      const other = ProductSearchItem(name: 'Other', code: 'other');
      await repository.addProduct(other);
      final updated = await repository.addScannedProduct(
        SearchResult.fromJson({'code': searched.code, 'name': 'New name'}),
        barcode: searched.code,
      );

      expect(updated.map((product) => product.code), [
        searched.code,
        other.code,
      ]);
      expect(updated.first.name, 'New name');
      final restored = SharedPreferencesProductHistoryRepository(prefs);
      addTearDown(restored.dispose);
      expect(await restored.loadHistory(), updated);
    },
  );

  test('concurrent writes retain the 50 most recent unique products', () async {
    await Future.wait(
      List.generate(60, (index) {
        return repository.addProduct(
          ProductSearchItem(name: '$index', code: '$index'),
        );
      }),
    );

    final history = await repository.loadHistory();
    expect(
      history.map((product) => product.code),
      List.generate(50, (index) => '${59 - index}'),
    );
    final restored = SharedPreferencesProductHistoryRepository(prefs);
    addTearDown(restored.dispose);
    expect(await restored.loadHistory(), history);
  });

  test('overlapping add, clear, and add persist in call order', () async {
    const afterClear = ProductSearchItem(name: 'New', code: 'new');
    await Future.wait([
      repository.addProduct(searched),
      repository.clearHistory(),
      repository.addProduct(afterClear),
    ]);

    expect(await repository.loadHistory(), [afterClear]);
    await repository.clearHistory();
    expect(prefs.containsKey('product_search_history'), isFalse);
    final restored = SharedPreferencesProductHistoryRepository(prefs);
    addTearDown(restored.dispose);
    expect(await restored.loadHistory(), isEmpty);
  });

  test('subscribers receive current history, additions and clearing', () async {
    final updates = repository.watchHistory().take(3).toList();
    await repository.addProduct(searched);
    await repository.clearHistory();

    expect(await updates, [
      [],
      [searched],
      [],
    ]);
  });

  test(
    'filter matches names, codes, companies and brands from both sources',
    () async {
      await repository.addProduct(searched);
      await repository.addScannedProduct(
        SearchResult.fromJson({'code': 'scan', 'name': 'Scanned milk'}),
        barcode: 'scan',
      );
      final history = await repository.loadHistory();

      for (final query in [' chocolate ', '590123', 'PRODUCER', 'brand']) {
        expect(repository.filterHistory(history, query), [searched]);
      }
      expect(repository.filterHistory(history, 'MILK').single.code, 'scan');
      expect(repository.filterHistory(history, ' '), history);
      expect(repository.filterHistory(history, 'missing'), isEmpty);
    },
  );

  for (final corrupt in ['invalid JSON', '{}', '[{"code": 123}]']) {
    test(
      'invalid stored history recovers on the next write: $corrupt',
      () async {
        await prefs.setString('product_search_history', corrupt);
        final recovered = SharedPreferencesProductHistoryRepository(prefs);
        addTearDown(recovered.dispose);

        expect(await recovered.loadHistory(), isEmpty);
        await recovered.addProduct(searched);
        expect(await recovered.loadHistory(), [searched]);
      },
    );
  }
}
