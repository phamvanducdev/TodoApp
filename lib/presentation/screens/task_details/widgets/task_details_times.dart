import 'package:flutter/material.dart';
import 'package:todo_plugin/config/app_colors.dart';
import 'package:todo_plugin/config/app_text_styles.dart';
import 'package:todo_plugin/utils/date_time_utils.dart';

class TaskDetailsTimes extends StatelessWidget {
  final DateTime startTime;
  final DateTime endTime;

  const TaskDetailsTimes({
    super.key,
    required this.startTime,
    required this.endTime,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Start',
                style: AppTextStyle.textSMMedium.copyWith(color: AppColors.textColor),
              ),
              Text(
                DateTimeUtils.format(startTime, DateTimeUtils.formatddMMMyyyy),
                style: AppTextStyle.textXSRegular.copyWith(color: AppColors.textColor),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'End',
                style: AppTextStyle.textSMMedium.copyWith(color: AppColors.textColor),
              ),
              Text(
                DateTimeUtils.format(endTime, DateTimeUtils.formatddMMMyyyy),
                style: AppTextStyle.textXSRegular.copyWith(color: AppColors.textColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
