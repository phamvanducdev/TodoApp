import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:todo_plugin/core/models/todo.dart';
import 'package:todo_plugin/theme/app_colors.dart';
import 'package:todo_plugin/theme/app_text_styles.dart';
import 'package:todo_plugin/widgets/base_text_field.dart';

showInputTodoDialog(
  BuildContext context, {
  Todo? todo,
  Function(Todo)? onUpdatePressed,
  Function()? onRemovePressed,
}) async {
  const double insetPadding = 20;
  final TextEditingController inputController = TextEditingController();
  if (todo != null) {
    inputController.text = todo.title;
  }
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        insetPadding: const EdgeInsets.symmetric(horizontal: insetPadding),
        shadowColor: AppColors.subBrandColor.withOpacity(0.3),
        content: KeyboardDismisser(
          child: SizedBox(
            width: MediaQuery.of(context).size.width - insetPadding * 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /// InputField
                BaseTextField(
                  hint: 'Type something...',
                  autoFocus: true,
                  controller: inputController,
                  maxLines: 1,
                ),
                const SizedBox(height: 12),

                /// Edit/Add button
                GestureDetector(
                  onTap: () {
                    if (inputController.text.isEmpty) return;
                    context.pop();
                    onUpdatePressed?.call(
                      Todo(
                        id: todo?.id ?? DateTime.now().millisecondsSinceEpoch,
                        title: inputController.text,
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.brandColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      todo != null ? 'Edit Task' : 'Add Task',
                      style: AppTextStyle.textSMSemiBold.copyWith(color: Colors.white),
                    ),
                  ),
                ),

                /// Remove button
                if (todo != null) ...[
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      context.pop();
                      onRemovePressed?.call();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.brandColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Delete Task',
                        style: AppTextStyle.textSMSemiBold.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],

                /// Cancel button
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.brandColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Cancel',
                      style: AppTextStyle.textSMSemiBold.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
