import 'package:flutter/material.dart';
import 'package:todo_plugin/core/models/todo.dart';
import 'package:todo_plugin/theme/app_colors.dart';
import 'package:todo_plugin/theme/app_text_styles.dart';
import 'package:todo_plugin/widgets/radio_button.dart';

class TaskDetailsTodoItem extends StatelessWidget {
  final Todo todo;
  final Function(Todo) onChanged;

  const TaskDetailsTodoItem({
    super.key,
    required this.todo,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(todo..completed = !todo.completed),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(color: AppColors.brandColor.withOpacity(0.08), width: 1),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                todo.title,
                style: AppTextStyle.textSMMedium.copyWith(color: AppColors.brandColor),
              ),
            ),
            RadioButton(
              size: 20,
              active: todo.completed,
              activeColor: AppColors.brandColor,
              inactiveColor: AppColors.brandColor,
              onChanged: (value) => onChanged(todo..completed = value),
            ),
          ],
        ),
      ),
    );
  }
}
