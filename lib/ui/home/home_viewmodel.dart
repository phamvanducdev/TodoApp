import 'dart:math';

import 'package:rxdart/rxdart.dart';
import 'package:todo_plugin/core/models/task.dart';
import 'package:todo_plugin/core/models/todo.dart';
import 'package:todo_plugin/core/usecases/add_task_usecase.dart';
import 'package:todo_plugin/core/usecases/get_available_priority_task_usecase.dart';

class HomeViewModel {
  final GetAvailablePriorityTaskUseCase _availablePriorityTaskUseCase;
  final AddTaskUseCase _addTaskUseCase;

  HomeViewModel({
    required GetAvailablePriorityTaskUseCase availablePriorityTaskUseCase,
    required AddTaskUseCase addTaskUseCase,
  })  : _availablePriorityTaskUseCase = availablePriorityTaskUseCase,
        _addTaskUseCase = addTaskUseCase;

  final _availablePriorityTasks = BehaviorSubject<List<Task>>();
  Stream<List<Task>> get availablePriorityTasks => _availablePriorityTasks.stream;

  initializer() async {
    // await _createTask();
    final availableTasks = await _availablePriorityTaskUseCase.execute();
    _availablePriorityTasks.add(availableTasks);
  }

  _createTask() async {
    await _addTaskUseCase.execute(
      Task(
        id: DateTime.now().millisecondsSinceEpoch,
        title: 'Mobile Application',
        description:
            'User interface (UI) is anything a user may interact with to use a digital product or service. This includes everything from screens and touchscreens, keyboards, sounds, and even lights. To understand the evolution of UI, however, it’s helpful to learn a bit more about its history and how it has evolved into best practices and a profession.',
        createTime: DateTime.now().millisecondsSinceEpoch,
        startTime: (DateTime.now().subtract(const Duration(days: -1))).millisecondsSinceEpoch,
        endTime: (DateTime.now().add(const Duration(days: 100, hours: 10))).millisecondsSinceEpoch,
        priority: true,
        todoList: [
          Todo(
            id: 2,
            title: 'Make a moodboard',
            completed: true,
          ),
          Todo(
            id: Random().nextInt(100),
            title: 'Make a wireframe',
            completed: false,
          ),
          Todo(
            id: Random().nextInt(100),
            title: 'Make a component design',
            completed: false,
          ),
          Todo(
            id: Random().nextInt(100),
            title: 'Client Meeting',
            completed: false,
          ),
          Todo(
            id: Random().nextInt(100),
            title: 'Make design',
            completed: false,
          ),
        ],
      ),
    );
  }

  dispose() {
    _availablePriorityTasks.close();
  }
}
