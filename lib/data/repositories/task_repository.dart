import 'package:todo_plugin/data/models/task.dart';

abstract class TaskRepository {
  Future<List<Task>> get();
  Future<void> create(Task task);
  Future<bool> update(Task task);
  Future<void> remove(int id);
}
