import 'package:flutter/material.dart';
import 'package:todo_plugin/config/app_colors.dart';
import 'package:todo_plugin/config/app_text_styles.dart';
import 'package:todo_plugin/presentation/screens/update_profile/update_profile_viewmodel.dart';
import 'package:todo_plugin/utils/extensions/email_validator_extension.dart';
import 'package:todo_plugin/presentation/widgets/base_text_field.dart';

class InputEmail extends StatelessWidget {
  final UpdateProfileViewModel viewModel;

  const InputEmail({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email',
          style: AppTextStyle.textSMMedium.copyWith(color: AppColors.brandColor),
        ),
        const SizedBox(height: 8),
        BaseTextField(
          hint: 'Input email...',
          focusNode: viewModel.inputEmailFoucusNode,
          controller: viewModel.inputEmailController,
          onChanged: (_) => viewModel.onEmailChanged(),
          maxLines: 1,
          keyboardType: TextInputType.emailAddress,
          validation: (value) {
            if (value is String) {
              if (value.trim().isEmpty || value.isValidEmail()) {
                return null;
              } else {
                return 'Email is not valid';
              }
            }
            return null;
          },
        ),
      ],
    );
  }
}
