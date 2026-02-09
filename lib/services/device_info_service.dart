import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoService {
  static Future<Map<String, String>> getDeviceData() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final android = await deviceInfo.androidInfo;

      return {
        "device_id": android.id ?? "",
        "device_name": android.device ?? "",
        "device_modal": android.model ?? "",
      };
    }

    return {
      "device_id": "unknown",
      "device_name": "unknown",
      "device_modal": "unknown",
    };
  }
}
