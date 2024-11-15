import 'package:todo_plugin/core/models/task.dart';
import 'package:todo_plugin/core/repositories/task_repository.dart';
import 'package:todo_plugin/utils/date_time_utils.dart';

class GetAvailablePriorityTaskUseCase {
  final TaskRepository _repository;

  GetAvailablePriorityTaskUseCase({
    required TaskRepository repository,
  }) : _repository = repository;

  Future<List<Task>> execute() async {
    final List<Task> tasks = await _repository.get();
    // Filter prioritize and valid time
    return tasks.where((task) {
      final DateTime endTime = DateTimeUtils.from(task.endTime);
      return task.priority && endTime.isAfter(DateTime.now());
    }).toList();
  }
}
