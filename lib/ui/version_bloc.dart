import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'version_bloc.freezed.dart';

@freezed
class VersionState with _$VersionState {
  const factory VersionState({
    @Default(null) String? version,
  }) = Initial;
}

@freezed
class VersionEvent with _$VersionEvent {
  const factory VersionEvent.onApear() = onApear;
}

class VersionBloc extends Bloc<VersionEvent, VersionState> {
  VersionBloc(): super(VersionState()) {
    on<VersionEvent>((event, emit) async {
      await event.when(
        onApear: () async => await _onApear(emit)
      );
    });
  }

  _onApear(Emitter<VersionState> emit) async {
    emit(state.copyWith(version: '1.0.0'));
  }
}
