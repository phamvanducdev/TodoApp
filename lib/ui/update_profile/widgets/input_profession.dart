import 'package:flutter/material.dart';
import 'package:todo_plugin/theme/app_colors.dart';
import 'package:todo_plugin/theme/app_text_styles.dart';
import 'package:todo_plugin/ui/update_profile/update_profile_viewmodel.dart';
import 'package:todo_plugin/widgets/base_text_field.dart';

class InputProfession extends StatelessWidget {
  final UpdateProfileViewModel viewModel;

  const InputProfession({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Profession',
          style: AppTextStyle.textSMMedium.copyWith(color: AppColors.brandColor),
        ),
        const SizedBox(height: 8),
        BaseTextField(
          hint: 'Input profession...',
          focusNode: viewModel.inputProfessionFoucusNode,
          controller: viewModel.inputProfessionController,
          onChanged: (_) => viewModel.onProfessionChanged(),
          maxLines: 1,
        ),
      ],
    );
  }
}
