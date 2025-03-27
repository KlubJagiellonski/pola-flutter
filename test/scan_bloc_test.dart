import 'package:bloc_test/bloc_test.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:pola_flutter/data/api_response.dart';
import 'package:pola_flutter/data/pola_api_repository.dart';
import 'package:pola_flutter/models/donate.dart';
import 'package:pola_flutter/models/search_result.dart';
import 'package:pola_flutter/pages/scan/remote_button.dart';
import 'package:pola_flutter/pages/scan/scan_bloc.dart';
import 'package:pola_flutter/pages/scan/scan_event.dart';
import 'package:pola_flutter/pages/scan/scan_state.dart';
import 'package:pola_flutter/pages/scan/scan_vibration.dart';
import 'package:pola_flutter/pages/scan/torch_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

import 'analytics/mock_analytics_provider.dart';

void main() {
  SharedPreferences.setMockInitialValues({});

  group('ScanBloc', () {
    test('initial state is state with empty list', () {
      expect(_scanBloc().state, ScanState());
    });

    blocTest(
      'toggle torch',
      build: () => _scanBloc(),
      act: (bloc) => bloc.add(ScanEvent.torchSwitched()),
      expect: () => [
        ScanState(isTorchOn: true),
      ],
    );

    blocTest(
      'emits ScanLoaded([searchResult1]) when barcodeScanned(5900311000360) is added',
      build: () => _scanBloc(),
      act: (bloc) => bloc.add(ScanEvent.barcodeScanned("5900311000360")),
      expect: () => [
        ScanState(isLoading: true),
        ScanState(list: [_testSearchResult], isLoading: false)
      ],
    );

    blocTest(
      'emits scan with remote button when scan code with donate',
      build: () => _scanBloc(),
      act: (bloc) => bloc.add(ScanEvent.barcodeScanned("button1")),
      expect: () => [
        ScanState(isLoading: true),
        ScanState(
            list: [_testSearchResultWithButton("button1")],
            isLoading: false,
            remoteButtonState: _remoteStateButton("button1"))
      ],
    );

    blocTest(
      'emits close remote button should remove button',
      build: () => _scanBloc(),
      act: (bloc) {
        bloc.add(ScanEvent.barcodeScanned("button1"));
        bloc.add(ScanEvent.closeRemoteButton());
      },
      expect: () => [
        ScanState(isLoading: true),
        ScanState(
            list: [_testSearchResultWithButton("button1")],
            isLoading: false,
            remoteButtonState: _remoteStateButton("button1")),
        ScanState(
            list: [_testSearchResultWithButton("button1")],
            isLoading: false,
            remoteButtonState: null,
            wasRemoteButtonClosed: true),
      ],
    );

    blocTest(
      'emits close remote button should block appearing remote button',
      build: () => _scanBloc(),
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
            remoteButtonState: _remoteStateButton("button1")),
        ScanState(
            list: [_testSearchResultWithButton("button1")],
            isLoading: false,
            remoteButtonState: null,
            wasRemoteButtonClosed: true),
        ScanState(
            list: [_testSearchResultWithButton("button1")],
            isLoading: true,
            remoteButtonState: null,
            wasRemoteButtonClosed: true),
        ScanState(
            list: [
              _testSearchResultWithButton("button1"),
              _testSearchResultWithButton("button2")
            ],
            isLoading: false,
            remoteButtonState: null,
            wasRemoteButtonClosed: true),
      ],
    );

    blocTest(
      'emits state with error when scanned barcode results in error',
      build: () => _scanBloc(),
      act: (bloc) => bloc.add(ScanEvent.barcodeScanned("0")),
      expect: () => [
        ScanState(isLoading: true),
        ScanState(isLoading: false, isError: true)
      ],
    );

    blocTest(
      'emits state with no error when alert dialog dismissed',
      build: () => _scanBloc(state: ScanState(isError: true)),
      act: (bloc) => bloc.add(ScanEvent.alertDialogDismissed()),
      expect: () => [ScanState(isError: false)],
    );
  });
}

ScanBloc _scanBloc({ScanState state = const ScanState()}) {
  return ScanBloc(_MockPolaApi(), _MockScanVibration(),
      PolaAnalytics(provider: MockAnalyticsProvider()), _MockTorchController(),
      state: state);
}

var _testSearchResult = SearchResult(
    productId: 5900311000360,
    code: "code",
    name: "name",
    cardType: "card",
    companies: [],
    report: null,
    donate: Donate(
        showButton: false,
        url: "https://klubjagiellonski.pl/zbiorka/wspieraj-aplikacje-pola/",
        title: "Pomóż aplikacji Pola"));

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
          title: "Pomóż aplikacji Pola"));
}

RemoteButtonState _remoteStateButton(code) {
  return RemoteButtonState(
      title: "Pomóż aplikacji Pola",
      uri: Uri.parse(
          "https://klubjagiellonski.pl/zbiorka/wspieraj-aplikacje-pola/"),
      code: code);
}

class _MockPolaApi extends PolaApi {
  @override
  Future<ApiResponse<SearchResult>> getCompany(String code) {
    print("MockPolaApi getCompany " + code.toString());
    if (code == "5900311000360") {
      return Future.value(ApiResponse.completed(_testSearchResult));
    } else if (code == "button1" || code == "button2") {
      return Future.value(
          ApiResponse.completed(_testSearchResultWithButton(code)));
    } else {
      return Future.value(ApiResponse.error("error"));
    }
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
