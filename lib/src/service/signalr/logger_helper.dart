import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

class LoggerHelper {
  static LoggerHelper? _instance;
  late final Logger hubProtocolLogger;
  late final Logger transporterLogger;
  static LoggerHelper get instance {
    _instance ??= LoggerHelper._();
    return _instance!;
  }

  LoggerHelper._() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((LogRecord rec) {
      if (kDebugMode) ('${rec.level.name}: ${rec.time}: ${rec.message}');
    });

    hubProtocolLogger = Logger("SignalR - hub");
    transporterLogger = Logger("SignalR - transport");
  }
}
