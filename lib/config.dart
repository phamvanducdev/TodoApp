import 'package:todo_plugin/di/di.dart';

class TodoAppConfig {
  static bool _initialized = false;
  static String packageName = 'todo_plugin';

  static Future<void> initialized() async {
    if (_initialized) return;
    // Initialize configurations and services.
    await DI.register();
    _initialized = true;
  }
}
