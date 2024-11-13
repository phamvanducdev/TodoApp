import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_plugin/core/models/task.dart';

class LocalStorageService {
  final SharedPreferences _prefs;

  LocalStorageService({required SharedPreferences prefs}) : _prefs = prefs;

  static const String _taskListKey = 'taskList';

  Future<List<Task>> getTasks() async {
    final taskListString = _prefs.getString(_taskListKey);

    if (taskListString != null) {
      final List<dynamic> jsons = jsonDecode(taskListString);
      return jsons.map((json) => Task.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  Future<void> setTasks(List<Task> tasks) async {
    final taskListString = jsonEncode(tasks.map((task) => task.toJson()).toList());
    await _prefs.setString(_taskListKey, taskListString);
  }
}
