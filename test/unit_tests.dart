import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pola_flutter/data/api_response.dart';
import 'package:pola_flutter/data/device_id_service.dart';
import 'package:pola_flutter/data/pola_api_repository.dart';
import 'package:pola_flutter/main.dart';
import 'package:pola_flutter/models/search_result.dart';
import 'package:pola_flutter/pages/scan/scan_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

void main() {
  SharedPreferences.setMockInitialValues({});

  group('ScanBloc', () {
    late ScanBloc scanBloc;
    Bloc.observer = SimpleBlocObserver();

    setUp(() {
      scanBloc = ScanBloc(MockPolaApi());
    });

    test('initial state is ScanEmpty()', () {
      expect(scanBloc.state, ScanEmpty());
    });
    blocTest(
      'emits ScanLoaded([searchResult1]) when GetCompanyEvent(5900311000360) is added',
      build: () => scanBloc,
      act: (bloc) => scanBloc.add(GetCompanyEvent(5900311000360)),
      expect: () => [ScanLoaded([searchResult1])],
    );
    blocTest(
      'emits ScanError("error") when GetCompanyEvent(0) is added',
      build: () => scanBloc,
      act: (bloc) => scanBloc.add(GetCompanyEvent(0)),
      expect: () => [ScanError("error")],
    );
  });

  group('PolaApiRepository', (){
    late PolaApiRepository polaApiRepository;
    setUp((){
      polaApiRepository = PolaApiRepository();
      //todo
    });
  });

  group('PolaApiService', (){
    late PolaApiRepository polaApiRepository;
    setUp((){
      polaApiRepository = PolaApiRepository();
      //todo
    });
  });

  group('DeviceIdService', (){
    late DeviceIdService deviceIdService;
    late SharedPreferences sharedPreferences;
    final String TEST_ID = "TEST_ID";

    setUp(() async {
      sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString("device_id", TEST_ID);
      await DeviceIdService.create().then((value) => deviceIdService = value);
    });
    test('initial device_id is TEST_ID', () async {
      expect(deviceIdService.uuid, sharedPreferences.getString("device_id"));
    });
    test('after removing the device_id, a new device_id is generated', () async {
      sharedPreferences.remove("device_id");
      await DeviceIdService.create().then((value) => deviceIdService = value);
      expect(deviceIdService.uuid, isNot(sharedPreferences.getString("device_id")));
      expect(deviceIdService.uuid, isNot(""));
    });
    test('after removing the device_id, a new device_id is generated and saved', () async {
      sharedPreferences.remove("device_id");
      await DeviceIdService.create().then((value) => deviceIdService = value);
      await Future.delayed(const Duration(seconds: 1), (){});
      expect(deviceIdService.uuid, sharedPreferences.getString("device_id"));
    });
  });
}

var searchResult1 = SearchResult(
    productId: 5900311000360,
    code: "code",
    name: "name",
    cardType: "card",
    companies: [],
    report: null,
    donate: null);

class MockPolaApi extends PolaApi {
  @override
  Future<ApiResponse<SearchResult>> getCompany(int code) {
    print("MockPolaApi getCompany " + code.toString());
    if (code == 5900311000360) {
      return Future.value(ApiResponse.completed(searchResult1));
    } else {
      return Future.value(ApiResponse.error("error"));
    }
  }
}
