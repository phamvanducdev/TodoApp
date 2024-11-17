import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:todo_plugin/domain/usecases/user/get_user_info_usecase.dart';
import 'package:todo_plugin/domain/usecases/user/update_user_info_usecase.dart';
import 'package:todo_plugin/di/app_get_it.dart';
import 'package:todo_plugin/config/app_colors.dart';
import 'package:todo_plugin/presentation/screens/update_profile/update_profile_viewmodel.dart';
import 'package:todo_plugin/presentation/screens/update_profile/widgets/input_date_of_birth.dart';
import 'package:todo_plugin/presentation/screens/update_profile/widgets/input_email.dart';
import 'package:todo_plugin/presentation/screens/update_profile/widgets/input_profession.dart';
import 'package:todo_plugin/presentation/screens/update_profile/widgets/input_user_name.dart';
import 'package:todo_plugin/presentation/screens/update_profile/widgets/save_profile_button.dart';
import 'package:todo_plugin/presentation/screens/update_profile/widgets/user_avatar.dart';
import 'package:todo_plugin/presentation/widgets/base_app_bar.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  late UpdateProfileViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = UpdateProfileViewModel(
      getUserInfoUseCase: getIt<GetUserInfoUseCase>(),
      updateUserInfoUseCase: getIt<UpdateUserInfoUseCase>(),
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
      appBar: const BaseAppBar(title: 'Update Profile'),
      body: KeyboardDismisser(
        child: SafeArea(
          child: Stack(
            children: [
              Container(color: AppColors.brandColor),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        children: [
                          const SizedBox(height: 24),
                          Container(
                            constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  UserAvatarWidget(viewModel: _viewModel),
                                  const SizedBox(height: 24),
                                  InputUserName(viewModel: _viewModel),
                                  const SizedBox(height: 24),
                                  InputProfession(viewModel: _viewModel),
                                  const SizedBox(height: 24),
                                  InputDateOfBirth(viewModel: _viewModel),
                                  const SizedBox(height: 24),
                                  InputEmail(viewModel: _viewModel),
                                  const SizedBox(height: 32),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SaveProfileButton(viewModel: _viewModel),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
