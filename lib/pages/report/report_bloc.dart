import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pola_flutter/data/pola_api_repository.dart';
import 'package:pola_flutter/pages/report/report_event.dart';
import 'package:pola_flutter/pages/report/report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final PolaApi _repository;
  final int? _productId;

  ReportBloc(PolaApi repository, {required int? productId})
      : _repository = repository,
        _productId = productId,
        super(const ReportState()) {
    on<ReportEvent>((event, emit) async {
      await event.when(
        submitted: () => _onSubmitted(emit),
        systemInfoToggled: (value) async => _onSystemInfoToggled(value, emit),
        descriptionChanged: (description) async => _onDescriptionChanged(description, emit),
      );
    });
  }

  Future<void> _onSubmitted(Emitter<ReportState> emit) async {
    final trimmed = state.description.trim();
    if (trimmed.isEmpty) {
      emit(state.copyWith(requestState: ReportRequestState.emptyDescription));
      return;
    }

    final attachSystemInfo = state.attachSystemInfo;
    emit(state.copyWith(requestState: ReportRequestState.loading));

    final fullDescription = await _buildDescription(trimmed, attachSystemInfo);
    final success = await _repository.createReport(
      description: fullDescription,
      productId: _productId,
    );

    emit(state.copyWith(
      requestState: success ? ReportRequestState.success : ReportRequestState.error,
    ));
  }

  Future<String> _buildDescription(String description, bool attachSystemInfo) async {
    var text = description;
    if (attachSystemInfo) {
      final info = await PackageInfo.fromPlatform();
      final sysInfo = '\n\n--- System info ---'
          '\nOS: ${Platform.operatingSystem} ${Platform.operatingSystemVersion}'
          '\nApp: ${info.version}+${info.buildNumber}';
      text += sysInfo;
    }
    return text;
  }

  void _onSystemInfoToggled(bool value, Emitter<ReportState> emit) {
    emit(state.copyWith(attachSystemInfo: value));
  }

  void _onDescriptionChanged(String description, Emitter<ReportState> emit) {
    emit(state.copyWith(
      description: description,
      requestState: state.requestState == ReportRequestState.emptyDescription
          ? ReportRequestState.idle
          : state.requestState,
    ));
  }
}
