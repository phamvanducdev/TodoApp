import 'package:flutter/material.dart';
import 'package:todo_plugin/config/app_colors.dart';
import 'package:todo_plugin/config/app_text_styles.dart';
import 'package:todo_plugin/presentation/screens/add_task/add_task_viewmodel.dart';

class InputPriority extends StatelessWidget {
  final AddTaskViewModel viewModel;

  const InputPriority({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Category',
          style: AppTextStyle.textSMMedium.copyWith(color: AppColors.brandColor),
        ),
        const SizedBox(height: 8),
        StreamBuilder<bool>(
          stream: viewModel.priorityTaskStream,
          builder: (context, snapshot) {
            final bool isPriority = snapshot.data ?? false;
            return GestureDetector(
              onTap: () => viewModel.onPriorityChanged(!isPriority),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                decoration: BoxDecoration(
                  color: isPriority ? AppColors.subBrandColor : AppColors.greyColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Priority Task',
                  style: AppTextStyle.textSMRegular.copyWith(
                    color: isPriority ? Colors.white : AppColors.subHeaderColor,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
