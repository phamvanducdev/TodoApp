import 'package:flutter/material.dart';
import 'package:todo_plugin/config/app_assets.dart';
import 'package:todo_plugin/config/app_colors.dart';
import 'package:todo_plugin/config/app_text_styles.dart';
import 'package:todo_plugin/presentation/screens/task_list/task_list_viewmodel.dart';
import 'package:todo_plugin/utils/date_time_utils.dart';
import 'package:todo_plugin/utils/widget_utils.dart';

class TaskListAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TaskListViewModel viewModel;
  final Function() onDateTimePressed;
  final Function() onAddNewTaskPressed;

  const TaskListAppBar({
    super.key,
    required this.viewModel,
    required this.onDateTimePressed,
    required this.onAddNewTaskPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      titleSpacing: 16,
      title: StreamBuilder<DateTime>(
        stream: viewModel.dateTimeStream,
        builder: (context, snapshot) {
          final DateTime dateTime = snapshot.data ?? DateTime.now();
          return GestureDetector(
            onTap: onDateTimePressed,
            child: Row(
              children: [
                WidgetUtils.svgPicture(
                  AppAssets.iconTabCalendar,
                  width: 20,
                  color: AppColors.subBrandColor,
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    DateTimeUtils.format(dateTime, DateTimeUtils.formatMMMyyyy),
                    style: AppTextStyle.textXLSemiBold.copyWith(color: AppColors.headerColor),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      actions: [
        IconButton(
          onPressed: onAddNewTaskPressed,
          icon: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              color: AppColors.subBrandColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                WidgetUtils.svgPicture(AppAssets.iconPlus, width: 16),
                const SizedBox(width: 4),
                Text(
                  'Add Task',
                  style: AppTextStyle.textXSRegular.copyWith(color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
