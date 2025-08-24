import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

class LogFilter {
  static final List<String> _filteredMessages = [
    'ImageReader_JNI',
    'Unable to acquire a buffer item',
    'very likely client tried to acquire more than maxImages buffers',
    'BufferPoolAccessor2.0',
    'EGL_emulation',
    'app_time_stats',
    'CCodec',
    'CCodecConfig',
    'MediaCodec',
    'Surface',
    'Codec2',
    'ReflectedParamUpdater',
  ];

  static void setupLogFilter() {
    if (kDebugMode) {
      // Setup custom logging in debug mode
      debugPrint('Log filter active - hiding buffer warnings');
    }
  }

  static void info(String message) {
    if (!_shouldFilterMessage(message)) {
      developer.log(message, level: 800);
    }
  }

  static void warning(String message) {
    if (!_shouldFilterMessage(message)) {
      developer.log(message, level: 900);
    }
  }

  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    if (!_shouldFilterMessage(message)) {
      developer.log(message, level: 1000, error: error, stackTrace: stackTrace);
    }
  }

  static void debug(String message) {
    if (!_shouldFilterMessage(message) && kDebugMode) {
      developer.log(message, level: 700);
    }
  }

  static bool _shouldFilterMessage(String message) {
    return _filteredMessages.any((filter) => message.contains(filter));
  }
}
