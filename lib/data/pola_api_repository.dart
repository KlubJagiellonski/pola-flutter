import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:pola_flutter/data/api_response.dart';
import 'package:pola_flutter/data/pola_api_service.dart';
import 'package:pola_flutter/data/device_id_service.dart';
import 'package:pola_flutter/models/search_result.dart';

abstract class PolaApi {
  Future<ApiResponse<SearchResult>> getCompany(String code);
  Future<bool> createReport({required String description, int? productId});
}

class PolaApiRepository implements PolaApi {
  final PolaApiService _polaApiService;
  final DeviceIdService _deviceIdService;

  PolaApiRepository({
    required DeviceIdService deviceIdService,
    PolaApiService? polaApiService,
  }) : _deviceIdService = deviceIdService,
       _polaApiService = polaApiService ?? PolaApiService.create();

  @override
  Future<ApiResponse<SearchResult>> getCompany(String code) async {
    SearchResult? result;
    Response response;
    try {
      response = await _polaApiService.getCompany(code, _deviceIdService.uuid);
    } on SocketException catch (exception) {
      return ApiResponse.error(exception.message);
    }

    if (response.isSuccessful) {
      result = SearchResult.fromJson(response.body as Map<String, dynamic>);
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
      final response = await _polaApiService.createReport(
        _deviceIdService.uuid,
        body,
      );
      return response.isSuccessful;
    } on SocketException {
      return false;
    }
  }
}
