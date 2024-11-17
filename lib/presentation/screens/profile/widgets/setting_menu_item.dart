import 'package:flutter/material.dart';
import 'package:todo_plugin/config/app_colors.dart';
import 'package:todo_plugin/config/app_text_styles.dart';
import 'package:todo_plugin/utils/widget_utils.dart';

class SettingMenuItem extends StatelessWidget {
  final String icon;
  final String title;
  final Function()? onPressed;

  const SettingMenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        child: Row(
          children: [
            WidgetUtils.svgPicture(icon, width: 24, color: AppColors.brandColor),
            const SizedBox(width: 24),
            Expanded(
              child: Text(
                title,
                style: AppTextStyle.textSMRegular.copyWith(color: AppColors.textColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
