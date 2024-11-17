import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:todo_plugin/core/models/task.dart';
import 'package:todo_plugin/core/usecases/user/get_user_info_usecase.dart';
import 'package:todo_plugin/di/di.dart';
import 'package:todo_plugin/theme/app_assets.dart';
import 'package:todo_plugin/theme/app_colors.dart';
import 'package:todo_plugin/ui/profile/profile_viewmodel.dart';
import 'package:todo_plugin/ui/profile/widgets/setting_menu_item.dart';
import 'package:todo_plugin/ui/profile/widgets/user_info_widget.dart';
import 'package:todo_plugin/widgets/base_app_bar.dart';
import 'package:todo_plugin/widgets/bottom_curve_clipper.dart';

class ProfileScreen extends StatefulWidget {
  final Task? task;

  const ProfileScreen({
    super.key,
    this.task,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ProfileViewModel(
      getUserInfoUseCase: getIt<GetUserInfoUseCase>(),
    )..initializer();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const BaseAppBar(title: 'Profile'),
        body: SafeArea(
          child: Stack(
            children: [
              SizedBox(
                height: 72,
                child: ClipPath(
                  clipper: BottomCurveClipper(),
                  child: Container(color: AppColors.brandColor),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        children: [
                          UserInfoWidget(
                            viewModel: _viewModel,
                            onLoginPressed: () async {
                              // TODO: Implement authentication
                              final result = await context.push('/updateProfile');
                              if (result is bool && result) {
                                _viewModel.initializer();
                              }
                            },
                          ),
                          const SizedBox(height: 24),
                          SettingMenuItem(
                            icon: AppAssets.iconProfile,
                            title: 'My Profile',
                            onPressed: () async {
                              final result = await context.push('/updateProfile');
                              if (result is bool && result) {
                                _viewModel.initializer();
                              }
                            },
                          ),
                          SettingMenuItem(
                            icon: AppAssets.iconChart,
                            title: 'Statistic',
                            onPressed: () {},
                          ),
                          SettingMenuItem(
                            icon: AppAssets.iconLocation,
                            title: 'Location',
                            onPressed: () {},
                          ),
                          SettingMenuItem(
                            icon: AppAssets.iconSetting,
                            title: 'Settings',
                            onPressed: () {},
                          ),
                          SettingMenuItem(
                            icon: AppAssets.iconLogout,
                            title: 'Logout',
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
