import 'dart:convert' as convert;

import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:wenku8x/app/ui/router.dart';
import 'package:xml/xml.dart';

class Wenku8Interceptor extends Interceptor {
  final String _APPVER = "1.13";
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final param = options.data.toString();
    FormData formData = FormData.fromMap({
      "appver": _APPVER,
      "request": _encrypt(param),
      "timetoken": DateTime.now().millisecondsSinceEpoch,
    });
    options.data = formData;
    handler.next(options);
    // Remove super call as handler is already processed
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 200) {
      try {
        final xml = XmlDocument.parse(response.data.toString());
        handler.next(
          Response(
            requestOptions: response.requestOptions,
            data: xml,
            statusCode: response.statusCode,
            statusMessage: response.statusMessage,
            headers: response.headers,
            isRedirect: response.isRedirect,
            redirects: response.redirects,
            extra: response.extra,
          ),
        );
      } catch (e) {
        final code = int.tryParse(response.data.toString());
        if (code == null || code == 1) {
          handler.next(
            Response(
              requestOptions: response.requestOptions,
              data: response.data,
              statusCode: response.statusCode,
              statusMessage: response.statusMessage,
              headers: response.headers,
              isRedirect: response.isRedirect,
              redirects: response.redirects,
              extra: response.extra,
            ),
          );
        } else {
          handler.reject(
            DioException(
              requestOptions: response.requestOptions,
              response: response,
              error: int.parse(response.data),
              type: DioExceptionType.badResponse,
            ),
            true,
          );
        }
      }
    } else {
      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: '请求失败，状态码：${response.statusCode}',
          type: DioExceptionType.badResponse,
        ),
        true,
      );
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.error is int) {
      final errorCode = err.error as int;
      final errorMessage = _getErrorMessage(errorCode);
      if (errorCode == 4) {
        rootNavigatorKey.currentContext?.go("/login");
      }
      handler.next(
        DioException(
          requestOptions: err.requestOptions,
          response: Response(
            requestOptions: err.requestOptions,
            statusCode: errorCode,
            data: errorMessage,
          ),
          error: errorMessage,
        ),
      );
    } else {
      handler.next(err);
    }
  }

  String _encrypt(String param) {
    return convert.base64Encode(convert.utf8.encode(param));
  }

  static String _getErrorMessage(int code) {
    switch (code) {
      case 0:
        return '请求发生错误';
      case 1:
        return '操作成功';
      case 2:
        return '用户名错误';
      case 3:
        return '密码错误';
      case 4:
        return '请先登陆';
      case 5:
        return '已经在书架';
      case 6:
        return '书架已满';
      case 7:
        return '小说不在书架';
      case 8:
        return '回复帖子主题不存在';
      case 9:
        return '签到失败';
      case 10:
        return '推荐失败';
      case 11:
        return '帖子发送失败';
      case 22:
        return 'refer page 0';
      default:
        return 'Unknown error';
    }
  }
}
