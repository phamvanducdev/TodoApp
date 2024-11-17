import 'package:flutter/material.dart';
import 'package:todo_plugin/config/app_colors.dart';
import 'package:todo_plugin/config/app_text_styles.dart';

class TaskDetailsDescription extends StatelessWidget {
  final String description;

  const TaskDetailsDescription({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: AppTextStyle.textSMMedium.copyWith(color: AppColors.textColor),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: AppTextStyle.textXSRegular.copyWith(color: AppColors.textColor),
          ),
        ],
      ),
    );
  }
}
