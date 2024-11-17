import 'package:todo_plugin/core/models/task.dart';
import 'package:todo_plugin/core/repositories/task_repository.dart';

class AddTaskUseCase {
  final TaskRepository _repository;

  AddTaskUseCase({
    required TaskRepository repository,
  }) : _repository = repository;

  Future<void> execute(Task task) => _repository.create(task);
}
