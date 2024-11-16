import 'package:flutter/material.dart';
import 'package:todo_plugin/ui/add_task/add_task_viewmodel.dart';
import 'package:todo_plugin/widgets/date_selection.dart';

class InputStartEndDateTime extends StatelessWidget {
  final AddTaskViewModel viewModel;

  const InputStartEndDateTime({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: StreamBuilder<DateTime?>(
            stream: viewModel.startTimeStream,
            builder: (context, snapshot) {
              final DateTime startTime = snapshot.data ?? DateTime.now();
              return DateSelection(
                title: 'Start',
                currentDate: startTime,
                onDateChanged: (value) => viewModel.onStartTimeChanged(value),
                isEnable: false,
              );
            },
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          fit: FlexFit.tight,
          child: StreamBuilder<DateTime?>(
            stream: viewModel.endTimeStream,
            builder: (context, snapshot) {
              final DateTime endTime = snapshot.data ?? DateTime.now();
              return DateSelection(
                title: 'Ends',
                currentDate: endTime,
                onDateChanged: (value) => viewModel.onEndTimeChanged(value),
              );
            },
          ),
        ),
      ],
    );
  }
}
