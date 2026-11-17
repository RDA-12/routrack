import 'dart:developer';

import 'package:logging/logging.dart';

final _loggers = <String, AppLogger>{};

/// Logger class for the app
class AppLogger {
  /// Returns [AppLogger] instace for [name]
  factory(String name) {
    final logger = _loggers[name];
    if (logger == null) {
      _loggers[name] = AppLogger._(name);
      return _loggers[name]!;
    }
    return logger;
  }

  /// Creates new [AppLogger]
  new _(String name) : _logger = Logger(name);

  final Logger _logger;

  /// Initialize [AppLogger]
  ///
  /// Typically called once before runApp
  static void initialize() {
    Logger.root.onRecord.listen((record) {
      final message =
          '[${record.level}] [${record.loggerName}] [${record.time}]: '
          '${record.message}';
      log(message);
      if (record.error != null) {
        log('\n');
        log('[ERROR]: ${record.error}');
      }
      if (record.stackTrace != null) {
        log('\n');
        log('[Stack Trace]:\n');
        log('${record.stackTrace}');
      }
    });
  }

  /// Log [message] in info level
  void logInfo(String message) {
    _logger.info(message);
  }

  /// Log [message] in debug level
  void logDebug(String message) {
    _logger.fine(message);
  }

  /// Log [message] in error level
  void logError(
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.severe(message, error, stackTrace);
  }
}

/// Provides methods to log message
mixin Loggable {
  /// Log [message] in info level
  void logInfo(String message) {
    AppLogger('$runtimeType').logInfo(message);
  }

  /// Log [message] in debug level
  void logDebug(String message) {
    AppLogger('$runtimeType').logDebug(message);
  }

  /// Log [message] in error level
  void logError(String message, {Object? error, StackTrace? stackTrace}) {
    AppLogger('$runtimeType').logError(
      message,
      error: error,
      stackTrace: stackTrace,
    );
  }
}
