import 'package:flutter/material.dart';
import 'package:todo_plugin/config/app_colors.dart';
import 'package:todo_plugin/config/app_text_styles.dart';

class TaskDetailsProgress extends StatelessWidget {
  final double progress;

  const TaskDetailsProgress({
    super.key,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Progress',
            style: AppTextStyle.textSMMedium.copyWith(color: AppColors.textColor),
          ),
          const SizedBox(height: 8),
          Stack(
            alignment: Alignment.center,
            children: [
              LinearProgressIndicator(
                minHeight: 20,
                borderRadius: BorderRadius.circular(10),
                backgroundColor: AppColors.greyColor,
                color: AppColors.subBrandColor,
                value: progress,
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: AppTextStyle.text2XSMedium.copyWith(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
