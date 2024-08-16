import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

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
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    emit(state.copyWith(version: 'ver $version ($buildNumber)'));
  }
}
