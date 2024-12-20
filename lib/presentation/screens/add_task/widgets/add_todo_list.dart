import 'package:flutter/material.dart';
import 'package:todo_plugin/data/models/todo.dart';
import 'package:todo_plugin/config/app_assets.dart';
import 'package:todo_plugin/config/app_colors.dart';
import 'package:todo_plugin/config/app_text_styles.dart';
import 'package:todo_plugin/presentation/screens/add_task/add_task_viewmodel.dart';
import 'package:todo_plugin/presentation/screens/add_task/widgets/todo_item.dart';
import 'package:todo_plugin/utils/widget_utils.dart';
import 'package:todo_plugin/presentation/widgets/dashed_border_painter.dart';
import 'package:todo_plugin/presentation/widgets/input_todo_dialog.dart';

class AddTodoList extends StatelessWidget {
  final AddTaskViewModel viewModel;

  const AddTodoList({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'To do list',
          style: AppTextStyle.textSMMedium.copyWith(color: AppColors.brandColor),
        ),
        const SizedBox(height: 8),
        StreamBuilder<List<Todo>>(
          stream: viewModel.todoListStream,
          builder: (context, snapshot) {
            final List<Todo> todoList = snapshot.data ?? [];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: todoList
                  .map((todo) => TodoItem(
                        todo: todo,
                        onPressed: () async {
                          await showInputTodoDialog(
                            context,
                            todo: todo,
                            onUpdatePressed: (newTodo) => viewModel.updateTodo(newTodo),
                            onRemovePressed: () => viewModel.removeTodo(todo),
                          );
                        },
                      ))
                  .toList(),
            );
          },
        ),
        _buildAddTodo(context),
      ],
    );
  }

  _buildAddTodo(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await showInputTodoDialog(
          context,
          onUpdatePressed: (todo) => viewModel.addTodo(todo),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: CustomPaint(
          painter: DashedBorderPainter(
            color: AppColors.brandColor.withOpacity(0.1),
            borderRadius: 8,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              children: [
                WidgetUtils.svgPicture(
                  AppAssets.iconAdd,
                  color: AppColors.textColor.withOpacity(0.5),
                  width: 12,
                ),
                const SizedBox(width: 10),
                Text(
                  'Add to do',
                  style: AppTextStyle.textSMMedium.copyWith(color: AppColors.textColor.withOpacity(0.5)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
