import 'package:flutter/material.dart';
import 'package:todo_plugin/data/models/user.dart';
import 'package:todo_plugin/config/app_colors.dart';
import 'package:todo_plugin/config/app_text_styles.dart';
import 'package:todo_plugin/presentation/screens/priority_tasks/priority_tasks_viewmodel.dart';
import 'package:todo_plugin/utils/extensions/user_name_extension.dart';

class PriorityTasksHeader extends StatelessWidget {
  final PriorityTasksViewModel viewModel;

  const PriorityTasksHeader({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder<User?>(
            stream: viewModel.userInfoStream,
            builder: (context, snapshot) {
              final User? userInfo = snapshot.data;
              return Text(
                'Welcome ${userInfo?.name.firstName ?? '...'}',
                style: AppTextStyle.textXLBold.copyWith(color: AppColors.headerColor),
              );
            },
          ),
          Text(
            'Have a nice day !',
            style: AppTextStyle.textBaseRegular.copyWith(color: AppColors.subHeaderColor),
          ),
        ],
      ),
    );
  }
}
