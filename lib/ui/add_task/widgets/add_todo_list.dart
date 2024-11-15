import 'package:flutter/material.dart';
import 'package:todo_plugin/core/models/todo.dart';
import 'package:todo_plugin/theme/app_assets.dart';
import 'package:todo_plugin/theme/app_colors.dart';
import 'package:todo_plugin/theme/app_text_styles.dart';
import 'package:todo_plugin/ui/add_task/add_task_viewmodel.dart';
import 'package:todo_plugin/ui/add_task/widgets/todo_item.dart';
import 'package:todo_plugin/utils/widget_utils.dart';
import 'package:todo_plugin/widgets/dashed_border_painter.dart';

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
                        onPressed: () {
                          // TODO: implement
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
      onTap: () {
        viewModel.addTodo(
          Todo(id: DateTime.now().millisecondsSinceEpoch, title: 'Hello'),
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
                  colorFilter: ColorFilter.mode(AppColors.textColor.withOpacity(0.5), BlendMode.srcIn),
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
