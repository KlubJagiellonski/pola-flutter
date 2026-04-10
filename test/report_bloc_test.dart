import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pola_flutter/data/api_response.dart';
import 'package:pola_flutter/data/pola_api_repository.dart';
import 'package:pola_flutter/models/search_result.dart';
import 'package:pola_flutter/pages/report/report_bloc.dart';
import 'package:pola_flutter/pages/report/report_event.dart';
import 'package:pola_flutter/pages/report/report_state.dart';

void main() {
  group('ReportBloc', () {
    test('initial state is idle with empty description', () {
      expect(
        _reportBloc().state,
        const ReportState(),
      );
    });

    blocTest(
      'descriptionChanged updates description in state',
      build: () => _reportBloc(),
      act: (bloc) => bloc.add(const ReportEvent.descriptionChanged('hello')),
      expect: () => [
        const ReportState(description: 'hello'),
      ],
    );

    blocTest(
      'descriptionChanged when emptyDescription resets requestState to idle',
      build: () => _reportBloc(),
      seed: () => const ReportState(
        requestState: ReportRequestState.emptyDescription,
        description: '',
      ),
      act: (bloc) => bloc.add(const ReportEvent.descriptionChanged('hello')),
      expect: () => [
        const ReportState(
          requestState: ReportRequestState.idle,
          description: 'hello',
        ),
      ],
    );

    blocTest(
      'systemInfoToggled updates attachSystemInfo',
      build: () => _reportBloc(),
      act: (bloc) => bloc.add(const ReportEvent.systemInfoToggled(true)),
      expect: () => [
        const ReportState(attachSystemInfo: true),
      ],
    );

    blocTest(
      'submitted with empty description emits emptyDescription',
      build: () => _reportBloc(),
      act: (bloc) => bloc.add(const ReportEvent.submitted()),
      expect: () => [
        const ReportState(requestState: ReportRequestState.emptyDescription),
      ],
    );

    blocTest(
      'submitted with whitespace-only description emits emptyDescription',
      build: () => _reportBloc(),
      seed: () => const ReportState(description: '   '),
      act: (bloc) => bloc.add(const ReportEvent.submitted()),
      expect: () => [
        const ReportState(
          requestState: ReportRequestState.emptyDescription,
          description: '   ',
        ),
      ],
    );

    blocTest(
      'submitted with valid description on success emits loading then success',
      build: () => _reportBloc(createReportResult: true),
      seed: () => const ReportState(description: 'valid description'),
      act: (bloc) => bloc.add(const ReportEvent.submitted()),
      expect: () => [
        const ReportState(
          requestState: ReportRequestState.loading,
          description: 'valid description',
        ),
        const ReportState(
          requestState: ReportRequestState.success,
          description: 'valid description',
        ),
      ],
    );

    blocTest(
      'submitted with valid description on failure emits loading then error',
      build: () => _reportBloc(createReportResult: false),
      seed: () => const ReportState(description: 'valid description'),
      act: (bloc) => bloc.add(const ReportEvent.submitted()),
      expect: () => [
        const ReportState(
          requestState: ReportRequestState.loading,
          description: 'valid description',
        ),
        const ReportState(
          requestState: ReportRequestState.error,
          description: 'valid description',
        ),
      ],
    );

    test('submitted sends trimmed description to repository', () async {
      final mock = _MockPolaApi(createReportResult: true);
      final bloc = ReportBloc(mock, productId: 42)
        ..emit(const ReportState(description: '  trimmed  '));
      bloc.add(const ReportEvent.submitted());
      await bloc.stream.firstWhere(
        (s) => s.requestState == ReportRequestState.success,
      );
      expect(mock.lastDescription, 'trimmed');
      expect(mock.lastProductId, 42);
    });
  });
}

ReportBloc _reportBloc({bool createReportResult = true, int? productId}) {
  return ReportBloc(
    _MockPolaApi(createReportResult: createReportResult),
    productId: productId,
  );
}

class _MockPolaApi extends PolaApi {
  final bool createReportResult;
  String? lastDescription;
  int? lastProductId;

  _MockPolaApi({required this.createReportResult});

  @override
  Future<ApiResponse<SearchResult>> getCompany(String code) =>
      throw UnimplementedError();

  @override
  Future<bool> createReport({required String description, int? productId}) {
    lastDescription = description;
    lastProductId = productId;
    return Future.value(createReportResult);
  }
}
