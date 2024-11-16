import 'package:flutter/material.dart';
import 'package:todo_plugin/core/models/task.dart';
import 'package:todo_plugin/theme/app_assets.dart';
import 'package:todo_plugin/theme/app_colors.dart';
import 'package:todo_plugin/theme/app_text_styles.dart';
import 'package:todo_plugin/utils/date_time_utils.dart';
import 'package:todo_plugin/utils/task_theme_utils.dart';
import 'package:todo_plugin/utils/widget_utils.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final Function() onItemPressed;
  final Function() onMenuPressed;

  const TaskItem({
    super.key,
    required this.task,
    required this.onItemPressed,
    required this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onItemPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(color: AppColors.brandColor.withOpacity(0.08), width: 1),
        ),
        child: Stack(
          children: [
            Padding(
              // padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              padding: const EdgeInsets.fromLTRB(20, 12, 12, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      WidgetUtils.svgPicture(task.themeType.iconTintColor, width: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          task.title,
                          style: AppTextStyle.textSMSemiBold.copyWith(color: AppColors.brandColor),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      GestureDetector(
                        onTap: onMenuPressed,
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(8),
                          child: WidgetUtils.svgPicture(AppAssets.iconMenu, width: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    constraints: const BoxConstraints(minHeight: 54),
                    child: Text(
                      task.description,
                      style: AppTextStyle.textXSRegular.copyWith(color: AppColors.textColor),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Spacer(),
                      Text(
                        '${DateTimeUtils.format(
                          DateTimeUtils.from(task.startTime),
                          DateTimeUtils.formatMMMdd,
                        )} - ${DateTimeUtils.format(
                          DateTimeUtils.from(task.endTime),
                          DateTimeUtils.formatMMMdd,
                        )}',
                        style: AppTextStyle.textXSRegular.copyWith(color: AppColors.subBrandColor),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
            if (task.priority)
              Positioned(
                top: 42,
                left: 0,
                bottom: 42,
                child: Container(width: 2, color: AppColors.subBrandColor),
              ),
          ],
        ),
      ),
    );
  }
}
