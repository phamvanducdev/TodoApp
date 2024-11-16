import 'package:flutter/material.dart';
import 'package:todo_plugin/theme/app_colors.dart';
import 'package:todo_plugin/theme/app_text_styles.dart';
import 'package:todo_plugin/ui/priority_tasks/priority_tasks_viewmodel.dart';

class PriorityTasksHeader extends StatelessWidget {
  final PriorityTasksViewModel viewModel;

  const PriorityTasksHeader({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome Phillip',
            style: AppTextStyle.textXLBold.copyWith(color: AppColors.headerColor),
          ),
          Text(
            'Have a nice day !',
            style: AppTextStyle.textBaseRegular.copyWith(color: AppColors.subHeaderColor),
          ),
        ],
      ),
    );
  }
}