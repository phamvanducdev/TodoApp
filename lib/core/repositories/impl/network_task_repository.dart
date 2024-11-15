import 'package:todo_plugin/core/models/task.dart';
import 'package:todo_plugin/core/repositories/task_repository.dart';
import 'package:todo_plugin/core/services/network_storage_service.dart';

class NetworkTaskRepository implements TaskRepository {
  // ignore: unused_field
  final NetworkStorageService _service;

  NetworkTaskRepository({required NetworkStorageService service}) : _service = service;

  @override
  Future<List<Task>> get() {
    // TODO: implement
    return Future.value([]);
  }

  @override
  Future<void> add(Task task) async {
    // TODO: implement
    return Future.value();
  }

  @override
  Future<bool> update(Task task) async {
    // TODO: implement
    return Future.value(false);
  }

  @override
  Future<void> remove(int id) async {
    // TODO: implement
    return Future.value();
  }
}
