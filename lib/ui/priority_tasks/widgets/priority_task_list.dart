import 'package:flutter/material.dart';
import 'package:todo_plugin/core/models/task.dart';
import 'package:todo_plugin/theme/app_colors.dart';
import 'package:todo_plugin/theme/app_text_styles.dart';
import 'package:todo_plugin/ui/priority_tasks/priority_tasks_viewmodel.dart';
import 'package:todo_plugin/ui/priority_tasks/widgets/priority_task_card.dart';

class PriorityTaskList extends StatelessWidget {
  final PriorityTasksViewModel viewModel;
  final Function(Task) openTaskDetails;

  const PriorityTaskList({
    super.key,
    required this.viewModel,
    required this.openTaskDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text('Priority Task', style: AppTextStyle.textLGSemiBold.copyWith(color: AppColors.headerColor)),
        ),
        const SizedBox(height: 8),
        StreamBuilder<List<Task>>(
          stream: viewModel.priorityTaskListStream,
          builder: (context, snapshot) {
            final List<Task> tasks = snapshot.data ?? [];
            if (tasks.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'You currently have no tasks priority. Enjoy your day!',
                  style: AppTextStyle.textBaseRegular.copyWith(color: AppColors.subHeaderColor),
                ),
              );
            }
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  ...tasks.map((task) => PriorityTaskCard(
                        task: task,
                        onItemPressed: () => openTaskDetails(task),
                      )),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
