import 'package:flutter/material.dart';
import 'package:todo_plugin/data/models/task.dart';
import 'package:todo_plugin/config/app_colors.dart';
import 'package:todo_plugin/config/app_text_styles.dart';
import 'package:todo_plugin/utils/task_theme_utils.dart';
import 'package:todo_plugin/utils/widget_utils.dart';

class TaskTitle extends StatelessWidget {
  final Task task;

  const TaskTitle({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          WidgetUtils.svgPicture(task.themeType.iconTintColor, width: 28),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              task.title,
              style: AppTextStyle.text2XLBold.copyWith(color: AppColors.brandColor),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
