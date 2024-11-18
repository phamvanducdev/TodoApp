import 'package:flutter/material.dart';
import 'package:todo_plugin/config/app_assets.dart';
import 'package:todo_plugin/config/app_colors.dart';
import 'package:todo_plugin/presentation/screens/profile/widgets/setting_menu_item.dart';
import 'package:todo_plugin/presentation/widgets/base_app_bar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const BaseAppBar(title: 'Settings'),
      body: SafeArea(
        child: Stack(
          children: [
            Container(color: AppColors.brandColor),
            SingleChildScrollView(
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
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SettingMenuItem(
                            icon: AppAssets.iconNotification,
                            title: 'Notification',
                            onPressed: () {
                              // TODO: implement
                            },
                          ),
                          SettingMenuItem(
                            icon: AppAssets.iconSecurity,
                            title: 'Security',
                            onPressed: () {
                              // TODO: implement
                            },
                          ),
                          SettingMenuItem(
                            icon: AppAssets.iconHelp,
                            title: 'Help',
                            onPressed: () {
                              // TODO: implement
                            },
                          ),
                          SettingMenuItem(
                            icon: AppAssets.iconUpdateSystem,
                            title: 'Update System',
                            onPressed: () {
                              // TODO: implement
                            },
                          ),
                          SettingMenuItem(
                            icon: AppAssets.iconAbout,
                            title: 'About',
                            onPressed: () {
                              // TODO: implement
                            },
                          ),
                          SettingMenuItem(
                            icon: AppAssets.iconInvite,
                            title: 'Invite a friend',
                            onPressed: () {
                              // TODO: implement
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
