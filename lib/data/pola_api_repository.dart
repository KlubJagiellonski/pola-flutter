import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:pola_flutter/data/pola_api_service.dart';
import 'package:pola_flutter/models/search_result.dart';

abstract class PolaApi {
  Future<SearchResult?> getCompany(int code, int deviceId);
}

class PolaApiRepository implements PolaApi {
  final PolaApiService _polaApiService = PolaApiService.create();

  @override
  Future<SearchResult?> getCompany(int code, int deviceId) async {
    SearchResult? result;
    await _polaApiService.getCompany(code, deviceId).then((response) {
      Map<String, dynamic> map = json.decode(response.body);
      result = SearchResult.fromJson(map);
    });
    return result;
  }
}
