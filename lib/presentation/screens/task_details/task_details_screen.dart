import 'package:flutter/material.dart';
import 'package:todo_plugin/data/models/task.dart';
import 'package:todo_plugin/domain/usecases/task/update_task_usecase.dart';
import 'package:todo_plugin/di/app_get_it.dart';
import 'package:todo_plugin/config/app_colors.dart';
import 'package:todo_plugin/config/app_text_styles.dart';
import 'package:todo_plugin/presentation/screens/task_details/task_details_viewmodel.dart';
import 'package:todo_plugin/presentation/screens/task_details/widgets/task_details_app_bar.dart';
import 'package:todo_plugin/presentation/screens/task_details/widgets/task_details_countdown.dart';
import 'package:todo_plugin/presentation/screens/task_details/widgets/task_details_description.dart';
import 'package:todo_plugin/presentation/screens/task_details/widgets/task_details_progress.dart';
import 'package:todo_plugin/presentation/screens/task_details/widgets/task_details_times.dart';
import 'package:todo_plugin/presentation/screens/task_details/widgets/task_details_todo_list.dart';
import 'package:todo_plugin/utils/date_time_utils.dart';

class DetailsScreen extends StatefulWidget {
  final Task task;

  const DetailsScreen({
    super.key,
    required this.task,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late TaskDetailsViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = TaskDetailsViewModel(
      updateTaskUseCase: getIt<UpdateTaskUseCase>(),
    )..initializer(widget.task);
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TaskDetailsAppBar(task: widget.task),
      body: StreamBuilder<Task?>(
        stream: _viewModel.taskDetails,
        builder: (context, snapshot) {
          final Task? task = snapshot.data;
          if (task == null) {
            return Center(
              child: Text(
                'Loading...',
                style: AppTextStyle.textBaseMedium.copyWith(color: AppColors.brandColor),
              ),
            );
          }
          final DateTime startTime = DateTimeUtils.from(task.startTime);
          final DateTime endTime = DateTimeUtils.from(task.endTime);
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                TaskDetailsTimes(startTime: startTime, endTime: endTime),
                TaskDetailsCountdown(endTime: endTime),
                TaskDetailsDescription(description: task.description),
                TaskDetailsProgress(progress: task.percentageCompleted),
                TaskDetailsTodoList(
                  todoList: task.todoList,
                  onTodoChanged: (todo) => _viewModel.onTodoChanged(todo),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
