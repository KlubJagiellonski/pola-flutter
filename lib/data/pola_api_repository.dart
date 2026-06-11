import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:pola_flutter/data/api_response.dart';
import 'package:pola_flutter/data/pola_api_service.dart';
import 'package:pola_flutter/data/device_id_service.dart';
import 'package:pola_flutter/models/product_search_response.dart';
import 'package:pola_flutter/models/search_result.dart';

abstract class PolaApi {
  Future<ApiResponse<SearchResult>> getCompany(String code);
<<<<<<< HEAD
=======
  Future<ApiResponse<ProductSearchResponse>> searchProducts(
    String query, {
    String? pageToken,
  });
>>>>>>> 01f81a5 (Refactor Webview Search to Native)
  Future<bool> createReport({required String description, int? productId});
}

class PolaApiRepository implements PolaApi {
  final PolaApiService _polaApiService;
<<<<<<< HEAD
  final DeviceIdService _deviceIdService;

  PolaApiRepository({
    required DeviceIdService deviceIdService,
    PolaApiService? polaApiService,
  }) : _deviceIdService = deviceIdService,
       _polaApiService = polaApiService ?? PolaApiService.create();
=======
  final Future<DeviceIdService> _deviceIdServiceFuture;

  PolaApiRepository({
    PolaApiService? polaApiService,
    Future<DeviceIdService>? deviceIdServiceFuture,
  }) : _polaApiService = polaApiService ?? PolaApiService.create(),
       _deviceIdServiceFuture =
           deviceIdServiceFuture ?? DeviceIdService.create();
>>>>>>> 01f81a5 (Refactor Webview Search to Native)

  @override
  Future<ApiResponse<SearchResult>> getCompany(String code) async {
    SearchResult? result;
    Response response;
    try {
<<<<<<< HEAD
      response = await _polaApiService.getCompany(code, _deviceIdService.uuid);
=======
      final deviceIdService = await _deviceIdServiceFuture;
      response = await _polaApiService.getCompany(code, deviceIdService.uuid);
>>>>>>> 01f81a5 (Refactor Webview Search to Native)
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
  Future<ApiResponse<ProductSearchResponse>> searchProducts(
    String query, {
    String? pageToken,
  }) async {
    Response response;
    try {
      final deviceIdService = await _deviceIdServiceFuture;
      response = await _polaApiService.searchProducts(
        query,
        pageToken,
        deviceIdService.uuid,
      );
    } on SocketException catch (exception) {
      return ApiResponse.error(exception.message);
    }

    if (response.isSuccessful) {
      final result = ProductSearchResponse.fromJson(
        response.body as Map<String, dynamic>,
      );
      return ApiResponse<ProductSearchResponse>.completed(result);
    }
    return ApiResponse.error(response.bodyString);
  }

  @override
  Future<bool> createReport({
    required String description,
    int? productId,
  }) async {
    try {
      final deviceIdService = await _deviceIdServiceFuture;
      final body = <String, dynamic>{'description': description};
      if (productId != null) body['product_id'] = productId;
      final response = await _polaApiService.createReport(
        deviceIdService.uuid,
        body,
      );
      return response.isSuccessful;
    } on SocketException {
      return false;
    }
  }
}
