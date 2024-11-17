import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_plugin/theme/app_colors.dart';
import 'package:todo_plugin/theme/app_text_styles.dart';
import 'package:todo_plugin/utils/widget_utils.dart';

showConfirmDialog(
  BuildContext context, {
  required String message,
  String? icon,
  String? title,
  String? confirmText,
  String? cancelText,
  Function()? onConfirmed,
  Function()? onCanceled,
}) =>
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          shadowColor: AppColors.subBrandColor.withOpacity(0.3),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),

              /// Icons
              if (icon != null) ...[
                WidgetUtils.svgPicture(icon),
                const SizedBox(height: 16),
              ],

              /// Icons
              if (title != null) ...[
                Text(
                  title,
                  style: AppTextStyle.textBaseSemiBold.copyWith(color: AppColors.brandColor),
                ),
                const SizedBox(height: 16),
              ],

              /// Messages
              Text(
                message,
                style: AppTextStyle.textBaseMedium.copyWith(color: AppColors.brandColor),
              ),
              const SizedBox(height: 24),

              /// Confirm button
              GestureDetector(
                onTap: () {
                  context.pop();
                  onConfirmed?.call();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.brandColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    confirmText ?? 'Ok',
                    style: AppTextStyle.textSMSemiBold.copyWith(color: Colors.white),
                  ),
                ),
              ),

              /// Cancel button
              if (cancelText != null) ...[
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () {
                    context.pop();
                    onCanceled?.call();
                  },
                  child: Text(
                    cancelText,
                    style: AppTextStyle.textSMSemiBold.copyWith(color: AppColors.brandColor),
                  ),
                )
              ]
            ],
          ),
        );
      },
    );
