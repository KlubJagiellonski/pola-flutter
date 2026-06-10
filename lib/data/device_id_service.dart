import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/foundation.dart';

class DeviceIdService {
  DeviceIdService(this.uuid);

  final String uuid;

  static Future<DeviceIdService> create() async {
    var prefs = await SharedPreferences.getInstance();
    var deviceId = prefs.getString("device_id");
    if (deviceId == null) {
      deviceId = Uuid().v4();
      saveDeviceId(deviceId);
    }
    return DeviceIdService(deviceId);
  }
}

Future<void> saveDeviceId(String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  debugPrint('saving device_id $id');
  await prefs.setString('device_id', id);
}
