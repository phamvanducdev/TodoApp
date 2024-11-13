import 'package:todo_plugin/core/repositories/task_repository.dart';

class RemoveTaskUseCase {
  final TaskRepository _repository;

  RemoveTaskUseCase({required TaskRepository repository}) : _repository = repository;

  Future<void> execute(int id) => _repository.remove(id);
}
