part of 'http.dart';

@visibleForTesting
bool showHttpErrors = true;

// Obtiene la variable de entorno 'FLUTTER_TEST' de forma segura sin usar dart:io.
const bool isFlutterTest =
    bool.fromEnvironment('FLUTTER_TEST', defaultValue: false);

void _printLogs(
  Map<String, dynamic> logs,
  StackTrace? stackTrace,
) {
  if (kDebugMode) {
    // coverage:ignore-start
    if (isFlutterTest && logs.containsKey('exception') && showHttpErrors) {
      print(
        const JsonEncoder.withIndent('  ').convert(logs),
      );
      print(stackTrace);
    }
    // coverage:ignore-end
    log(
      '''
🔥
--------------------------------
${const JsonEncoder.withIndent('  ').convert(logs)}
--------------------------------
🔥
''',
      stackTrace: stackTrace,
    );
  }
}
