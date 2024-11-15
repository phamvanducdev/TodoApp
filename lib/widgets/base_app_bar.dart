import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_plugin/theme/app_assets.dart';
import 'package:todo_plugin/theme/app_colors.dart';
import 'package:todo_plugin/theme/app_text_styles.dart';
import 'package:todo_plugin/utils/widget_utils.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const BaseAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.brandColor,
      centerTitle: true,
      title: Text(
        title,
        style: AppTextStyle.textBaseSemiBold.copyWith(color: Colors.white),
      ),
      leading: IconButton(
        icon: WidgetUtils.svgPicture(AppAssets.iconBackSquare),
        onPressed: () => context.pop(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
