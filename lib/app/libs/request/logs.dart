import 'dart:convert' as convert;
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:toastification/toastification.dart';
import 'package:ubuntu_logger/ubuntu_logger.dart';

class LogsInterceptor extends Interceptor {
  final logger = Logger("Dio");
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.debug('Request: ${options.method} ${options.path}');
    logger.debug('Headers: ${options.headers}');
    logger.debug(
      'Data: ${(options.data as FormData).fields.map((e) => '${e.key}: ${e.key == 'request' ?
            // base64 decode
            convert.utf8.decode(convert.base64.decode(e.value)) : e.value}').join(', ')}',
    );
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.debug('Response: ${response.statusCode} ${response.statusMessage}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.error('Error: ${err.error}');

    // 弹出 toast
    toastification.show(
      type: ToastificationType.error,
      title: Text("请求失败"),
      alignment: Alignment.bottomRight,
      description: Text(err.error is String ? err.error.toString() : '网络请求错误'),
      autoCloseDuration: Duration(seconds: 3),
    );

    super.onError(err, handler);
  }
}
