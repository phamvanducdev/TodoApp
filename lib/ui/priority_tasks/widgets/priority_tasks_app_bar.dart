import 'package:flutter/material.dart';
import 'package:todo_plugin/theme/app_colors.dart';
import 'package:todo_plugin/theme/app_text_styles.dart';
import 'package:todo_plugin/utils/date_time_utils.dart';

class PriorityTasksAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onSettingPressed;

  const PriorityTasksAppBar({
    super.key,
    required this.onSettingPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: false,
      title: Text(
        DateTimeUtils.format(DateTime.now(), DateTimeUtils.formatEEEEMMMddyyyy),
        style: AppTextStyle.textXSRegular.copyWith(color: AppColors.headerColor),
      ),
      actions: [
        IconButton(
          onPressed: onSettingPressed,
          icon: const Icon(Icons.settings, color: Colors.black),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
