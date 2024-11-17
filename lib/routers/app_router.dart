import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_plugin/core/models/task.dart';
import 'package:todo_plugin/ui/add_task/add_task_screen.dart';
import 'package:todo_plugin/ui/home/home_screen.dart';
import 'package:todo_plugin/ui/profile/profile_screen.dart';
import 'package:todo_plugin/ui/task_details/task_details_screen.dart';
import 'package:todo_plugin/ui/update_profile/update_profile_screen.dart';

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
        ],
      ),
    ],
  );
}
