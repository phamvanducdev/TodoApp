import 'package:flutter/material.dart';
import 'package:todo_plugin/app.dart';
import 'package:todo_plugin/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TodoAppConfig.initialized();
  runApp(const TodoApp());
}
