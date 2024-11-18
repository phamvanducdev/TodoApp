import 'package:todo_plugin/data/models/task.dart';
import 'package:todo_plugin/data/repositories/task_repository.dart';

class GetAllTasksUseCase {
  final TaskRepository _repository;

  GetAllTasksUseCase({
    required TaskRepository repository,
  }) : _repository = repository;

  Future<List<Task>> execute() => _repository.get();
}
