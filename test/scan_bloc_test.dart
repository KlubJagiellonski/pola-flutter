import 'package:bloc_test/bloc_test.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:pola_flutter/data/api_response.dart';
import 'package:pola_flutter/data/pola_api_repository.dart';
import 'package:pola_flutter/data/product_history_repository.dart';
import 'package:pola_flutter/models/donate.dart';
import 'package:pola_flutter/models/product_search_response.dart';
import 'package:pola_flutter/models/search_result.dart';
import 'package:pola_flutter/pages/scan/remote_button.dart';
import 'package:pola_flutter/pages/scan/scan_bloc.dart';
import 'package:pola_flutter/pages/scan/scan_event.dart';
import 'package:pola_flutter/pages/scan/scan_state.dart';
import 'package:pola_flutter/pages/scan/scan_vibration.dart';
import 'package:pola_flutter/pages/scan/torch_controller.dart';
import 'package:pola_flutter/pages/search/search_bloc.dart';
import 'package:pola_flutter/pages/search/search_event.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';
import 'package:flutter/foundation.dart';
import 'analytics/mock_analytics_provider.dart';

void main() {
  late ProductHistoryRepository historyRepository;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    historyRepository =
        await SharedPreferencesProductHistoryRepository.create();
  });

  tearDown(() => historyRepository.dispose());

  ScanBloc scanBloc({ScanState state = const ScanState()}) =>
      _scanBloc(historyRepository: historyRepository, state: state);

  group('ScanBloc', () {
    test('initial state is state with empty list', () {
      final bloc = scanBloc();
      addTearDown(bloc.close);
      expect(bloc.state, ScanState());
    });

    blocTest(
      'toggle torch',
      build: () => scanBloc(),
      act: (bloc) => bloc.add(ScanEvent.torchSwitched()),
      expect: () => [ScanState(isTorchOn: true)],
    );

    blocTest(
      'emits ScanLoaded([searchResult1]) when barcodeScanned(5900311000360) is added',
      build: () => scanBloc(),
      act: (bloc) => bloc.add(ScanEvent.barcodeScanned("5900311000360")),
      expect: () => [
        ScanState(isLoading: true),
        ScanState(list: [_testSearchResult], isLoading: false),
      ],
    );

    blocTest(
      'emits scan with remote button when scan code with donate',
      build: () => scanBloc(),
      act: (bloc) => bloc.add(ScanEvent.barcodeScanned("button1")),
      expect: () => [
        ScanState(isLoading: true),
        ScanState(
          list: [_testSearchResultWithButton("button1")],
          isLoading: false,
          remoteButtonState: _remoteStateButton("button1"),
        ),
      ],
    );

    blocTest(
      'emits close remote button should remove button',
      build: () => scanBloc(),
      act: (bloc) {
        bloc.add(ScanEvent.barcodeScanned("button1"));
        bloc.add(ScanEvent.closeRemoteButton());
      },
      expect: () => [
        ScanState(isLoading: true),
        ScanState(
          list: [_testSearchResultWithButton("button1")],
          isLoading: false,
          remoteButtonState: _remoteStateButton("button1"),
        ),
        ScanState(
          list: [_testSearchResultWithButton("button1")],
          isLoading: false,
          remoteButtonState: null,
          wasRemoteButtonClosed: true,
        ),
      ],
    );

    blocTest(
      'emits close remote button should block appearing remote button',
      build: () => scanBloc(),
      act: (bloc) {
        bloc.add(ScanEvent.barcodeScanned("button1"));
        bloc.add(ScanEvent.closeRemoteButton());
        bloc.add(ScanEvent.barcodeScanned("button2"));
      },
      expect: () => [
        ScanState(isLoading: true),
        ScanState(
          list: [_testSearchResultWithButton("button1")],
          isLoading: false,
          remoteButtonState: _remoteStateButton("button1"),
        ),
        ScanState(
          list: [_testSearchResultWithButton("button1")],
          isLoading: false,
          remoteButtonState: null,
          wasRemoteButtonClosed: true,
        ),
        ScanState(
          list: [_testSearchResultWithButton("button1")],
          isLoading: true,
          remoteButtonState: null,
          wasRemoteButtonClosed: true,
        ),
        ScanState(
          list: [
            _testSearchResultWithButton("button1"),
            _testSearchResultWithButton("button2"),
          ],
          isLoading: false,
          remoteButtonState: null,
          wasRemoteButtonClosed: true,
        ),
      ],
    );

    blocTest(
      'emits state with error when scanned barcode results in error',
      build: () => scanBloc(),
      act: (bloc) => bloc.add(ScanEvent.barcodeScanned("0")),
      expect: () => [
        ScanState(isLoading: true),
        ScanState(isLoading: false, isError: true),
      ],
    );

    blocTest(
      'emits state with no error when alert dialog dismissed',
      build: () => scanBloc(state: ScanState(isError: true)),
      act: (bloc) => bloc.add(ScanEvent.alertDialogDismissed()),
      expect: () => [ScanState(isError: false)],
    );

    blocTest(
      'emits state with empty list when reset scanned companies button tapped',
      build: () => scanBloc(state: ScanState(list: [_testSearchResult])),
      act: (bloc) => bloc.add(ScanEvent.resetScannedCompaniesButton()),
      expect: () => [ScanState(list: [])],
    );
  });

  group('Shared scan and search history', () {
    late ScanBloc scanner;
    late SearchBloc search;

    setUp(() {
      scanner = scanBloc();
      search = SearchBloc(_MockPolaApi(), historyRepository)
        ..add(const SearchEvent.started());
    });

    tearDown(() async {
      await scanner.close();
      await search.close();
    });

    test('successful scan updates an already open search history', () async {
      final updated = search.stream.firstWhere(
        (state) => state.history.isNotEmpty,
      );
      scanner.add(const ScanEvent.barcodeScanned('5900311000360'));

      final state = await updated;
      expect(state.history.single.code, _testSearchResult.code);
      expect(state.history.single.name, _testSearchResult.name);
    });

    test('search and scanning deduplicate the same product', () async {
      const product = ProductSearchItem(name: 'Product', code: '5900311000360');
      final opened = search.stream.firstWhere(
        (state) => state.resultToOpen != null,
      );
      search.add(const SearchEvent.productSelected(product));
      await opened;
      expect(scanner.state.list, isEmpty);

      final updated = search.stream.firstWhere(
        (state) => state.history.firstOrNull?.name == _testSearchResult.name,
      );
      scanner.add(const ScanEvent.barcodeScanned('5900311000360'));

      expect((await updated).history, [
        const ProductSearchItem(name: 'name', code: '5900311000360'),
      ]);
    });

    test('failed lookups do not add history', () async {
      final failedScan = scanner.stream.firstWhere((state) => state.isError);
      scanner.add(const ScanEvent.barcodeScanned('0'));
      await failedScan;
      final failedSearch = search.stream.firstWhere(
        (state) => state.selectionErrorMessage != null,
      );
      search.add(
        const SearchEvent.productSelected(
          ProductSearchItem(name: 'Unknown', code: '0'),
        ),
      );
      await failedSearch;

      expect(await historyRepository.loadHistory(), isEmpty);
      expect(search.state.history, isEmpty);
    });

    test(
      'clearing shared history persists and later scans remain visible',
      () async {
        final firstScan = search.stream.firstWhere(
          (state) => state.history.isNotEmpty,
        );
        scanner.add(const ScanEvent.barcodeScanned('5900311000360'));
        await firstScan;
        final cleared = search.stream.firstWhere(
          (state) => state.history.isEmpty,
        );
        search.add(const SearchEvent.historyCleared());
        await cleared;
        expect(await historyRepository.loadHistory(), isEmpty);

        final nextScan = search.stream.firstWhere(
          (state) => state.history.isNotEmpty,
        );
        scanner.add(const ScanEvent.barcodeScanned('button1'));
        expect((await nextScan).history.single.code, 'button1');
      },
    );

    test(
      'resetting the scanner session retains persistent product history',
      () async {
        final scanned = scanner.stream.firstWhere(
          (state) => state.list.isNotEmpty,
        );
        scanner.add(const ScanEvent.barcodeScanned('5900311000360'));
        await scanned;
        final reset = scanner.stream.firstWhere((state) => state.list.isEmpty);
        scanner.add(const ScanEvent.resetScannedCompaniesButton());
        await reset;

        expect(
          (await historyRepository.loadHistory()).single.code,
          _testSearchResult.code,
        );
      },
    );

    test('a new search bloc loads products scanned before it opened', () async {
      final scanned = scanner.stream.firstWhere(
        (state) => state.list.isNotEmpty,
      );
      scanner.add(const ScanEvent.barcodeScanned('5900311000360'));
      await scanned;
      await search.close();
      search = SearchBloc(_MockPolaApi(), historyRepository);
      final loaded = search.stream.firstWhere(
        (state) => state.history.isNotEmpty,
      );
      search.add(const SearchEvent.started());

      expect((await loaded).history.single.code, _testSearchResult.code);
    });
  });
}

