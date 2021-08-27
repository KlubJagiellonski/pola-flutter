import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pola_flutter/data/pola_api_repository.dart';
import 'package:pola_flutter/models/search_result.dart';
import 'package:qr_code_scanner/src/qr_code_scanner.dart';

class ScanState {}

class ScanLoaded extends ScanState {
  final List<SearchResult> list;

  ScanLoaded(this.list);
}

class ScanEvent {}

class GetCompanyEvent extends ScanEvent{
    late int code;
    GetCompanyEvent(int code){
      this.code = code;
    }
}

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  List<SearchResult> _list = [];
  late final PolaApiRepository _polaApiRepository;
  QRViewController? controller;

  ScanBloc(ScanState initialState) : super(initialState){
    _polaApiRepository = PolaApiRepository();
  }


  @override
  Stream<ScanState> mapEventToState(ScanEvent event) async* {
    if(event is GetCompanyEvent){
      final res = await _polaApiRepository
          .getCompany(event.code)
          .then((value) {
            if(value != null){
              _list.add(value);
            }
            print(value != null);
      });
      _list = _list.reversed.toSet().toList();
      yield ScanLoaded(_list);
    }
  }

  void setQRViewController(QRViewController qrViewController) {
    controller = qrViewController;
    controller?.scannedDataStream
        .distinct((one, two) => one.code == two.code)
        .listen((scanData) {
        add(GetCompanyEvent(int.parse(scanData.code)));
    });
  }
}
