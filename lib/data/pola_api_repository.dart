import 'dart:convert';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;
import 'package:pola_flutter/data/api_response.dart';
import 'package:pola_flutter/data/pola_api_service.dart';
import 'package:pola_flutter/data/device_id_service.dart';
import 'package:pola_flutter/models/search_result.dart';

abstract class PolaApi {
  Future<ApiResponse<SearchResult>> getCompany(String code);
  Future<bool> createReport({
    required String description,
    int? productId,
  });
}

class PolaApiRepository implements PolaApi {
  late final PolaApiService _polaApiService;
  late final DeviceIdService _deviceIdService;

  PolaApiRepository(){
    _polaApiService = PolaApiService.create();
    DeviceIdService.create().then((value) => _deviceIdService = value);
  }

  @override
  Future<ApiResponse<SearchResult>> getCompany(String code) async {
    SearchResult? result;
    Response response;
    try{
      response = await _polaApiService.getCompany(code, _deviceIdService.uuid);
    }on SocketException catch (exception){
      return ApiResponse.error(exception.message);
    }

    if(response.isSuccessful){
      Map<String, dynamic> map = json.decode(response.body);
      result = SearchResult.fromJson(map);
      return ApiResponse<SearchResult>.completed(result);
    }
    return ApiResponse.error(response.bodyString);
  }

  @override
  Future<bool> createReport({
    required String description,
    int? productId,
  }) async {
    try {
      final body = <String, dynamic>{'description': description};
      if (productId != null) body['product_id'] = productId;

      final uri = Uri.parse('https://www.pola-app.pl/a/v4/create_report')
          .replace(queryParameters: {'device_id': _deviceIdService.uuid});

      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );
      return response.statusCode >= 200 && response.statusCode < 300;
    } on SocketException {
      return false;
    }
  }
}
