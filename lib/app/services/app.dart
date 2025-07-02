import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:wenku8x/app/libs/request/dio.dart';
import 'package:wenku8x/app/services/log.dart';
import 'package:wenku8x/app/services/path.dart';
import 'package:wenku8x/app/services/variable.dart';

class AppService {
  static final AppService _instance = AppService._internal();
  factory AppService() => _instance;
  AppService._internal();

  bool _isInitialized = false;
  final Completer<void> _initializedCompleter = Completer<void>();

  bool get isInitialized => _isInitialized;

  Future<void> get initialized => _initializedCompleter.future;

  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      await PathService().init();
      await VariableService().init();
      await await Ajax.init();
      initLogService();

      _isInitialized = true;
      _initializedCompleter.complete();

      debugPrint('App service initialized successfully');
    } catch (e) {
      _initializedCompleter.completeError(e);
      debugPrint('Failed to initialize app service: $e');
      rethrow;
    }
  }
}
