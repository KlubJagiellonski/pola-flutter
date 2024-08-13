// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pola_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$PolaApiService extends PolaApiService {
  _$PolaApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = PolaApiService;

  @override
  Future<Response<dynamic>> getCompany(
    String code,
    String deviceId,
  ) {
    final Uri $url = Uri.parse('a/v4/get_by_code');
    final Map<String, dynamic> $params = <String, dynamic>{
      'code': code,
      'device_id': deviceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
