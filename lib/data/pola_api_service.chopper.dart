// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pola_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$PolaApiService extends PolaApiService {
  _$PolaApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = PolaApiService;

  @override
  Future<Response<dynamic>> getCompany(
    int code,
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
