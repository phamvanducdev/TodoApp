import 'package:flutter/material.dart';
import 'package:todo_plugin/config/app_colors.dart';
import 'package:todo_plugin/config/app_text_styles.dart';
import 'package:todo_plugin/data/models/task.dart';
import 'package:todo_plugin/presentation/screens/statistic/statistic_viewmodel.dart';
import 'package:todo_plugin/utils/extensions/task_list_extension.dart';

class StatisticTaskSummaryWidget extends StatelessWidget {
  final StatisticViewModel viewModel;

  const StatisticTaskSummaryWidget({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<int, List<Task>>>(
      stream: viewModel.tasksByMonthStream,
      builder: (context, snapshot) {
        final Map<int, List<Task>> tasksByMonth = snapshot.data ?? {};
        final List<Task> taskList = tasksByMonth.values.expand((tasks) => tasks).toList();
        final List<Task> taskListCompleted = taskList.filterCompleted();
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Row(
            children: [
              _buildItemSummary(
                context,
                title: 'Total Tasks',
                value: taskList.length,
              ),
              const SizedBox(width: 20),
              _buildItemSummary(
                context,
                title: 'Completed Tasks',
                value: taskListCompleted.length,
              ),
            ],
          ),
        );
      },
    );
  }

  _buildItemSummary(
    BuildContext context, {
    required String title,
    required int value,
  }) {
    return Flexible(
      fit: FlexFit.tight,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColors.brandColor.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              title,
              style: AppTextStyle.text2XSMedium.copyWith(color: AppColors.headerColor),
            ),
            Text(
              '$value',
              style: AppTextStyle.text2XLMedium.copyWith(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
