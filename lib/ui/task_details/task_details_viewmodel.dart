import 'package:rxdart/rxdart.dart';
import 'package:todo_plugin/core/models/task.dart';
import 'package:todo_plugin/core/models/todo.dart';
import 'package:todo_plugin/core/usecases/task/update_task_usecase.dart';

class TaskDetailsViewModel {
  final UpdateTaskUseCase _updateTaskUseCase;

  TaskDetailsViewModel({
    required UpdateTaskUseCase updateTaskUseCase,
  }) : _updateTaskUseCase = updateTaskUseCase;

  final _taskDetails = BehaviorSubject<Task?>();
  Stream<Task?> get taskDetails => _taskDetails.stream;

  initializer(Task task) async {
    _taskDetails.add(task);
  }

  onTodoChanged(Todo todo) async {
    final Task? task = _taskDetails.valueOrNull;
    if (task == null) return;
    final List<Todo> todoList = task.todoList;
    if (todoList.isEmpty) return;
    final int indexChanged = todoList.indexWhere((t) => t.id == todo.id);
    todoList[indexChanged] = todo;
    task.todoList = todoList;
    await _updateTaskUseCase.execute(task);
    _taskDetails.add(task);
  }

  dispose() {
    _taskDetails.close();
  }
}
