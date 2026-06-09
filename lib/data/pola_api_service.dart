import 'package:chopper/chopper.dart';
part 'pola_api_service.chopper.dart';

@ChopperApi()
abstract class PolaApiService extends ChopperService {
  //example code 5900311000360
  @GET(path: 'a/v4/get_by_code')
  Future<Response> getCompany(
      @Query("code") String code, @Query("device_id") String deviceId);

  @POST(path: 'a/v4/create_report')
  Future<Response> createReport(
      @Query("device_id") String deviceId,
      @Body() Map<String, dynamic> body);

  static PolaApiService create() {
    final client = ChopperClient(
      baseUrl: Uri.parse('https://www.pola-app.pl'),
      interceptors: [HttpLoggingInterceptor()],
      converter: JsonConverter(),
      services: [
        _$PolaApiService(),
      ],
    );
    return _$PolaApiService(client);
  }
}
