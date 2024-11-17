import 'package:todo_plugin/core/models/task.dart';
import 'package:todo_plugin/core/repositories/task_repository.dart';
import 'package:todo_plugin/core/services/local/task_storage_service.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskStorageService _service;

  TaskRepositoryImpl({required TaskStorageService service}) : _service = service;

  @override
  Future<List<Task>> get() => _service.getTaskList();

  @override
  Future<void> create(Task task) async {
    final List<Task> taskList = await get();
    taskList.add(task);
    await _service.setTaskList(taskList);
  }

  @override
  Future<bool> update(Task task) async {
    final List<Task> taskList = await _service.getTaskList();
    final index = taskList.indexWhere((t) => t.id == task.id);

    if (index != -1) {
      taskList[index] = task;
      await _service.setTaskList(taskList);
      return true;
    }
    return false;
  }

  @override
  Future<void> remove(int id) async {
    final List<Task> taskList = await _service.getTaskList();
    taskList.removeWhere((task) => task.id == id);
    await _service.setTaskList(taskList);
  }
}
