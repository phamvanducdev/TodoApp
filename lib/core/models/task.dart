import 'package:todo_plugin/core/models/todo.dart';

class Task {
  final int id;
  String title;
  String description;
  int startTime;
  int endTime;
  bool priority;
  List<Todo> todoList;

  Task({
    required this.id,
    required this.title,
    required this.description,
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
      'startTime': startTime,
      'endTime': endTime,
      'priority': priority,
      'todoList': todoList.map((todo) => todo.toJson()).toList(),
    };
  }
}
