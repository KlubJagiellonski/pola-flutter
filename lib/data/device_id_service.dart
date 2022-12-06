import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

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

saveDeviceId(String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print('saving device_id ' + id);
  await prefs.setString('device_id', id);
}
