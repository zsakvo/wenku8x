import 'package:logger/logger.dart';

class Log {
  static final Logger _logger = Logger(printer: PrefixPrinter(PrettyPrinter()));
  static void v(message, [String? tag]) {
    _logger.v(message, tag);
  }

  static void d(dynamic message, [String? tag]) {
    _logger.d(message, tag);
  }

  static void i(dynamic message, [String? tag]) {
    _logger.i(message, tag);
  }

  static void w(dynamic message, [String? tag]) {
    _logger.w(message, tag);
  }

  static void e(dynamic message, [String? tag]) {
    _logger.e(message, tag);
  }

  static void wtf(dynamic message, [String? tag]) {
    _logger.wtf(message, tag);
  }
}