ScanBloc _scanBloc({
  required ProductHistoryRepository historyRepository,
  ScanState state = const ScanState(),
}) {
  return ScanBloc(
    _MockPolaApi(),
    _MockScanVibration(),
    PolaAnalytics(provider: MockAnalyticsProvider()),
    _MockTorchController(),
    historyRepository,
    state: state,
  );
}

var _testSearchResult = SearchResult(
  productId: 5900311000360,
  code: "5900311000360",
  name: "name",
  cardType: "card",
  companies: [],
  report: null,
  donate: Donate(
    showButton: false,
    url: "https://klubjagiellonski.pl/zbiorka/wspieraj-aplikacje-pola/",
    title: "Pomóż aplikacji Pola",
  ),
);

SearchResult _testSearchResultWithButton(String code) {
  return SearchResult(
    productId: 6262330,
    code: code,
    name: "Miejsce rejestracji: Francja",
    cardType: "card",
    companies: [],
    report: null,
    donate: Donate(
      showButton: true,
      url: "https://klubjagiellonski.pl/zbiorka/wspieraj-aplikacje-pola/",
      title: "Pomóż aplikacji Pola",
    ),
  );
}

RemoteButtonState _remoteStateButton(String code) {
  return RemoteButtonState(
    title: "Pomóż aplikacji Pola",
    uri: Uri.parse(
      "https://klubjagiellonski.pl/zbiorka/wspieraj-aplikacje-pola/",
    ),
    code: code,
  );
}

class _MockPolaApi extends PolaApi {
  @override
  Future<ApiResponse<SearchResult>> getCompany(String code) {
    debugPrint("MockPolaApi getCompany ${code.toString()}");
    if (code == "5900311000360") {
      return Future.value(ApiResponse.completed(_testSearchResult));
    } else if (code == "button1" || code == "button2") {
      return Future.value(
        ApiResponse.completed(_testSearchResultWithButton(code)),
      );
    } else {
      return Future.value(ApiResponse.error("error"));
    }
  }

  @override
  Future<bool> createReport({required String description, int? productId}) =>
      Future.value(true);

  @override
  Future<ApiResponse<ProductSearchResponse>> searchProducts(
    String query, {
    String? pageToken,
  }) {
    throw UnimplementedError();
  }
}

class _MockScanVibration extends ScanVibration {
  @override
  void vibrate() {}
}

class _MockTorchController extends TorchController {
  @override
  void toggleTorch() {}
}
