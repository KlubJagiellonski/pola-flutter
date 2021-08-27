import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:pola_flutter/data/pola_api_service.dart';
import 'package:pola_flutter/data/device_id_service.dart';
import 'package:pola_flutter/models/search_result.dart';

abstract class PolaApi {
  Future<SearchResult?> getCompany(int code);
}

class PolaApiRepository implements PolaApi {
  late final PolaApiService _polaApiService;
  late final DeviceIdService _deviceIdService;

  PolaApiRepository(){
    _polaApiService = PolaApiService.create();
    DeviceIdService.create().then((value) => _deviceIdService = value);
  }

  @override
  Future<SearchResult?> getCompany(int code) async {
    SearchResult? result;
    await _polaApiService.getCompany(code, _deviceIdService.uuid).then((response) {
      Map<String, dynamic> map = json.decode(response.body);
      result = SearchResult.fromJson(map);
    });
    return result;
  }
}
