import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:pola_flutter/data/api_response.dart';
import 'package:pola_flutter/data/pola_api_repository.dart';
import 'package:pola_flutter/models/donate.dart';
import 'package:pola_flutter/models/replacement.dart';
import 'package:pola_flutter/models/search_result.dart';
import 'package:pola_flutter/pages/detail/replacement/replacement_bloc.dart';
import 'package:pola_flutter/pages/detail/replacement/replacement_event.dart';
import 'package:pola_flutter/pages/detail/replacement/replacement_state.dart';

import 'analytics/mock_analytics_provider.dart';

void main() {
  group('ReplacementBloc', () {
    test('initial state is empty state', () {
      expect(_replacementBloc().state, const ReplacementState(productCode: 'testOriginCode'));
    });

    blocTest(
      'send replacementTapped when cached result exists should use cached result',
      build: () => _replacementBloc(),
      seed: () => ReplacementState(
        results: {'code1': _testSearchResult('code1')},
        productCode: 'testOriginCode',
      ),
      act: (bloc) => bloc.add(
        ReplacementEvent.replacementTapped(_testReplacement('code1')),
      ),
      expect: () => [
        ReplacementState(
          results: {'code1': _testSearchResult('code1')},
          resultToPush: _testSearchResult('code1'),
          productCode: 'testOriginCode',
        ),
      ],
    );

    blocTest(
      'send replacementTapped when no cache exists should load from API',
      build: () => _replacementBloc(),
      act: (bloc) => bloc.add(
        ReplacementEvent.replacementTapped(_testReplacement('code1')),
      ),
      expect: () => [
        ReplacementState(
          loadingReplacement: _testReplacement('code1'),
          isError: false,
          productCode: 'testOriginCode',
        ),
        ReplacementState(
          loadingReplacement: null,
          results: {'code1': _testSearchResult('code1')},
          resultToPush: _testSearchResult('code1'),
          isError: false,
          productCode: 'testOriginCode',
        ),
      ],
    );

    blocTest(
      'send replacementTapped when API returns error should handle error',
      build: () => _replacementBloc(),
      act: (bloc) => bloc.add(
        ReplacementEvent.replacementTapped(_testReplacement('error')),
      ),
      expect: () => [
        ReplacementState(
          loadingReplacement: _testReplacement('error'),
          isError: false,
          productCode: 'testOriginCode',
        ),
        ReplacementState(
          loadingReplacement: null,
          isError: true,
          productCode: 'testOriginCode',
        ),
      ],
    );

    blocTest(
      'send resultPushed when resultToPush exists should clear resultToPush',
      build: () => _replacementBloc(),
      seed: () => ReplacementState(
        resultToPush: _testSearchResult('code1'),
        productCode: 'testOriginCode',
      ),
      act: (bloc) => bloc.add(
        const ReplacementEvent.resultPushed(),
      ),
      expect: () => [
        const ReplacementState(resultToPush: null, productCode: 'testOriginCode'),
      ],
    );

    blocTest(
      'send alertDialogDismissed when error exists should clear error',
      build: () => _replacementBloc(),
      seed: () => const ReplacementState(isError: true, productCode: 'testOriginCode'),
      act: (bloc) => bloc.add(
        const ReplacementEvent.alertDialogDismissed(),
      ),
      expect: () => [
        const ReplacementState(isError: false, productCode: 'testOriginCode'),
      ],
    );

    blocTest(
      'send replacementTapped when already loading should ignore new request',
      build: () => _replacementBloc(),
      seed: () => ReplacementState(
        loadingReplacement: _testReplacement('code1'),
        productCode: 'testOriginCode',
      ),
      act: (bloc) => bloc.add(
        ReplacementEvent.replacementTapped(_testReplacement('code2')),
      ),
      expect: () => [],
    );

    blocTest(
      'send replacementTapped during error state should ignore request',
      build: () => _replacementBloc(),
      seed: () => const ReplacementState(isError: true, productCode: 'testOriginCode'),
      act: (bloc) => bloc.add(
        ReplacementEvent.replacementTapped(_testReplacement('code1')),
      ),
      expect: () => [],
    );

    blocTest(
      'send replacementTapped when loading completes should cache result after loading',
      build: () => _replacementBloc(),
      act: (bloc) => bloc.add(
        ReplacementEvent.replacementTapped(_testReplacement('code1')),
      ),
      verify: (bloc) {
        expect(bloc.state.results.containsKey('code1'), isTrue);
        expect(bloc.state.results['code1'], equals(_testSearchResult('code1')));
      },
    );

    test('send replacementTapped should call replacementCardOpened with correct codes', () async {
      final mockProvider = MockAnalyticsProvider();
      final analytics = PolaAnalytics(provider: mockProvider);
      final bloc = ReplacementBloc(_MockPolaApi(), analytics, state: const ReplacementState(productCode: 'productCode123'));
      
      bloc.add(ReplacementEvent.replacementTapped(_testReplacement('replacementCode456')));
      
      await Future.delayed(Duration(milliseconds: 100));
      await pumpEventQueue();
      
      verify(mockProvider.logEvent(
        'replacemnt_card_opened',
        {
          'origin_code': 'productCode123',
          'replacement_code': 'replacementCode456',
        }
      )).called(1);
    });
  });
}

ReplacementBloc _replacementBloc() {
  return ReplacementBloc(_MockPolaApi(), PolaAnalytics(provider: MockAnalyticsProvider()), state: const ReplacementState(productCode: 'testOriginCode'));
}

Replacement _testReplacement(String code) {
  return Replacement(
    name: 'Test Product $code',
    code: code,
    company: 'Test Company',
    description: 'Test Description',
    displayName: 'Test Display Name $code',
    isFriend: false,
  );
}

SearchResult _testSearchResult(String code) {
  return SearchResult(
    productId: 123456,
    code: code,
    name: 'Test Product $code',
    cardType: 'card',
    companies: [],
    report: null,
    donate: Donate(
      showButton: false,
      url: 'https://example.com',
      title: 'Test Donate',
    ),
  );
}

class _MockPolaApi extends PolaApi {
  @override
  Future<ApiResponse<SearchResult>> getCompany(String code) {
    if (code == 'error') {
      return Future.value(ApiResponse<SearchResult>.error('error'));
    } else {
      return Future.value(
        ApiResponse<SearchResult>.completed(_testSearchResult(code)),
      );
    }
  }
}

