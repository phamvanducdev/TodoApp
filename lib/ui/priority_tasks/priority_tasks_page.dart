import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_plugin/core/usecases/get_available_priority_task_usecase.dart';
import 'package:todo_plugin/di/di.dart';
import 'package:todo_plugin/ui/priority_tasks/priority_tasks_viewmodel.dart';
import 'package:todo_plugin/ui/priority_tasks/widgets/priority_tasks_app_bar.dart';
import 'package:todo_plugin/ui/priority_tasks/widgets/priority_tasks_header.dart';
import 'package:todo_plugin/ui/priority_tasks/widgets/priority_task_list.dart';

class PriorityTasksPage extends StatefulWidget {
  const PriorityTasksPage({super.key});

  @override
  State<PriorityTasksPage> createState() => PriorityTasksPageState();
}

class PriorityTasksPageState extends State<PriorityTasksPage> {
  late PriorityTasksViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = PriorityTasksViewModel(
      availablePriorityTaskUseCase: getIt<GetAvailablePriorityTaskUseCase>(),
    )..initializer();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  refresh() => _viewModel.initializer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PriorityTasksAppBar(
        onSettingPressed: () async {
          // TODO: implement
        },
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PriorityTasksHeader(viewModel: _viewModel),
            const SizedBox(height: 12),
            PriorityTaskList(
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
