import 'package:todo_plugin/core/models/todo.dart';
import 'package:todo_plugin/utils/task_theme_utils.dart';

class Task {
  final int id;
  String title;
  String description;
  int createTime;
  int startTime;
  int endTime;
  bool priority;
  List<Todo> todoList;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.createTime,
    required this.startTime,
    required this.endTime,
    this.priority = false,
    this.todoList = const [],
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      createTime: json['createTime'] as int,
      startTime: json['startTime'] as int,
      endTime: json['endTime'] as int,
      priority: json['priority'] as bool? ?? false,
      todoList: (json['todoList'] as List<dynamic>?)?.map((item) => Todo.fromJson(item as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createTime': createTime,
      'startTime': startTime,
      'endTime': endTime,
      'priority': priority,
      'todoList': todoList.map((todo) => todo.toJson()).toList(),
    };
  }

  double get percentageCompleted {
    if (todoList.isEmpty) return 1;
    final List<Todo> todoListCompleted = todoList.where((todo) => todo.completed).toList();
    return todoListCompleted.length / todoList.length;
  }

  TaskThemeType get themeType => TaskThemeType.values[id % (TaskThemeType.values.length)];
}
