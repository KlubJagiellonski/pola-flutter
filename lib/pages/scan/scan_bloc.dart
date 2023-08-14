import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pola_flutter/analytics/analytics_barcode_source.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:pola_flutter/data/api_response.dart';
import 'package:pola_flutter/data/pola_api_repository.dart';
import 'package:pola_flutter/models/search_result.dart';
import 'package:pola_flutter/pages/scan/scan_vibration.dart';

class ScanState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ScanError extends ScanState {
  final String message;

  ScanError(this.message);

  @override
  List<Object?> get props => [];
}

class ScanEmpty extends ScanState {
  @override
  List<Object?> get props => [];
}

class ScanLoaded extends ScanState {
  final List<SearchResult> list;

  ScanLoaded(this.list);

  @override
  List<Object?> get props => [list];
}

class ScanEvent {}

class GetCompanyEvent extends ScanEvent {
  late int code;

  GetCompanyEvent(int code) {
    this.code = code;
  }
}

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  List<SearchResult> _results = [];
  List<int> _scannedBarcodes = [];

  final PolaApi _polaApiRepository;
  final ScanVibration _scanVibration;
  final PolaAnalytics _analytics = PolaAnalytics.instance();

  void _onBarcodeScanned(ScanEvent event, Emitter<ScanState> emit) async {
    if (event is GetCompanyEvent && !_scannedBarcodes.contains(event.code)) {
      _scannedBarcodes.add(event.code);
      _scanVibration.vibrate();
      _analytics.barcodeScanned(event.code.toString(), AnalyticsBarcodeSource.camera);

      final res = await _polaApiRepository.getCompany(event.code);
      if (res.status == Status.COMPLETED) {
        final result = res.data;
        _results.add(result);
        _analytics.searchResultReceived(result);
      }
      emit(ScanLoaded(List.from(_results)));
    }
  }

  ScanBloc(this._polaApiRepository, this._scanVibration) : super(ScanEmpty()) {
    on<ScanEvent>((event, emit) => _onBarcodeScanned(event, emit));
  }
}
