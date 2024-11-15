import 'package:flutter/material.dart';
import 'package:todo_plugin/core/models/todo.dart';
import 'package:todo_plugin/theme/app_colors.dart';
import 'package:todo_plugin/theme/app_text_styles.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final Function() onPressed;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(color: AppColors.brandColor.withOpacity(0.08), width: 1),
        ),
        child: Text(
          todo.title,
          style: AppTextStyle.textSMMedium.copyWith(color: AppColors.brandColor),
        ),
      ),
    );
  }
}
