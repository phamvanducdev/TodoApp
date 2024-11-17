import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:todo_plugin/config/app_colors.dart';
import 'package:todo_plugin/config/app_text_styles.dart';

showTaskMenuDialog(
  BuildContext context, {
  Function()? onEditPressed,
  Function()? onRemovePressed,
}) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        shadowColor: AppColors.subBrandColor.withOpacity(0.3),
        content: KeyboardDismisser(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Edit button
              GestureDetector(
                onTap: () {
                  context.pop();
                  onEditPressed?.call();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.brandColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Edit Task',
                    style: AppTextStyle.textSMSemiBold.copyWith(color: Colors.white),
                  ),
                ),
              ),

              /// Remove button
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () {
                  context.pop();
                  onRemovePressed?.call();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.brandColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Delete Task',
                    style: AppTextStyle.textSMSemiBold.copyWith(color: Colors.white),
                  ),
                ),
              ),

              /// Cancel button
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.brandColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Cancel',
                    style: AppTextStyle.textSMSemiBold.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
