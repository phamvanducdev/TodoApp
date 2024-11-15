import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todo_plugin/core/models/task.dart';
import 'package:todo_plugin/core/models/todo.dart';
import 'package:todo_plugin/core/usecases/add_task_usecase.dart';

class AddTaskViewModel {
  final AddTaskUseCase _addTaskUseCase;

  AddTaskViewModel({
    required AddTaskUseCase addTaskUseCase,
  }) : _addTaskUseCase = addTaskUseCase;

  Duration minTimePeriod = const Duration(days: 1);

  final TextEditingController inputTitleController = TextEditingController();
  final TextEditingController inputDescriptionController = TextEditingController();

  final FocusNode inputTitleFocusNode = FocusNode();
  final FocusNode inputDescriptionFocusNode = FocusNode();

  final _todoListSubject = BehaviorSubject<List<Todo>>();
  Stream<List<Todo>> get todoListStream => _todoListSubject.stream;
  List<Todo> get todoList => _todoListSubject.valueOrNull ?? [];

  final _startTimeSubject = BehaviorSubject<DateTime>();
  Stream<DateTime> get startTimeStream => _startTimeSubject.stream;
  DateTime get startTime => _startTimeSubject.valueOrNull ?? DateTime.now();

  final _endTimeSubject = BehaviorSubject<DateTime>();
  Stream<DateTime> get endTimeStream => _endTimeSubject.stream;
  DateTime get endTime => _endTimeSubject.valueOrNull ?? DateTime.now();

  final _validateSubject = BehaviorSubject<bool>();
  Stream<bool> get validateStream => _validateSubject.stream;

  initializer() {
    _startTimeSubject.add(DateTime.now());
    _endTimeSubject.add(DateTime.now().add(minTimePeriod));
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

  Future<bool> onCreateTask() async {
    final DateTime now = DateTime.now();
    final Task newTask = Task(
      id: now.millisecondsSinceEpoch,
      title: inputTitleController.text,
      description: inputDescriptionController.text,
      createTime: now.millisecondsSinceEpoch,
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      priority: true,
      todoList: todoList,
    );
    await _addTaskUseCase.execute(newTask);
    return true;
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
