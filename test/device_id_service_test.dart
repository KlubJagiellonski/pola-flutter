import 'package:pola_flutter/data/device_id_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

void main() {
  SharedPreferences.setMockInitialValues({});

  group('DeviceIdService', (){
    late DeviceIdService deviceIdService;
    late SharedPreferences sharedPreferences;
    final String testID = "TEST_ID";

    setUp(() async {
      sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString("device_id", testID);
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
