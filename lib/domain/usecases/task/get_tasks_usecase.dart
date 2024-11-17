import 'package:todo_plugin/data/models/task.dart';
import 'package:todo_plugin/data/repositories/task_repository.dart';
import 'package:todo_plugin/utils/date_time_utils.dart';
import 'package:todo_plugin/utils/extensions/date_time_extension.dart';

class GetTasksUseCase {
  final TaskRepository _repository;

  GetTasksUseCase({
    required TaskRepository repository,
  }) : _repository = repository;

  Future<List<Task>> execute({DateTime? startTime}) async {
    final taskList = await _repository.get();
    if (startTime != null) {
      return taskList.where((task) => DateTimeUtils.from(task.startTime).isSameDate(startTime)).toList();
    }
    return taskList;
  }
}
