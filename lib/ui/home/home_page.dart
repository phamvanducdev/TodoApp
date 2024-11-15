import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_plugin/core/usecases/add_task_usecase.dart';
import 'package:todo_plugin/core/usecases/get_available_priority_task_usecase.dart';
import 'package:todo_plugin/di/di.dart';
import 'package:todo_plugin/ui/home/home_viewmodel.dart';
import 'package:todo_plugin/ui/home/widgets/home_app_bar.dart';
import 'package:todo_plugin/ui/home/widgets/home_header.dart';
import 'package:todo_plugin/ui/home/widgets/home_priority_task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel(
      availablePriorityTaskUseCase: getIt<GetAvailablePriorityTaskUseCase>(),
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HomeAppBar(
        onSettingPressed: () async {
          await context.push('/addTask');
          _viewModel.initializer();
        },
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeHeader(viewModel: _viewModel),
            const SizedBox(height: 12),
            HomePriorityTask(
              viewModel: _viewModel,
              openTaskDetails: (task) async {
                await context.push('/details', extra: task);
                _viewModel.initializer();
              },
            ),
          ],
        ),
      ),
    );
  }
}
