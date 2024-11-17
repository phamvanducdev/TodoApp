import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_plugin/data/models/task.dart';
import 'package:todo_plugin/utils/constants.dart';

class TaskStorageService {
  final SharedPreferences _prefs;

  TaskStorageService({required SharedPreferences prefs}) : _prefs = prefs;

  Future<List<Task>> getTaskList() async {
    final taskListString = _prefs.getString(AppConstants.TASK_STORAGE_KEY);

    if (taskListString != null) {
      final List<dynamic> jsons = jsonDecode(taskListString);
      return jsons.map((json) => Task.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  Future<void> setTaskList(List<Task> tasks) async {
    final taskListString = jsonEncode(tasks.map((task) => task.toJson()).toList());
    await _prefs.setString(AppConstants.TASK_STORAGE_KEY, taskListString);
  }
}
