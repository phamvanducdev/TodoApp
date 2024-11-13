import 'package:todo_plugin/core/models/task.dart';
import 'package:todo_plugin/core/repositories/task_repository.dart';
import 'package:todo_plugin/core/services/local_storage_service.dart';

class LocalTaskRepository implements TaskRepository {
  final LocalStorageService _service;

  LocalTaskRepository({required LocalStorageService service}) : _service = service;

  @override
  Future<List<Task>> get() {
    return _service.getTasks();
  }

  @override
  Future<void> add(Task task) async {
    final tasks = await get();
    tasks.add(task);
    await _service.setTasks(tasks);
  }

  @override
  Future<bool> update(Task task) async {
    final tasks = await _service.getTasks();
    final index = tasks.indexWhere((t) => t.id == task.id);

    if (index != -1) {
      tasks[index] = task;
      await _service.setTasks(tasks);
      return true;
    }
    return false;
  }

  @override
  Future<void> remove(int id) async {
    final tasks = await _service.getTasks();
    tasks.removeWhere((task) => task.id == id);
    await _service.setTasks(tasks);
  }
}
