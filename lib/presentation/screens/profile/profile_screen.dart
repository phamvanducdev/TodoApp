import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_plugin/data/models/task.dart';
import 'package:todo_plugin/domain/usecases/task/get_tasks_usecase.dart';
import 'package:todo_plugin/domain/usecases/user/get_user_info_usecase.dart';
import 'package:todo_plugin/di/app_get_it.dart';
import 'package:todo_plugin/config/app_assets.dart';
import 'package:todo_plugin/config/app_colors.dart';
import 'package:todo_plugin/presentation/screens/profile/profile_viewmodel.dart';
import 'package:todo_plugin/presentation/screens/profile/widgets/setting_menu_item.dart';
import 'package:todo_plugin/presentation/screens/profile/widgets/user_info_widget.dart';
import 'package:todo_plugin/presentation/widgets/base_app_bar.dart';
import 'package:todo_plugin/presentation/widgets/bottom_curve_clipper.dart';

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
      getAllTasksUseCase: getIt<GetAllTasksUseCase>(),
    )..initializer();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          onPressed: () => context.push('/statistic'),
                        ),
                        SettingMenuItem(
                          icon: AppAssets.iconLocation,
                          title: 'Location',
                          onPressed: () {},
                        ),
                        SettingMenuItem(
                          icon: AppAssets.iconSetting,
                          title: 'Settings',
                          onPressed: () => context.push('/settings'),
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
    );
  }
}
