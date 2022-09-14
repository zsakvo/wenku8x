// ignore_for_file: non_constant_identifier_names, constant_identifier_names, unused_field, unused_element

import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'dart:convert' as convert;

import 'package:path_provider/path_provider.dart';

class Ajax {
  static String BASEURL = "http://app.wenku8.com/android.php";
  static String UA =
      "Dalvik/2.1.0 (Linux; U; Android 11; IN2010 Build/RP1A.201005.001)";
  static const String _APPVER = "1.13";

  ///超时时间
  static const int CONNECT_TIMEOUT = 30000;
  static const int RECEIVE_TIMEOUT = 30000;

  static late Dio _client;

  static init() async {
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
}
