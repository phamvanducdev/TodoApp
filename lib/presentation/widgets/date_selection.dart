import 'package:flutter/material.dart';
import 'package:todo_plugin/config/app_assets.dart';
import 'package:todo_plugin/config/app_colors.dart';
import 'package:todo_plugin/config/app_text_styles.dart';
import 'package:todo_plugin/utils/date_time_utils.dart';
import 'package:todo_plugin/utils/widget_utils.dart';

class DateSelection extends StatelessWidget {
  final String title;
  final DateTime currentDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final bool isEnable;
  final Function(DateTime)? onDateChanged;

  const DateSelection({
    super.key,
    required this.title,
    required this.currentDate,
    this.firstDate,
    this.lastDate,
    this.isEnable = true,
    this.onDateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.textSMMedium.copyWith(color: AppColors.brandColor),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: isEnable
              ? () async {
                  DateTime toDate = lastDate ?? DateTime.now().add(const Duration(days: 365));
                  DateTime fromDate = firstDate ?? DateTime.now();
                  if (fromDate.isAfter(currentDate)) {
                    fromDate = currentDate;
                  }
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: currentDate,
                    firstDate: fromDate,
                    lastDate: toDate,
                  );
                  if (pickedDate != null && pickedDate != currentDate) {
                    onDateChanged?.call(pickedDate);
                  }
                }
              : null,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            decoration: BoxDecoration(
              color: isEnable ? Colors.white : const Color(0xFFEEF5FD),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.brandColor.withOpacity(0.08)),
            ),
            child: Row(
              children: [
                WidgetUtils.svgPicture(AppAssets.iconCalendar),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    DateTimeUtils.format(currentDate, DateTimeUtils.formatMMMddyyyy),
                    style: AppTextStyle.textSMRegular.copyWith(color: AppColors.textColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
