import 'package:flutter/material.dart';
import 'package:todo_plugin/config/app_colors.dart';
import 'package:todo_plugin/config/app_text_styles.dart';
import 'package:todo_plugin/presentation/screens/statistic/statistic_viewmodel.dart';
import 'package:todo_plugin/utils/date_time_utils.dart';
import 'package:todo_plugin/utils/extensions/date_time_extension.dart';

class StatisticFilterWidget extends StatelessWidget {
  final StatisticViewModel viewModel;

  const StatisticFilterWidget({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<DateTime>(
          stream: viewModel.currentYearStream,
          builder: (context, snapshot) {
            final DateTime currentYear = snapshot.data ?? DateTime.now().startOfYear();

            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () => viewModel.onDateTimeChanged(currentYear.subtractYears(1)),
                  icon: const Icon(Icons.arrow_left_rounded),
                  iconSize: 42,
                ),
                Container(
                  alignment: Alignment.center,
                  width: 64,
                  child: Text(
                    DateTimeUtils.format(currentYear, DateTimeUtils.formatyyyy),
                    style: AppTextStyle.textSMMedium.copyWith(color: AppColors.headerColor),
                  ),
                ),
                IconButton(
                  onPressed: () => viewModel.onDateTimeChanged(currentYear.addYears(1)),
                  icon: const Icon(Icons.arrow_right_rounded),
                  iconSize: 42,
                ),
              ],
            );
          }),
    );
  }
}
