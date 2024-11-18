import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_plugin/data/models/task.dart';
import 'package:todo_plugin/presentation/screens/add_task/add_task_screen.dart';
import 'package:todo_plugin/presentation/screens/home/home_screen.dart';
import 'package:todo_plugin/presentation/screens/profile/profile_screen.dart';
import 'package:todo_plugin/presentation/screens/settings/settings_screen.dart';
import 'package:todo_plugin/presentation/screens/statistic/statistic_screen.dart';
import 'package:todo_plugin/presentation/screens/task_details/task_details_screen.dart';
import 'package:todo_plugin/presentation/screens/update_profile/update_profile_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'details',
            builder: (BuildContext context, GoRouterState state) {
              return DetailsScreen(task: state.extra as Task);
            },
          ),
          GoRoute(
            path: 'addTask',
            builder: (BuildContext context, GoRouterState state) {
              final Task? task = state.extra != null ? state.extra as Task : null;
              return AddTaskScreen(task: task);
            },
          ),
          GoRoute(
            path: 'profile',
            builder: (BuildContext context, GoRouterState state) {
              return const ProfileScreen();
            },
          ),
          GoRoute(
            path: 'updateProfile',
            builder: (BuildContext context, GoRouterState state) {
              return const UpdateProfileScreen();
            },
          ),
          GoRoute(
            path: 'statistic',
            builder: (BuildContext context, GoRouterState state) {
              return const StatisticScreen();
            },
          ),
          GoRoute(
            path: 'settings',
            builder: (BuildContext context, GoRouterState state) {
              return const SettingsScreen();
            },
          ),
        ],
      ),
    ],
  );
}
