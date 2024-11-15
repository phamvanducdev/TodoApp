import 'package:flutter/material.dart';
import 'package:todo_plugin/theme/app_colors.dart';
import 'package:todo_plugin/theme/app_text_styles.dart';

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
          const SizedBox(height: 4),
          Stack(
            alignment: Alignment.center,
            children: [
              LinearProgressIndicator(
                minHeight: 20,
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFF006EE9),
                backgroundColor: const Color(0xFFA9A2A2),
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
