import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_plugin/data/models/task.dart';
import 'package:todo_plugin/config/app_assets.dart';
import 'package:todo_plugin/config/app_colors.dart';
import 'package:todo_plugin/config/app_text_styles.dart';
import 'package:todo_plugin/utils/task_theme_utils.dart';
import 'package:todo_plugin/utils/widget_utils.dart';

class TaskDetailsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Task task;

  const TaskDetailsAppBar({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      titleSpacing: 16,
      title: Row(
        children: [
          WidgetUtils.svgPicture(task.themeType.iconTintColor, width: 28),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              task.title,
              style: AppTextStyle.text2XLBold.copyWith(color: AppColors.brandColor),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: WidgetUtils.svgPicture(
            AppAssets.iconCloseSquare,
            color: AppColors.brandColor,
          ),
          onPressed: () => context.pop(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
