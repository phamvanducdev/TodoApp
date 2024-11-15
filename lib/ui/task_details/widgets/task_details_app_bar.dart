import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_plugin/core/models/task.dart';
import 'package:todo_plugin/theme/app_assets.dart';
import 'package:todo_plugin/theme/app_colors.dart';
import 'package:todo_plugin/theme/app_text_styles.dart';
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
          WidgetUtils.svgPicture(
            task.themeType.titleIcon,
            colorFilter: ColorFilter.mode(AppColors.brandColor, BlendMode.srcIn),
            width: 28,
          ),
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
            colorFilter: ColorFilter.mode(AppColors.brandColor, BlendMode.srcIn),
          ),
          onPressed: () => context.pop(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
