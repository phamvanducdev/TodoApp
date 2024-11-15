import 'package:todo_plugin/core/models/task.dart';
import 'package:todo_plugin/core/repositories/task_repository.dart';

class GetTasksUseCase {
  final TaskRepository _repository;

  GetTasksUseCase({
    required TaskRepository repository,
  }) : _repository = repository;

  Future<List<Task>> execute() => _repository.get();
}
