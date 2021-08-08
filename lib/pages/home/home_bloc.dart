import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pola_flutter/data/pola_api_repository.dart';
import 'package:pola_flutter/models/search_result.dart';

class HomeState {}

class HomeLoaded extends HomeState {
  final List<SearchResult?> list;

  HomeLoaded(this.list);
}

class HomeEvent {}

class GetCompanyEvent extends HomeEvent{
    late int code;
    GetCompanyEvent(int code){
      this.code = code;
    }
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(HomeState initialState) : super(initialState);
  List<SearchResult?> _list = [];

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if(event is GetCompanyEvent){
      final res = await PolaApiRepository()
          .getCompany(event.code, 111111)
          .then((value) {
        _list.add(value);
      });
      _list = _list.toSet().toList().reversed.toList();
      yield HomeLoaded(_list);
    }
  }
}
