import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_plugin/core/models/task.dart';
import 'package:todo_plugin/ui/add_task/add_task_screen.dart';
import 'package:todo_plugin/ui/home/home_screen.dart';
import 'package:todo_plugin/ui/task_details/task_details_screen.dart';

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
              return const AddTaskScreen();
            },
          ),
        ],
      ),
    ],
  );
}
