import 'package:flutter/material.dart';
import 'package:todo_plugin/app.dart';
import 'package:todo_plugin/config/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.initialized();
  runApp(const TodoApp());
}
