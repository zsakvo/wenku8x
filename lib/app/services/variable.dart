import 'package:device_info_plus/device_info_plus.dart';

class VariableService {
  static final VariableService _instance = VariableService._internal();

  factory VariableService() {
    return _instance;
  }

  VariableService._internal();

  late String UserAgent;

  Future<void> init() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    UserAgent =
        "Dalvik/2.1.0 (Linux; ${androidInfo.brand}; Android ${androidInfo.version.release}; ${androidInfo.model})";
  }
}
