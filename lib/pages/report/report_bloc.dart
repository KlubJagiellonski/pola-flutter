import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pola_flutter/data/pola_api_repository.dart';
import 'package:pola_flutter/pages/report/report_event.dart';
import 'package:pola_flutter/pages/report/report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final PolaApiRepository _repository;
  final int? _productId;

  ReportBloc(this._repository, {required int? productId})
      : _productId = productId,
        super(const ReportState()) {
    on<ReportEvent>((event, emit) async {
      await event.when(
        submitted: (description) => _onSubmitted(description, emit),
        systemInfoToggled: (value) async => _onSystemInfoToggled(value, emit),
        descriptionChanged: () async => _onDescriptionChanged(emit),
      );
    });
  }

  Future<void> _onSubmitted(
      String description, Emitter<ReportState> emit) async {
    final trimmed = description.trim();
    if (trimmed.isEmpty) {
      emit(state.copyWith(descriptionEmpty: true));
      return;
    }

    final attachSystemInfo = state.attachSystemInfo;
    emit(state.copyWith(descriptionEmpty: false, isLoading: true, isError: false));

    final fullDescription = await _buildDescription(trimmed, attachSystemInfo);
    final success = await _repository.createReport(
      description: fullDescription,
      productId: _productId,
    );

    emit(state.copyWith(
      isLoading: false,
      isSuccess: success,
      isError: !success,
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

  void _onDescriptionChanged(Emitter<ReportState> emit) {
    if (state.descriptionEmpty) {
      emit(state.copyWith(descriptionEmpty: false));
    }
  }
}
