import 'package:flutter_logs/flutter_logs.dart';

const _logsWriteDirectoryName = 'app_logs';
const _logsExportDirectoryName = 'app_logs/exported';
const _tag = 'keep_mindful_device';

class AppLogger {
  const AppLogger._();

  static Future<void> init() async {
    await FlutterLogs.initLogs(
        logLevelsEnabled: [LogLevel.INFO, LogLevel.ERROR],
        timeStampFormat: TimeStampFormat.TIME_FORMAT_READABLE,
        directoryStructure: DirectoryStructure.FOR_DATE,
        logFileExtension: LogFileExtension.LOG,
        logsWriteDirectoryName: _logsWriteDirectoryName,
        logsExportDirectoryName: _logsExportDirectoryName);
  }

  static void writeInfo({required String title, required String message}) {
    FlutterLogs.logInfo(_tag, title, message);
  }

  static void writeError({required String title, required String message}) {
    FlutterLogs.logError(_tag, title, message);
  }
}
