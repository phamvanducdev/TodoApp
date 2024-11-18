import 'package:flutter/material.dart';
import 'package:todo_plugin/config/app_colors.dart';
import 'package:todo_plugin/di/app_get_it.dart';
import 'package:todo_plugin/domain/usecases/task/get_tasks_by_year_usecase.dart';
import 'package:todo_plugin/domain/usecases/task/get_tasks_usecase.dart';
import 'package:todo_plugin/presentation/screens/statistic/statistic_viewmodel.dart';
import 'package:todo_plugin/presentation/screens/statistic/widgets/statistic_filter_by_year_widget.dart';
import 'package:todo_plugin/presentation/screens/statistic/widgets/statistic_task_by_months_widget.dart';
import 'package:todo_plugin/presentation/screens/statistic/widgets/statistic_task_summary_widget.dart';
import 'package:todo_plugin/presentation/widgets/base_app_bar.dart';

class StatisticScreen extends StatefulWidget {
  const StatisticScreen({super.key});

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  late StatisticViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = StatisticViewModel(
      getTasksUseCase: getIt<GetTasksByYearUseCase>(),
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
      appBar: const BaseAppBar(title: 'Statistic'),
      body: SafeArea(
        child: Stack(
          children: [
            Container(color: AppColors.brandColor),
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 24),
                  Container(
                    constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 12),
                        StatisticFilterWidget(viewModel: _viewModel),
                        StatisticTaskSummaryWidget(viewModel: _viewModel),
                        StatisticTaskByMonthsWidget(viewModel: _viewModel),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
