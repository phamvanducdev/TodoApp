import 'package:rxdart/rxdart.dart';
import 'package:todo_plugin/core/models/task.dart';
import 'package:todo_plugin/core/usecases/get_available_priority_task_usecase.dart';

class PriorityTasksViewModel {
  final GetAvailablePriorityTaskUseCase _availablePriorityTaskUseCase;

  PriorityTasksViewModel({
    required GetAvailablePriorityTaskUseCase availablePriorityTaskUseCase,
  }) : _availablePriorityTaskUseCase = availablePriorityTaskUseCase;

  final _availablePriorityTasks = BehaviorSubject<List<Task>>();
  Stream<List<Task>> get availablePriorityTasks => _availablePriorityTasks.stream;

  initializer() async {
    final availableTasks = await _availablePriorityTaskUseCase.execute();
    _availablePriorityTasks.add(availableTasks);
  }

  dispose() {
    _availablePriorityTasks.close();
  }
}
