import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo_plugin/data/models/user.dart';
import 'package:todo_plugin/config/app_assets.dart';
import 'package:todo_plugin/config/app_colors.dart';
import 'package:todo_plugin/config/app_text_styles.dart';
import 'package:todo_plugin/presentation/screens/profile/profile_viewmodel.dart';
import 'package:todo_plugin/utils/widget_utils.dart';

class UserInfoWidget extends StatelessWidget {
  final ProfileViewModel viewModel;
  final Function() onLoginPressed;

  const UserInfoWidget({
    super.key,
    required this.viewModel,
    required this.onLoginPressed,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: viewModel.userInfoStream,
      builder: (context, snapshot) {
        final User? userInfo = snapshot.data;
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.brandColor.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: const Offset(0, -1),
                      ),
                    ],
                  ),
                  child: userInfo != null
                      ? Column(
                          children: [
                            const SizedBox(height: 64),

                            /// UserName
                            Text(
                              userInfo.name,
                              style: AppTextStyle.textBaseSemiBold.copyWith(color: AppColors.subBrandColor),
                            ),
                            const SizedBox(height: 8),

                            /// Profession
                            Text(
                              userInfo.profession ?? 'N/A',
                              style: AppTextStyle.text2XSRegular.copyWith(color: AppColors.headerColor),
                            ),
                            const SizedBox(height: 12),

                            /// Location & Statistic Task Completed
                            Row(
                              children: [
                                _buildLocation(context, userLocation: 'Da Nang, Vietnam'),
                                Container(width: 2, height: 24, color: AppColors.brandColor.withOpacity(0.2)),
                                _buildTaskCompleted(context),
                              ],
                            ),
                            const SizedBox(height: 24),
                          ],
                        )
                      : _buildNotLogged(context),
                ),
              ],
            ),

            /// UserAvatar
            if (userInfo != null) _buildUserAvatar(context, imagePath: userInfo.image),
          ],
        );
      },
    );
  }

  _buildUserAvatar(
    BuildContext context, {
    required String? imagePath,
  }) {
    const int avatarSize = 84;

    return ClipRRect(
      borderRadius: BorderRadius.circular(avatarSize / 2),
      child: Container(
        width: avatarSize.toDouble(),
        height: avatarSize.toDouble(),
        decoration: BoxDecoration(color: AppColors.greyColor),
        child: imagePath != null
            ? Image.file(File(imagePath), fit: BoxFit.cover)
            : Center(
                child: Text(
                  'N/A',
                  style: AppTextStyle.textSMRegular.copyWith(color: AppColors.brandColor),
                ),
              ),
      ),
    );
  }

  _buildLocation(
    BuildContext context, {
    required String userLocation,
  }) {
    return Flexible(
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            WidgetUtils.svgPicture(
              AppAssets.iconLocation,
              color: AppColors.brandColor,
              width: 14,
            ),
            const SizedBox(width: 4),
            Text(
              userLocation,
              style: AppTextStyle.textXSRegular.copyWith(color: AppColors.textColor),
            ),
          ],
        ),
      ),
    );
  }

  _buildTaskCompleted(BuildContext context) {
    return Flexible(
      child: Center(
        child: StreamBuilder<int>(
          stream: viewModel.taskCompletedNumberStream,
          builder: (context, snapshot) {
            final int numberTasks = snapshot.data ?? 0;
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                WidgetUtils.svgPicture(
                  AppAssets.iconBag,
                  width: 14,
                  color: AppColors.brandColor,
                ),
                const SizedBox(width: 4),
                Text(
                  '$numberTasks Task Completed',
                  style: AppTextStyle.textXSRegular.copyWith(color: AppColors.textColor),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  _buildNotLogged(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      child: Center(
        child: RichText(
          text: TextSpan(
            text: "You're not logged in. ",
            style: AppTextStyle.textSMRegular.copyWith(color: AppColors.textColor),
            children: [
              TextSpan(
                text: "Log in now!",
                style: AppTextStyle.textSMRegular.copyWith(
                  decoration: TextDecoration.underline,
                  color: AppColors.subBrandColor,
                ),
                recognizer: TapGestureRecognizer()..onTap = onLoginPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
