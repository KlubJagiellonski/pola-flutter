import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:pola_flutter/data/api_response.dart';
import 'package:pola_flutter/data/pola_api_repository.dart';
import 'package:pola_flutter/main.dart';
import 'package:pola_flutter/models/search_result.dart';
import 'package:pola_flutter/pages/scan/scan_bloc.dart';
import 'package:pola_flutter/pages/scan/scan_event.dart';
import 'package:pola_flutter/pages/scan/scan_state.dart';
import 'package:pola_flutter/pages/scan/scan_vibration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

import 'analytics/mock_analytics_provider.dart';

void main() {
  SharedPreferences.setMockInitialValues({});

  group('ScanBloc', () {
    late ScanBloc scanBloc;
    Bloc.observer = SimpleBlocObserver();

    setUp(() {
      scanBloc = ScanBloc(MockPolaApi(), MockScanVibration(), PolaAnalytics(provider: MockAnalyticsProvider()));
    });

    test('initial state is state with empty list', () {
      expect(scanBloc.state, ScanState());
    });
    blocTest(
      'emits ScanLoaded([searchResult1]) when barcodeScanned(5900311000360) is added',
      build: () => scanBloc,
      act: (bloc) => scanBloc.add(ScanEvent.barcodeScanned("5900311000360")),
      expect: () => [
        ScanState(isLoading: true),
        ScanState(list: [searchResult1], isLoading: false)
        ],
    );
    blocTest(
      'emits state with error when scanned barcode results in error',
      build: () => scanBloc,
      act: (bloc) => scanBloc.add(ScanEvent.barcodeScanned("0")),
      expect: () => [
        ScanState(isLoading: true),
        ScanState(isLoading: false, isError: true)
        ],
    );

    blocTest(
      'emits state with no error when alert dialog dismissed',
      build: (){ 
        scanBloc = ScanBloc(MockPolaApi(), MockScanVibration(), PolaAnalytics(provider: MockAnalyticsProvider()), state: ScanState(isError: true));
        return scanBloc;
      },
      act: (bloc) => bloc.add(ScanEvent.alertDialogDismissed()),
      expect: () => [
        ScanState(isError: false)
      ],
    );
  });
}

var searchResult1 = SearchResult(
    productId: 5900311000360,
    code: "code",
    name: "name",
    cardType: "card",
    companies: [],
    report: null,
    donate: null);

class MockPolaApi extends PolaApi {
  @override
  Future<ApiResponse<SearchResult>> getCompany(String code) {
    print("MockPolaApi getCompany " + code.toString());
    if (code == "5900311000360") {
      return Future.value(ApiResponse.completed(searchResult1));
    } else {
      return Future.value(ApiResponse.error("error"));
    }
  }
}

class MockScanVibration extends ScanVibration {
  @override
  void vibrate() {
  }
}
