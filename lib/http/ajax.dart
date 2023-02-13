// ignore_for_file: non_constant_identifier_names, constant_identifier_names, unused_field, unused_element, use_build_context_synchronously

import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'dart:convert' as convert;

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wenku8x/http/api.dart';
import 'package:wenku8x/service/navigation.dart';
import 'package:wenku8x/utils/flash.dart';

import 'package:xml/xml.dart';

import '../utils/log.dart';

class Ajax {
  static String BASEURL = "http://app.wenku8.com/android.php";
  static String UA =
      "Dalvik/2.1.0 (Linux; U; Android 11; IN2010 Build/RP1A.201005.001)";
  static const String _APPVER = "1.13";

  ///超时时间
  static const int CONNECT_TIMEOUT = 30000;
  static const int RECEIVE_TIMEOUT = 30000;

  static late Dio _client;

  static late final SharedPreferences sp;

  static init() async {
    sp = await SharedPreferences.getInstance();
    Directory appDocDir = await getApplicationDocumentsDirectory();
    final cookieJar = PersistCookieJar(storage: FileStorage(appDocDir.path));
    _client = Dio(BaseOptions(
        baseUrl: BASEURL,
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT,
        contentType: Headers.formUrlEncodedContentType,
        headers: {
          "User-Agent": UA,
        }))
      ..interceptors.add(CookieManager(cookieJar));
  }

  static String _encrypt(String param) {
    return convert.base64Encode(convert.utf8.encode(param));
  }

  static Future<dynamic> post(String param, {bool isXml = true}) async {
    // 判断是否是登陆请求
    bool isLogin = param.contains("action=login");
    FormData formData = FormData.fromMap({
      "appver": _APPVER,
      "request": _encrypt(param),
      "timetoken": DateTime.now().millisecondsSinceEpoch
    });
    Log.d({
      "appver": _APPVER,
      "request": param,
      "timetoken": DateTime.now().millisecondsSinceEpoch
    }, "请求参数");
    try {
      var res = await _client.post("", data: formData);
      if (isXml) {
        try {
          return XmlDocument.parse(res.data.toString());
        } catch (err) {
          Log.e("请求失败，结果为：${res.data}");
          if (res.data == "4") {
            final username = sp.getString("username") ?? "";
            final password = sp.getString("password") ?? "";
            if (username.isNotEmpty && password.isNotEmpty) {
              var res = await API.login(username, password);
              Log.d(res, "relogin");
              if (res) {
                post(param, isXml: isXml);
              }
            }
            // showErrorToast(NavigationService.navigatorKey.currentContext, "鉴权信息失效，请重新登陆账户");
          }
          return null;
        }
      } else {
        if (isLogin) {
          return res.data.toString() == "1";
        } else {
          return res.data.toString();
        }
      }
    } catch (err) {
      showErrorToast(
          NavigationService.navigatorKey.currentContext, err.toString());
      rethrow;
    }
  }
}
