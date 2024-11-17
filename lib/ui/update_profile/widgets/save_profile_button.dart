import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_plugin/theme/app_assets.dart';
import 'package:todo_plugin/theme/app_colors.dart';
import 'package:todo_plugin/theme/app_text_styles.dart';
import 'package:todo_plugin/ui/add_task/add_task_viewmodel.dart';
import 'package:todo_plugin/ui/update_profile/update_profile_viewmodel.dart';
import 'package:todo_plugin/widgets/app_dialog.dart';

class SaveProfileButton extends StatelessWidget {
  final UpdateProfileViewModel viewModel;

  const SaveProfileButton({
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
            onTap: validate ? () => _onSavePressed(context) : null,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: validate ? AppColors.brandColor : const Color(0xFFC6C2C2),
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text(
                'Save',
                style: AppTextStyle.textSMSemiBold.copyWith(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }

  _onSavePressed(BuildContext context) async {
    final bool result = await viewModel.onSavePressed();
    if (result) {
      showConfirmDialog(
        // ignore: use_build_context_synchronously
        context,
        icon: AppAssets.iconSuccess,
        message: 'Profile updated successfully!',
        confirmText: 'Back',
        onConfirmed: () => context.pop(true),
      );
    } else {
      // Handle errors
    }
  }
}
