import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pola_flutter/analytics/analytics_barcode_source.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:pola_flutter/data/api_response.dart';
import 'package:pola_flutter/data/pola_api_repository.dart';
import 'package:pola_flutter/models/search_result.dart';
import 'package:pola_flutter/pages/scan/remote_button.dart';
import 'package:pola_flutter/pages/scan/scan_event.dart';
import 'package:pola_flutter/pages/scan/scan_state.dart';
import 'package:pola_flutter/pages/scan/scan_vibration.dart';
import 'package:pola_flutter/pages/scan/torch_controller.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  final PolaApi _polaApiRepository;
  final ScanVibration _scanVibration;
  final PolaAnalytics _analytics;
  final TorchController _torchController;

  ScanBloc(this._polaApiRepository, this._scanVibration, this._analytics,
      this._torchController,
      {ScanState state = const ScanState()})
      : super(state) {
    on<ScanEvent>((event, emit) async {
      await event.when(
        barcodeScanned: (barcode) async =>
            await _onBarcodeScanned(barcode, emit),
        alertDialogDismissed: () => _onAlertDialogDismissed(emit),
        torchSwitched: () => _onTorchSwitched(emit),
        closeRemoteButton: () => _onCloseRemoteButton(emit),
        resetScannedCompanies: () => _onResetScannedCompanies(emit),
      );
    });
  }

  _onBarcodeScanned(String barcode, Emitter<ScanState> emit) async {
    if (state.list.any((element) => element.code == barcode) ||
        state.isLoading ||
        state.isError) {
      return;
    }
    emit(state.copyWith(isLoading: true));
    debugPrint('Scanned barcode event received: $barcode');
    _scanVibration.vibrate();
    _analytics.barcodeScanned(
        barcode.toString(), AnalyticsBarcodeSource.camera);

    final res = await _polaApiRepository.getCompany(barcode);
    if (res.status == Status.COMPLETED) {
      final result = res.data;
      var results = List<SearchResult>.from(state.list);
      results.add(result);
      _analytics.searchResultReceived(result);
      var remoteButtonState = state.remoteButtonState;
      if (remoteButtonState == null && !state.wasRemoteButtonClosed) {
        remoteButtonState = result.remoteButton();
      }
      emit(state.copyWith(
          list: results,
          isLoading: false,
          isError: false,
          remoteButtonState: remoteButtonState));
    } else {
      emit(state.copyWith(isLoading: false, isError: true));
    }
  }

  _onTorchSwitched(Emitter<ScanState> emit) {
    _torchController.toggleTorch();

    emit(state.copyWith(isTorchOn: !state.isTorchOn));
  }

  _onAlertDialogDismissed(Emitter<ScanState> emit) {
    emit(state.copyWith(isError: false));
  }

  _onCloseRemoteButton(Emitter<ScanState> emit) {
    emit(state.copyWith(wasRemoteButtonClosed: true, remoteButtonState: null));
  }

  _onResetScannedCompanies(Emitter<ScanState> emit) {
    emit(state.copyWith(list: []));
  }
}

extension on SearchResult {
  RemoteButtonState? remoteButton() {
    final donate = this.donate;
    final code = this.code;
    if (code != null && donate != null && donate.showButton) {
      final uri = Uri.parse(donate.url);
      return RemoteButtonState(title: donate.title, uri: uri, code: code);
    }
    return null;
  }
}
