import 'package:todo_plugin/core/models/task.dart';

abstract class TaskRepository {
  Future<List<Task>> get();
  Future<void> add(Task task);
  Future<bool> update(Task task);
  Future<void> remove(int id);
}
