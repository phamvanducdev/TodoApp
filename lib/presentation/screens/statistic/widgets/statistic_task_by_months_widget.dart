import 'package:flutter/material.dart';
import 'package:todo_plugin/config/app_colors.dart';
import 'package:todo_plugin/config/app_text_styles.dart';
import 'package:todo_plugin/data/models/task.dart';
import 'package:todo_plugin/presentation/screens/statistic/statistic_viewmodel.dart';
import 'package:todo_plugin/utils/date_time_utils.dart';
import 'package:todo_plugin/utils/extensions/task_list_extension.dart';

class StatisticTaskByMonthsWidget extends StatelessWidget {
  final StatisticViewModel viewModel;

  const StatisticTaskByMonthsWidget({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<int, List<Task>>>(
      stream: viewModel.tasksByMonthStream,
      builder: (context, snapshot) {
        final Map<int, List<Task>> tasksByMonth = snapshot.data ?? {};
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
          ),
          itemCount: tasksByMonth.length,
          itemBuilder: (context, index) {
            final int month = tasksByMonth.keys.elementAt(index);
            final List<Task> taskList = tasksByMonth[month] ?? [];
            final List<Task> taskListCompleted = taskList.filterCompleted();
            final double percentCompleted = taskList.isNotEmpty ? taskListCompleted.length / taskList.length : 1;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateTimeUtils.format(DateTime.now().copyWith(month: month), DateTimeUtils.formatMMMM),
                  style: AppTextStyle.textXSMedium.copyWith(color: AppColors.subHeaderColor),
                ),
                const SizedBox(height: 12),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 72,
                      height: 72,
                      child: CircularProgressIndicator(
                        value: percentCompleted,
                        strokeWidth: 8,
                        valueColor: AlwaysStoppedAnimation(
                          percentCompleted == 1 ? AppColors.subBrandColor : AppColors.brandColor,
                        ),
                        backgroundColor: AppColors.greyColor,
                      ),
                    ),
                    Text(
                      '${(percentCompleted * 100).toInt()}%',
                      style: AppTextStyle.textXSMedium.copyWith(color: AppColors.subHeaderColor),
                    )
                  ],
                )
              ],
            );
          },
        );
      },
    );
  }
}
