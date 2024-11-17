import 'package:flutter/material.dart';
import 'package:todo_plugin/data/models/todo.dart';
import 'package:todo_plugin/config/app_colors.dart';
import 'package:todo_plugin/config/app_text_styles.dart';
import 'package:todo_plugin/presentation/screens/task_details/widgets/task_details_todo_item.dart';

class TaskDetailsTodoList extends StatelessWidget {
  final List<Todo> todoList;
  final Function(Todo) onTodoChanged;

  const TaskDetailsTodoList({
    super.key,
    required this.todoList,
    required this.onTodoChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'To do List',
            style: AppTextStyle.textSMMedium.copyWith(color: AppColors.textColor),
          ),
          const SizedBox(height: 4),
          ...todoList.map((todo) => TaskDetailsTodoItem(
                todo: todo,
                onChanged: onTodoChanged,
              ))
        ],
      ),
    );
  }
}
