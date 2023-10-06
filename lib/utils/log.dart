import 'package:logger/logger.dart';

class Log {
  static final _logger = Logger(
    printer: PrettyPrinter(
        methodCount: 2, // Number of method calls to be displayed
        errorMethodCount: 2, // Number of method calls if stacktrace is provided
        lineLength: 120, // Width of the output
        colors: true, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        printTime: false // Should each log print contain a timestamp
        ),
  );

  static void t(message, [String? tag]) {
    _logger.t(message, error: tag);
  }

  static void d(dynamic message, [String? tag]) {
    _logger.d(message, error: tag);
  }

  static void i(dynamic message, [String? tag]) {
    _logger.i(message, error: tag);
  }

  static void w(dynamic message, [String? tag]) {
    _logger.w(message, error: tag);
  }

  static void e(dynamic message, [String? tag]) {
    _logger.e(message, error: tag);
  }

  static void f(dynamic message, [String? tag]) {
    _logger.f(message, error: tag);
  }
}
