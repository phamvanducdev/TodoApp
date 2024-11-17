import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_plugin/core/models/task.dart';
import 'package:todo_plugin/core/usecases/task/get_tasks_usecase.dart';
import 'package:todo_plugin/core/usecases/task/remove_task_usecase.dart';
import 'package:todo_plugin/di/di.dart';
import 'package:todo_plugin/theme/app_colors.dart';
import 'package:todo_plugin/theme/app_text_styles.dart';
import 'package:todo_plugin/ui/task_list/task_list_viewmodel.dart';
import 'package:todo_plugin/ui/task_list/widgets/task_list_calendar_tab_bar.dart';
import 'package:todo_plugin/ui/task_list/widgets/task_item.dart';
import 'package:todo_plugin/ui/task_list/widgets/task_list_app_bar.dart';
import 'package:todo_plugin/widgets/app_dialog.dart';
import 'package:todo_plugin/widgets/task_menu_dialog.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => TaskListPageState();
}

class TaskListPageState extends State<TaskListPage> {
  late TaskListViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = TaskListViewModel(
      getTasksUseCase: getIt<GetTasksUseCase>(),
      removeTaskUseCase: getIt<RemoveTaskUseCase>(),
    )..fetchTaskList();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  refresh() => _viewModel.fetchTaskList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TaskListAppBar(
        viewModel: _viewModel,
        onDateTimePressed: () async {
          final currentDateTime = _viewModel.dateTime;
          final DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: currentDateTime,
            firstDate: DateTime.now().subtract(const Duration(days: 365)),
            lastDate: DateTime.now().add(const Duration(days: 365)),
          );
          if (pickedDate != null && pickedDate != currentDateTime) {
            setState(() {
              _viewModel.onDateTimeChanged(pickedDate);
            });
          }
        },
        onAddNewTaskPressed: () async {
          final result = await context.push('/addTask');
          if (result is bool && result) {
            _viewModel.fetchTaskList();
          }
        },
      ),
      body: Column(
        children: [
          StreamBuilder<DateTime>(
            stream: _viewModel.dateTimeStream,
            builder: (context, snapshot) {
              return TaskListCalendarTabBar(
                dateTime: snapshot.data ?? DateTime.now(),
                onDateTimeChanged: (value) => _viewModel.onDateTimeChanged(value),
              );
            },
          ),
          Expanded(
            child: StreamBuilder<List<Task>>(
              stream: _viewModel.taskListStream,
              builder: (context, snapshot) {
                final List<Task> taskList = snapshot.data ?? [];
                if (taskList.isEmpty) {
                  return Center(
                    child: Text(
                      'No tasks yet!',
                      style: AppTextStyle.textSMRegular.copyWith(color: AppColors.brandColor),
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: taskList.length,
                  itemBuilder: (context, index) {
                    return TaskItem(
                      task: taskList[index],
                      onItemPressed: () async {
                        await context.push('/details', extra: taskList[index]);
                        await _viewModel.fetchTaskList();
                      },
                      onMenuPressed: () async {
                        await showTaskMenuDialog(
                          context,
                          onEditPressed: () async {
                            final result = await context.push('/addTask', extra: taskList[index]);
                            if (result is bool && result) {
                              await _viewModel.fetchTaskList();
                            }
                          },
                          onRemovePressed: () => showConfirmDialog(
                            context,
                            message: 'Do you want to delete this task?',
                            confirmText: 'Delete',
                            cancelText: 'Cancel',
                            onConfirmed: () => _viewModel.onRemoveTask(taskList[index].id),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
