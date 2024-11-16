import 'package:flutter/material.dart';
import 'package:todo_plugin/routers/app_router.dart';
import 'package:todo_plugin/theme/app_colors.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: AppColors.brandColor,
      ),
      routerConfig: AppRouter.router,
    );
  }
}
