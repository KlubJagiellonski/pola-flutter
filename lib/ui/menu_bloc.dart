import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'menu_bloc.freezed.dart';

@freezed
class MenuState with _$MenuState {
  const factory MenuState({
    @Default(null) String? version,
  }) = Initial;
}

@freezed
class MenuEvent with _$MenuEvent {
  const factory MenuEvent.onApear() = onApear;
}

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc(): super(MenuState()) {
    on<MenuEvent>((event, emit) async {
      await event.when(
        onApear: () async => await _onApear(emit)
      );
    });
  }

  _onApear(Emitter<MenuState> emit) async {
    emit(state.copyWith(version: '1.0.0'));
  }
}
