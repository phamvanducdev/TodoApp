import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:todo_plugin/core/usecases/add_task_usecase.dart';
import 'package:todo_plugin/di/di.dart';
import 'package:todo_plugin/theme/app_colors.dart';
import 'package:todo_plugin/ui/add_task/add_task_viewmodel.dart';
import 'package:todo_plugin/ui/add_task/widgets/add_task_button.dart';
import 'package:todo_plugin/ui/add_task/widgets/add_todo_list.dart';
import 'package:todo_plugin/ui/add_task/widgets/input_description.dart';
import 'package:todo_plugin/ui/add_task/widgets/input_start_end_date_time.dart';
import 'package:todo_plugin/ui/add_task/widgets/input_title.dart';
import 'package:todo_plugin/widgets/base_app_bar.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  late AddTaskViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = AddTaskViewModel(
      addTaskUseCase: getIt<AddTaskUseCase>(),
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
        backgroundColor: AppColors.brandColor,
        appBar: const BaseAppBar(title: 'Add Task'),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
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
                            InputStartEndDateTime(viewModel: _viewModel),
                            const SizedBox(height: 24),
                            InputTitle(viewModel: _viewModel),
                            const SizedBox(height: 16),
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
      ),
    );
  }
}
