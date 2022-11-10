import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pola_flutter/data/api_response.dart';
import 'package:pola_flutter/data/pola_api_repository.dart';
import 'package:pola_flutter/models/search_result.dart';

class ScanState extends Equatable{
  @override
  List<Object?> get props => [];
}
class ScanError extends ScanState{
  final String message;
  ScanError(this.message);

  @override
  List<Object?> get props => [];
}
class ScanEmpty extends ScanState{
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

class GetCompanyEvent extends ScanEvent{
    late int code;
    GetCompanyEvent(int code){
      this.code = code;
    }
}

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  List<SearchResult> _list = [];
  late final PolaApi _polaApiRepository;

  ScanBloc(PolaApi polaApiRepository) : super(ScanEmpty()){
    _polaApiRepository = polaApiRepository;
  }


  @override
  Stream<ScanState> mapEventToState(ScanEvent event) async* {
    if(event is GetCompanyEvent){
      final res = await _polaApiRepository.getCompany(event.code);
      if(res.status == Status.COMPLETED){
        _list.add(res.data);
        _list = _list.reversed.toSet().toList();
        yield ScanLoaded(_list);
      }else {
        yield ScanError(res.message);
      }
    }
  }

}
