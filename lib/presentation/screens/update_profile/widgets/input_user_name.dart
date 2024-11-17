import 'package:flutter/material.dart';
import 'package:todo_plugin/config/app_colors.dart';
import 'package:todo_plugin/config/app_text_styles.dart';
import 'package:todo_plugin/presentation/screens/update_profile/update_profile_viewmodel.dart';
import 'package:todo_plugin/presentation/widgets/base_text_field.dart';

class InputUserName extends StatelessWidget {
  final UpdateProfileViewModel viewModel;

  const InputUserName({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Name',
          style: AppTextStyle.textSMMedium.copyWith(color: AppColors.brandColor),
        ),
        const SizedBox(height: 8),
        BaseTextField(
          hint: 'Input name...',
          focusNode: viewModel.inputUserNameFoucusNode,
          controller: viewModel.inputUserNameController,
          onChanged: (_) => viewModel.onUserNameChanged(),
          maxLines: 1,
        ),
      ],
    );
  }
}
