import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_plugin/config/app_assets.dart';
import 'package:todo_plugin/config/app_colors.dart';
import 'package:todo_plugin/config/app_text_styles.dart';
import 'package:todo_plugin/presentation/screens/update_profile/update_profile_viewmodel.dart';
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
            child: Container(
              width: avatarSize.toDouble(),
              height: avatarSize.toDouble(),
              decoration: BoxDecoration(color: AppColors.greyColor),
              child: StreamBuilder<String?>(
                stream: viewModel.imageAvatarPathStream,
                builder: (context, snapshot) {
                  final String? imagePath = snapshot.data;
                  if (imagePath != null) {
                    return Image.file(File(imagePath), fit: BoxFit.cover);
                  }
                  return Center(
                    child: Text(
                      'N/A',
                      style: AppTextStyle.textSMRegular.copyWith(color: AppColors.brandColor),
                    ),
                  );
                },
              ),
            ),
          ),

          /// Edit button
          Positioned(
            right: 4,
            bottom: 0,
            child: GestureDetector(
              onTap: _pickerImageAvatar,
              child: Container(
                width: 20,
                height: 20,
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

  _pickerImageAvatar() async {
    final XFile? imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      viewModel.onImageAvatarChanged(imageFile.path);
    }
  }
}
