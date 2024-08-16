import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pola_flutter/analytics/analytics_barcode_source.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:pola_flutter/data/api_response.dart';
import 'package:pola_flutter/data/pola_api_repository.dart';
import 'package:pola_flutter/models/search_result.dart';
import 'package:pola_flutter/pages/scan/scan_event.dart';
import 'package:pola_flutter/pages/scan/scan_state.dart';
import 'package:pola_flutter/pages/scan/scan_vibration.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  final PolaApi _polaApiRepository;
  final ScanVibration _scanVibration;
  final PolaAnalytics _analytics;

  ScanBloc(this._polaApiRepository, this._scanVibration, this._analytics)
      : super(ScanState()) {
    on<ScanEvent>((event, emit) async {
      await event.when(
        barcodeScanned: (barcode) async => await _onBarcodeScanned(barcode, emit),
        alertDialogDismissed: () => _onAlertDialogDismissed(emit),
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
    _analytics.barcodeScanned(barcode.toString(), AnalyticsBarcodeSource.camera);

    final res = await _polaApiRepository.getCompany(barcode);
    if (res.status == Status.COMPLETED) {
      final result = res.data;
      var results = List<SearchResult>.from(state.list);
      results.add(result);
      _analytics.searchResultReceived(result);
      emit(state.copyWith(list: results, isLoading: false, isError: true));
    } else {
      emit(state.copyWith(isLoading: false, isError: true));
    }
  }

  _onAlertDialogDismissed(Emitter<ScanState> emit) {
    emit(state.copyWith(isError: false));
  }
}
