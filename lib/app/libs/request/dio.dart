import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ubuntu_logger/ubuntu_logger.dart';
import 'package:wenku8x/app/libs/request/cookie.dart';
import 'package:wenku8x/app/services/variable.dart';
import 'package:wenku8x/app/ui/router.dart';
import 'package:wenku8x/app/utils/flash.dart';
import 'dart:convert' as convert;

import 'package:xml/xml.dart';

import 'logs.dart';
import 'wenku8.dart';

class Ajax {
  static final logger = Logger("Request");
  static String BASEURL = "http://app.wenku8.com/android.php";
  // static String UA =
  //     "Dalvik/2.1.0 (Linux; U; Android 11; IN2010 Build/RP1A.201005.001)";
  static const String _APPVER = "1.13";

  ///超时时间
  static const int CONNECT_TIMEOUT = 30000;
  static const int RECEIVE_TIMEOUT = 30000;

  static late Dio _client;

  static late final SharedPreferences sp;

  static init() async {
    sp = await SharedPreferences.getInstance();
    final cookieJar = prepareJar();
    _client =
        Dio(
            BaseOptions(
              baseUrl: BASEURL,
              connectTimeout: const Duration(milliseconds: CONNECT_TIMEOUT),
              receiveTimeout: const Duration(milliseconds: RECEIVE_TIMEOUT),
              contentType: Headers.formUrlEncodedContentType,
              headers: {"User-Agent": VariableService().UserAgent},
            ),
          )
          ..interceptors.add(CookieManager(cookieJar))
          ..interceptors.add(Wenku8Interceptor())
          ..interceptors.add(LogsInterceptor());
  }

  static post(String param) {
    return _client.post("", data: param);
  }

  static download(String param) {
    return _client.download(
      "",
      "",
      data: param,
      options: Options(method: "POST"),
    );
  }

  // static String _encrypt(String param) {
  //   return convert.base64Encode(convert.utf8.encode(param));
  // }

  // static Future<dynamic> post(
  //   String param, {
  //   bool isXml = true,
  //   download = false,
  //   savePath = "",
  // }) async {
  //   // 判断是否是登陆请求
  //   bool isLogin = param.contains("action=login");
  //   FormData formData = FormData.fromMap({
  //     "appver": _APPVER,
  //     "request": _encrypt(param),
  //     "timetoken": DateTime.now().millisecondsSinceEpoch,
  //   });
  //   logger.debug({
  //     "appver": _APPVER,
  //     "request": param,
  //     "timetoken": DateTime.now().millisecondsSinceEpoch,
  //     "实际参数": _encrypt(param),
  //   }, "请求参数");
  //   try {
  //     var res = download
  //         ? await _client.download(
  //             "",
  //             savePath,
  //             data: formData,
  //             options: Options(method: "POST"),
  //           )
  //         : (await _client.post("", data: formData));
  //     if (isXml) {
  //       try {
  //         return XmlDocument.parse(res.data.toString());
  //       } catch (err) {
  //         logger.error("请求失败，结果为：${res.data}");
  //         if (res.data == "4") {
  //           // final username = sp.getString("username") ?? "";
  //           // final password = sp.getString("password") ?? "";
  //           // if (username.isNotEmpty && password.isNotEmpty) {
  //           //   var res = await Api.login(username, password);
  //           //   logger.debug(res, "relogin");
  //           //   if (res) {
  //           //     post(param, isXml: isXml);
  //           //   }
  //           // }
  //           // showErrorToast(NavigationService.navigatorKey.currentContext, "鉴权信息失效，请重新登陆账户");
  //           rootNavigatorKey.currentContext?.go("/login");
  //         }
  //         return null;
  //       }
  //     } else {
  //       if (isLogin) {
  //         return res.data.toString() == "1";
  //       } else {
  //         return res.data.toString();
  //       }
  //     }
  //   } catch (err) {
  //     FlashHelper.showError(err);
  //     // GoRouter.of(NavigationService.navigatorKey.currentContext!)
  //     //     .go("/error/$err");
  //     rethrow;
  //   }
  // }
}
