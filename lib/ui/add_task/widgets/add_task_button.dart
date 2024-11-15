import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_plugin/theme/app_colors.dart';
import 'package:todo_plugin/theme/app_text_styles.dart';
import 'package:todo_plugin/ui/add_task/add_task_viewmodel.dart';
import 'package:todo_plugin/widgets/app_dialog.dart';

class AddTaskButton extends StatelessWidget {
  final AddTaskViewModel viewModel;

  const AddTaskButton({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.brandColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: StreamBuilder<bool>(
        stream: viewModel.validateStream,
        builder: (_, snapshot) {
          final bool validate = snapshot.data ?? false;
          return GestureDetector(
            onTap: validate ? () => _onAddTaskPressed(context) : null,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: validate ? AppColors.brandColor : const Color(0xFFC6C2C2),
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text(
                'Add Task',
                style: AppTextStyle.textSMSemiBold.copyWith(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }

  _onAddTaskPressed(BuildContext context) async {
    final bool result = await viewModel.onCreateTask();
    if (result) {
      showSuccessDialog(
        context,
        message: 'Task created successfully!',
        confirmText: 'Back',
        onConfirmed: () => context.pop(),
      );
    } else {
      // Handle errors
    }
  }
}
