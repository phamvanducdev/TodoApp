import 'package:todo_plugin/data/models/task.dart';
import 'package:todo_plugin/data/models/todo.dart';
import 'package:todo_plugin/utils/date_time_utils.dart';

extension TaskListExtension on List<Task> {
  Map<int, List<Task>> groupTasksByMonth() {
    final Map<int, List<Task>> tasksByMonth = {};
    sort((a, b) => a.startTime.compareTo(b.startTime));
    for (final Task task in this) {
      DateTime startDate = DateTimeUtils.from(task.startTime);
      int month = startDate.month;
      if (tasksByMonth.containsKey(month)) {
        tasksByMonth[month]?.add(task);
      } else {
        tasksByMonth[month] = [task];
      }
    }
    return tasksByMonth;
  }

  List<Task> filterCompleted() {
    return where((task) {
      return !task.todoList.any((Todo todo) => !todo.completed);
    }).toList();
  }
}
