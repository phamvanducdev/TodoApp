import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_plugin/core/repositories/impl/local_task_repository.dart';
import 'package:todo_plugin/core/repositories/task_repository.dart';
import 'package:todo_plugin/core/services/local_storage_service.dart';
import 'package:todo_plugin/core/usecases/add_task_usecase.dart';
import 'package:todo_plugin/core/usecases/get_available_priority_task_usecase.dart';
import 'package:todo_plugin/core/usecases/get_tasks_usecase.dart';
import 'package:todo_plugin/core/usecases/remove_task_usecase.dart';
import 'package:todo_plugin/core/usecases/update_task_usecase.dart';

final getIt = GetIt.instance;

class DI {
  static Future<void> register() async {
    final prefs = await SharedPreferences.getInstance();

    // Register LocalStorageService
    getIt.registerLazySingleton<LocalStorageService>(() => LocalStorageService(prefs: prefs));
    // getIt.registerLazySingleton<NetworkStorageService>(() => NetworkStorageService());

    // Register Repository
    getIt.registerLazySingleton<TaskRepository>(() => LocalTaskRepository(service: getIt<LocalStorageService>()));
    // getIt.registerLazySingleton<TaskRepository>(() => NetworkTaskRepository(service: getIt<NetworkStorageService>()));

    // Register UseCases
    getIt.registerLazySingleton(() => GetTasksUseCase(repository: getIt<TaskRepository>()));
    getIt.registerLazySingleton(() => AddTaskUseCase(repository: getIt<TaskRepository>()));
    getIt.registerLazySingleton(() => UpdateTaskUseCase(repository: getIt<TaskRepository>()));
    getIt.registerLazySingleton(() => RemoveTaskUseCase(repository: getIt<TaskRepository>()));
    getIt.registerLazySingleton(() => GetAvailablePriorityTaskUseCase(repository: getIt<TaskRepository>()));
  }
}
