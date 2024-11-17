import 'package:rxdart/rxdart.dart';
import 'package:todo_plugin/data/models/task.dart';
import 'package:todo_plugin/domain/usecases/task/get_tasks_usecase.dart';
import 'package:todo_plugin/domain/usecases/task/remove_task_usecase.dart';

class TaskListViewModel {
  final GetTasksUseCase _getTasksUseCase;
  final RemoveTaskUseCase _removeTaskUseCase;

  TaskListViewModel({
    required GetTasksUseCase getTasksUseCase,
    required RemoveTaskUseCase removeTaskUseCase,
  })  : _getTasksUseCase = getTasksUseCase,
        _removeTaskUseCase = removeTaskUseCase;

  final _dateTimeSubject = BehaviorSubject<DateTime>.seeded(DateTime.now());
  Stream<DateTime> get dateTimeStream => _dateTimeSubject.stream;
  DateTime get dateTime => _dateTimeSubject.valueOrNull ?? DateTime.now();

  final _taskListSubject = BehaviorSubject<List<Task>>();
  Stream<List<Task>> get taskListStream => _taskListSubject.stream;
  List<Task> get taskList => _taskListSubject.valueOrNull ?? [];

  fetchTaskList() async {
    final List<Task> taskList = await _getTasksUseCase.execute(startTime: dateTime);
    _taskListSubject.add(taskList);
  }

  onDateTimeChanged(DateTime value) async {
    _dateTimeSubject.add(value);
    await fetchTaskList();
  }

  onRemoveTask(int id) async {
    await _removeTaskUseCase.execute(id);
    await fetchTaskList();
  }

  dispose() {
    _dateTimeSubject.close();
    _taskListSubject.close();
  }
}
