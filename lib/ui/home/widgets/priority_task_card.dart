import 'package:flutter/material.dart';
import 'package:todo_plugin/core/models/task.dart';
import 'package:todo_plugin/theme/app_assets.dart';
import 'package:todo_plugin/theme/app_colors.dart';
import 'package:todo_plugin/theme/app_text_styles.dart';
import 'package:todo_plugin/utils/date_time_utils.dart';
import 'package:todo_plugin/utils/task_theme_utils.dart';
import 'package:todo_plugin/utils/widget_utils.dart';

class PriorityTaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onItemPressed;

  const PriorityTaskCard({
    super.key,
    required this.task,
    required this.onItemPressed,
  });

  @override
  Widget build(BuildContext context) {
    const double itemRatio = 188 / 129;
    const double itemSpacer = 12;
    const double parentPadding = 16;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double itemWidth = (screenWidth - parentPadding - itemSpacer * 2) / 2.5;
    final TaskThemeType cardTheme = TaskThemeType.values[task.id % 3];
    return GestureDetector(
      onTap: onItemPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: itemSpacer / 2),
        width: itemWidth,
        height: itemWidth * itemRatio,
        decoration: BoxDecoration(
          color: cardTheme.backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            /// Backgrounds
            WidgetUtils.svgPicture(
              AppAssets.bgPriorityTaskCard,
              width: itemWidth,
              height: itemWidth * itemRatio,
            ),
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                child: Text(
                  DateTimeUtils.timeDifference(DateTimeUtils.from(task.endTime)),
                  style: AppTextStyle.textXSRegular.copyWith(color: AppColors.textColor),
                ),
              ),
            ),
            Positioned.fill(
              left: 12,
              child: Row(
                children: [
                  WidgetUtils.svgPicture(cardTheme.titleIcon),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      task.title,
                      style: AppTextStyle.textBaseSemiBold.copyWith(color: Colors.white),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: _buildProgressBar(
                context,
                value: task.percentageCompleted,
                cardTheme: cardTheme,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar(
    BuildContext context, {
    required double value,
    required TaskThemeType cardTheme,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Progress',
          style: AppTextStyle.text2XSRegular.copyWith(color: Colors.white),
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: value,
          backgroundColor: cardTheme.progressBackgroundColor,
          color: Colors.white,
          minHeight: 4,
          borderRadius: BorderRadius.circular(2),
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            const Spacer(),
            Text(
              '${(value * 100).toInt()}%',
              style: AppTextStyle.text2XSRegular.copyWith(color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}
