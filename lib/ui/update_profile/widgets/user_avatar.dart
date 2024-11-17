import 'package:flutter/material.dart';
import 'package:todo_plugin/theme/app_assets.dart';
import 'package:todo_plugin/theme/app_colors.dart';
import 'package:todo_plugin/ui/update_profile/update_profile_viewmodel.dart';
import 'package:todo_plugin/utils/widget_utils.dart';

class UserAvatarWidget extends StatelessWidget {
  final UpdateProfileViewModel viewModel;
  final Function()? onEditPressed;

  const UserAvatarWidget({
    super.key,
    required this.viewModel,
    this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    const int avatarSize = 96;
    return Container(
      alignment: Alignment.center,
      child: Stack(
        children: [
          /// Avatar image
          ClipRRect(
            borderRadius: BorderRadius.circular(avatarSize / 2),
            child: Image.network('https://i.pravatar.cc/100'),
          ),

          /// Edit button
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: onEditPressed,
              child: Container(
                width: 24,
                height: 24,
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: AppColors.brandColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: WidgetUtils.svgPicture(
                  AppAssets.iconEdit,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
