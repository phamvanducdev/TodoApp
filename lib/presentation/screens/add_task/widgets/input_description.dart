import 'package:flutter/material.dart';
import 'package:todo_plugin/config/app_colors.dart';
import 'package:todo_plugin/config/app_text_styles.dart';
import 'package:todo_plugin/presentation/screens/add_task/add_task_viewmodel.dart';
import 'package:todo_plugin/presentation/widgets/base_text_field.dart';

class InputDescription extends StatelessWidget {
  final AddTaskViewModel viewModel;

  const InputDescription({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: AppTextStyle.textSMMedium.copyWith(color: AppColors.brandColor),
        ),
        const SizedBox(height: 8),
        BaseTextField(
          hint: 'Input description...',
          focusNode: viewModel.inputDescriptionFocusNode,
          controller: viewModel.inputDescriptionController,
          onChanged: (_) => viewModel.onDescriptionChanged(),
          keyboardType: TextInputType.multiline,
          maxLenght: 500,
          minLines: 5,
        ),
      ],
    );
  }
}
