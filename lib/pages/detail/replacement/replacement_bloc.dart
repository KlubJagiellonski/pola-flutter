import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pola_flutter/data/api_response.dart';
import 'package:pola_flutter/data/pola_api_repository.dart';
import 'package:pola_flutter/models/replacement.dart';
import 'package:pola_flutter/pages/detail/replacement/replacement_event.dart';
import 'package:pola_flutter/pages/detail/replacement/replacement_state.dart';

class ReplacementBloc extends Bloc<ReplacementEvent, ReplacementState> {
  final PolaApi _polaApiRepository;

  ReplacementBloc(this._polaApiRepository) : super(const ReplacementState()) {
    on<ReplacementEvent>((event, emit) async {
      await event.when(
        replacementTapped: (replacement) async => await _onReplacementTapped(replacement, emit),
        navigationCompleted: () async => _onNavigationCompleted(emit),
        alertDialogDismissed: () async => _onAlertDialogDismissed(emit),
      );
    });
  }

  Future<void> _onReplacementTapped(Replacement replacement, Emitter<ReplacementState> emit) async {
    if (state.isLoading || state.isError) {
      return;
    }
    emit(state.copyWith(isLoading: true, isError: false, currentReplacement: replacement));
    debugPrint('SIEMA Loading replacement for code: ${replacement.code}');

    final response = await _polaApiRepository.getCompany(replacement.code);
    
    if (response.status == Status.COMPLETED) {
      emit(state.copyWith(
        isLoading: false,
        result: response.data,
        isError: false,
        currentReplacement: replacement,
      ));
    } else {
      emit(state.copyWith(isLoading: false, isError: true, currentReplacement: null));
    }
  }

  Future<void> _onNavigationCompleted(Emitter<ReplacementState> emit) async {
    emit(state.copyWith(result: null, currentReplacement: null));
  }

  Future<void> _onAlertDialogDismissed(Emitter<ReplacementState> emit) async {
    emit(state.copyWith(isError: false));
  }
}
