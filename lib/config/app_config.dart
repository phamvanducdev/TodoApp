import 'package:todo_plugin/di/app_get_it.dart';

class AppConfig {
  static bool _initialized = false;
  static String packageName = 'todo_plugin';

  static Future<void> initialized() async {
    if (_initialized) return;
    // Initialize configurations and services.
    await AppGetIt.register();
    _initialized = true;
  }
}
