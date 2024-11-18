import 'package:todo_plugin/data/models/task.dart';
import 'package:todo_plugin/data/repositories/task_repository.dart';
import 'package:todo_plugin/utils/date_time_utils.dart';

class GetTasksByYearUseCase {
  final TaskRepository _repository;

  GetTasksByYearUseCase({
    required TaskRepository repository,
  }) : _repository = repository;

  /// Filter by start time in the year
  Future<List<Task>> execute({required int year}) async {
    final taskList = await _repository.get();
    return taskList.where((task) {
      final startTime = DateTimeUtils.from(task.startTime);
      return startTime.year == year;
    }).toList();
  }
}
