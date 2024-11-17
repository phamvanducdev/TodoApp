import 'package:flutter/material.dart';
import 'package:todo_plugin/config/app_colors.dart';
import 'package:todo_plugin/config/app_text_styles.dart';
import 'package:todo_plugin/utils/date_time_utils.dart';

class TaskDetailsCountdown extends StatelessWidget {
  final DateTime endTime;

  const TaskDetailsCountdown({super.key, required this.endTime});

  @override
  Widget build(BuildContext context) {
    final timeDifference = DateTimeUtils.timeDifferences(endTime);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildCountdownItem(context, value: timeDifference[0], unit: 'months'),
          _buildSpacer(),
          _buildCountdownItem(context, value: timeDifference[1], unit: 'days'),
          _buildSpacer(),
          _buildCountdownItem(context, value: timeDifference[2], unit: 'hours'),
        ],
      ),
    );
  }

  _buildCountdownItem(
    BuildContext context, {
    required int value,
    required String unit,
  }) {
    return Flexible(
      fit: FlexFit.tight,
      child: Container(
        decoration: BoxDecoration(color: AppColors.brandColor, borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          children: [
            Text(
              value.toString(),
              style: AppTextStyle.text3XLBold.copyWith(color: Colors.white, height: 1.2),
            ),
            Text(
              unit,
              style: AppTextStyle.textSMMedium.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  _buildSpacer() {
    return Container(
      width: 8,
      height: 2,
      color: const Color(0xFF9CCAFE),
      margin: const EdgeInsets.symmetric(horizontal: 1),
    );
  }
}
