import 'package:todo_plugin/data/models/task.dart';
import 'package:todo_plugin/data/repositories/task_repository.dart';
import 'package:todo_plugin/utils/date_time_utils.dart';
import 'package:todo_plugin/utils/extensions/date_time_extension.dart';

class GetTasksByDateUsecase {
  final TaskRepository _repository;

  GetTasksByDateUsecase({
    required TaskRepository repository,
  }) : _repository = repository;

  Future<List<Task>> execute({required DateTime dateTime}) async {
    final taskList = await _repository.get();
    return taskList.where((task) {
      final startTime = DateTimeUtils.from(task.startTime);
      final endTime = DateTimeUtils.from(task.endTime);
      return startTime.isSameOrBeforeDate(dateTime) && endTime.isSameOrAfterDate(dateTime);
    }).toList();
  }
}
