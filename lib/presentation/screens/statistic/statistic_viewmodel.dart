import 'package:rxdart/rxdart.dart';
import 'package:todo_plugin/data/models/task.dart';
import 'package:todo_plugin/domain/usecases/task/get_tasks_by_year_usecase.dart';
import 'package:todo_plugin/utils/extensions/date_time_extension.dart';
import 'package:todo_plugin/utils/extensions/task_list_extension.dart';

class StatisticViewModel {
  final GetTasksByYearUseCase _getTasksUseCase;

  StatisticViewModel({
    required GetTasksByYearUseCase getTasksUseCase,
  }) : _getTasksUseCase = getTasksUseCase;

  final _currentYearSubject = BehaviorSubject<DateTime>.seeded(DateTime.now().startOfYear());
  Stream<DateTime> get currentYearStream => _currentYearSubject.stream;
  DateTime get _currentYear => _currentYearSubject.valueOrNull ?? DateTime.now().startOfYear();

  final _tasksByMonthSubject = BehaviorSubject<Map<int, List<Task>>>();
  Stream<Map<int, List<Task>>> get tasksByMonthStream => _tasksByMonthSubject.stream;

  initializer() {
    fetchTasksByMonth();
  }

  fetchTasksByMonth() async {
    final tasks = await _getTasksUseCase.execute(year: _currentYear.year);
    _tasksByMonthSubject.add(tasks.groupTasksByMonth());
  }

  onDateTimeChanged(DateTime value) {
    _currentYearSubject.add(value);
    fetchTasksByMonth();
  }

  dispose() {
    _currentYearSubject.close();
    _tasksByMonthSubject.close();
  }
}
