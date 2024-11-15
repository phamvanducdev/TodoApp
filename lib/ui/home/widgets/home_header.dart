import 'package:flutter/material.dart';
import 'package:todo_plugin/theme/app_colors.dart';
import 'package:todo_plugin/theme/app_text_styles.dart';
import 'package:todo_plugin/ui/home/home_viewmodel.dart';

class HomeHeader extends StatelessWidget {
  final HomeViewModel viewModel;

  const HomeHeader({
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
          Text(
            'Welcome Phillip',
            style: AppTextStyle.textXLBold.copyWith(color: AppColors.headerColor),
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
