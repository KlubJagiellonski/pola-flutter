import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:pola_flutter/data/api_response.dart';
import 'package:pola_flutter/data/pola_api_repository.dart';
import 'package:pola_flutter/models/replacement.dart';
import 'package:pola_flutter/models/search_result.dart';
import 'package:pola_flutter/pages/detail/replacement/replacement_event.dart';
import 'package:pola_flutter/pages/detail/replacement/replacement_state.dart';

class ReplacementBloc extends Bloc<ReplacementEvent, ReplacementState> {
  final PolaApi _polaApiRepository;
  final PolaAnalytics _analytics;

  ReplacementBloc(this._polaApiRepository, this._analytics, {required ReplacementState state}) : super(state) {
    on<ReplacementEvent>((event, emit) async {
      await event.when(
        replacementTapped: (replacement) async => await _onReplacementTapped(replacement, emit),
        resultPushed: () async => _onResultPushed(emit),
        alertDialogDismissed: () async => _onAlertDialogDismissed(emit),
      );
    });
  }

  Future<void> _onReplacementTapped(Replacement replacement, Emitter<ReplacementState> emit) async {
    if (state.loadingReplacement != null || state.isError) {
      return;
    }

    _analytics.replacementCardOpened(state.productCode, replacement.code);

    final cachedResult = state.results[replacement.code];
    if (cachedResult != null) {
      emit(state.copyWith(resultToPush: cachedResult));
      return;
    }

    emit(state.copyWith(loadingReplacement: replacement, isError: false));
    debugPrint('Loading replacement for code: ${replacement.code}');

    final response = await _polaApiRepository.getCompany(replacement.code);
    
    if (response.status == Status.COMPLETED) {
      final updatedResults = Map<String, SearchResult>.from(state.results);
      updatedResults[replacement.code] = response.data;
      emit(state.copyWith(
        loadingReplacement: null,
        results: updatedResults,
        resultToPush: response.data,
        isError: false,
      ));
    } else {
      emit(state.copyWith(loadingReplacement: null, isError: true));
    }
  }

  Future<void> _onResultPushed(Emitter<ReplacementState> emit) async {
    emit(state.copyWith(resultToPush: null));
  }

  Future<void> _onAlertDialogDismissed(Emitter<ReplacementState> emit) async {
    emit(state.copyWith(isError: false));
  }
}

