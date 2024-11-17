import 'package:todo_plugin/core/models/task.dart';
import 'package:todo_plugin/core/repositories/task_repository.dart';

class UpdateTaskUseCase {
  final TaskRepository _repository;

  UpdateTaskUseCase({
    required TaskRepository repository,
  }) : _repository = repository;

  Future<bool> execute(Task task) => _repository.update(task);
}
