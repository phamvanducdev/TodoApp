import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:todo_plugin/data/models/task.dart';
import 'package:todo_plugin/domain/usecases/task/add_task_usecase.dart';
import 'package:todo_plugin/domain/usecases/task/update_task_usecase.dart';
import 'package:todo_plugin/di/app_get_it.dart';
import 'package:todo_plugin/config/app_colors.dart';
import 'package:todo_plugin/presentation/screens/add_task/add_task_viewmodel.dart';
import 'package:todo_plugin/presentation/screens/add_task/widgets/add_task_button.dart';
import 'package:todo_plugin/presentation/screens/add_task/widgets/add_todo_list.dart';
import 'package:todo_plugin/presentation/screens/add_task/widgets/input_description.dart';
import 'package:todo_plugin/presentation/screens/add_task/widgets/input_priority.dart';
import 'package:todo_plugin/presentation/screens/add_task/widgets/input_start_end_date_time.dart';
import 'package:todo_plugin/presentation/screens/add_task/widgets/input_title.dart';
import 'package:todo_plugin/presentation/screens/add_task/widgets/task_title.dart';
import 'package:todo_plugin/presentation/widgets/base_app_bar.dart';

class AddTaskScreen extends StatefulWidget {
  final Task? task;

  const AddTaskScreen({
    super.key,
    this.task,
  });

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  late AddTaskViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = AddTaskViewModel(
      task: widget.task,
      addTaskUseCase: getIt<AddTaskUseCase>(),
      updateTaskUseCase: getIt<UpdateTaskUseCase>(),
    )..initializer();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: BaseAppBar(title: _viewModel.isCreateNew ? 'Add Task' : 'Update Task'),
        body: SafeArea(
          child: Stack(
            children: [
              Container(color: AppColors.brandColor),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        children: [
                          const SizedBox(height: 24),
                          Container(
                            constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  if (!_viewModel.isCreateNew && widget.task != null) ...[
                                    TaskTitle(task: widget.task!),
                                    const SizedBox(height: 32),
                                  ],
                                  InputStartEndDateTime(viewModel: _viewModel),
                                  const SizedBox(height: 24),
                                  InputTitle(viewModel: _viewModel),
                                  const SizedBox(height: 16),
                                  InputPriority(viewModel: _viewModel),
                                  const SizedBox(height: 24),
                                  InputDescription(viewModel: _viewModel),
                                  const SizedBox(height: 16),
                                  AddTodoList(viewModel: _viewModel),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  AddTaskButton(viewModel: _viewModel),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
