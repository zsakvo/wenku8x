import 'package:shared_preferences/shared_preferences.dart';

import 'dio.dart';

class Api {
  /// 登陆
  static login(String username, String password) async {
    final usernameEncoded = Uri.encodeComponent(username);
    final passwordEncoded = Uri.encodeComponent(password);
    return await Ajax.post(
      "action=login&username=$usernameEncoded&password=$passwordEncoded",
      isXml: false,
    ).then((value) {
      final sp = SharedPreferencesAsync();
      if (value) {
        sp.setString("username", username);
        sp.setString("password", password);
      }
      return value;
    });
  }
}
