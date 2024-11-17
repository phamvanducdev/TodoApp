import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todo_plugin/data/models/task.dart';
import 'package:todo_plugin/data/models/todo.dart';
import 'package:todo_plugin/domain/usecases/task/add_task_usecase.dart';
import 'package:todo_plugin/domain/usecases/task/update_task_usecase.dart';
import 'package:todo_plugin/utils/date_time_utils.dart';

class AddTaskViewModel {
  final Task? _task;
  final AddTaskUseCase _addTaskUseCase;
  final UpdateTaskUseCase _updateTaskUseCase;

  AddTaskViewModel({
    required Task? task,
    required AddTaskUseCase addTaskUseCase,
    required UpdateTaskUseCase updateTaskUseCase,
  })  : _task = task,
        _addTaskUseCase = addTaskUseCase,
        _updateTaskUseCase = updateTaskUseCase;

  Duration minTimePeriod = const Duration(days: 1);

  final TextEditingController inputTitleController = TextEditingController();
  final TextEditingController inputDescriptionController = TextEditingController();

  final FocusNode inputTitleFocusNode = FocusNode();
  final FocusNode inputDescriptionFocusNode = FocusNode();

  final _startTimeSubject = BehaviorSubject<DateTime>();
  Stream<DateTime> get startTimeStream => _startTimeSubject.stream;
  DateTime get startTime => _startTimeSubject.valueOrNull ?? DateTime.now();

  final _endTimeSubject = BehaviorSubject<DateTime>();
  Stream<DateTime> get endTimeStream => _endTimeSubject.stream;
  DateTime get endTime => _endTimeSubject.valueOrNull ?? DateTime.now();

  final _priorityTaskSubject = BehaviorSubject<bool>();
  Stream<bool> get priorityTaskStream => _priorityTaskSubject.stream;
  bool get priorityTask => _priorityTaskSubject.valueOrNull ?? false;

  final _todoListSubject = BehaviorSubject<List<Todo>>();
  Stream<List<Todo>> get todoListStream => _todoListSubject.stream;
  List<Todo> get todoList => _todoListSubject.valueOrNull ?? [];

  final _validateSubject = BehaviorSubject<bool>();
  Stream<bool> get validateStream => _validateSubject.stream;

  bool isCreateNew = true;

  initializer() {
    if (_task != null) {
      isCreateNew = false;
      inputTitleController.text = _task.title;
      inputDescriptionController.text = _task.description;
      _startTimeSubject.add(DateTimeUtils.from(_task.startTime));
      _endTimeSubject.add(DateTimeUtils.from(_task.endTime));
      _priorityTaskSubject.add(_task.priority);
      _todoListSubject.add(_task.todoList);
    } else {
      _startTimeSubject.add(DateTime.now());
      _endTimeSubject.add(DateTime.now().add(minTimePeriod));
    }
  }

  onStartTimeChanged(DateTime value) {
    _startTimeSubject.add(value);
    if (endTime.isBefore(startTime)) {
      _endTimeSubject.add(startTime.add(minTimePeriod));
    }
    _validate();
  }

  onEndTimeChanged(DateTime value) {
    _endTimeSubject.add(value);
    if (startTime.isAfter(endTime)) {
      _startTimeSubject.add(endTime.subtract(minTimePeriod));
    }
    _validate();
  }

  onTitleChanged() {
    _validate();
  }

  onPriorityChanged(bool value) {
    _priorityTaskSubject.add(value);
    _validate();
  }

  onDescriptionChanged() {
    _validate();
  }

  addTodo(Todo todo) {
    _todoListSubject.add(todoList..add(todo));
    _validate();
  }

  removeTodo(Todo todo) {
    _todoListSubject.add(todoList..removeWhere((t) => t.id == todo.id));
    _validate();
  }

  updateTodo(Todo todo) {
    final List<Todo> todos = todoList;
    final int indexChanged = todos.indexWhere((t) => t.id == todo.id);
    if (indexChanged != -1) {
      todos[indexChanged] = todo;
      _todoListSubject.add(todos);
    }
    _validate();
  }

  Future<bool> onCreateOrUpdateTask() async {
    if (isCreateNew) {
      final DateTime now = DateTime.now();
      final Task newTask = Task(
        id: now.millisecondsSinceEpoch,
        title: inputTitleController.text,
        description: inputDescriptionController.text,
        createTime: now.millisecondsSinceEpoch,
        startTime: startTime.millisecondsSinceEpoch,
        endTime: endTime.millisecondsSinceEpoch,
        priority: priorityTask,
        todoList: todoList,
      );
      await _addTaskUseCase.execute(newTask);
      return true;
    } else {
      final Task updatedTask = Task(
        id: _task!.id,
        title: inputTitleController.text,
        description: inputDescriptionController.text,
        createTime: _task.createTime,
        startTime: startTime.millisecondsSinceEpoch,
        endTime: endTime.millisecondsSinceEpoch,
        priority: priorityTask,
        todoList: todoList,
      );
      await _updateTaskUseCase.execute(updatedTask);
      return true;
    }
  }

  _validate() {
    _validateSubject.add(
      inputTitleController.text.isNotEmpty && inputDescriptionController.text.isNotEmpty && todoList.isNotEmpty,
    );
  }

  dispose() {
    inputTitleController.dispose();
    inputDescriptionController.dispose();
    inputTitleFocusNode.dispose();
    inputDescriptionFocusNode.dispose();
    _startTimeSubject.close();
    _endTimeSubject.close();
    _todoListSubject.close();
    _validateSubject.close();
  }
}
