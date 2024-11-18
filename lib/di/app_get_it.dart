import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_plugin/data/repositories/impl/task_repository_impl.dart';
import 'package:todo_plugin/data/repositories/impl/user_repository_impl.dart';
import 'package:todo_plugin/data/repositories/task_repository.dart';
import 'package:todo_plugin/data/repositories/user_repository.dart';
import 'package:todo_plugin/data/services/local/task_storage_service.dart';
import 'package:todo_plugin/data/services/local/user_storage_service.dart';
import 'package:todo_plugin/domain/usecases/task/add_task_usecase.dart';
import 'package:todo_plugin/domain/usecases/task/get_tasks_by_date_usecase.dart';
import 'package:todo_plugin/domain/usecases/task/get_tasks_by_year_usecase.dart';
import 'package:todo_plugin/domain/usecases/task/get_tasks_usecase.dart';
import 'package:todo_plugin/domain/usecases/task/remove_task_usecase.dart';
import 'package:todo_plugin/domain/usecases/task/update_task_usecase.dart';
import 'package:todo_plugin/domain/usecases/user/get_user_info_usecase.dart';
import 'package:todo_plugin/domain/usecases/user/update_user_info_usecase.dart';
import 'package:todo_plugin/domain/usecases/user/user_logout_usecase.dart';

final getIt = GetIt.instance;

class AppGetIt {
  static Future<void> register() async {
    final prefs = await SharedPreferences.getInstance();

    // Register LocalStorageService
    getIt.registerLazySingleton<UserStorageService>(() => UserStorageService(prefs: prefs));
    getIt.registerLazySingleton<TaskStorageService>(() => TaskStorageService(prefs: prefs));
    // getIt.registerLazySingleton<NetworkStorageService>(() => NetworkStorageService());

    // Register Repository
    getIt.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(service: getIt<UserStorageService>()));
    getIt.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(service: getIt<TaskStorageService>()));

    // Register UseCases
    getIt.registerLazySingleton(() => GetAllTasksUseCase(repository: getIt<TaskRepository>()));
    getIt.registerLazySingleton(() => GetTasksByDateUsecase(repository: getIt<TaskRepository>()));
    getIt.registerLazySingleton(() => GetTasksByYearUseCase(repository: getIt<TaskRepository>()));
    getIt.registerLazySingleton(() => AddTaskUseCase(repository: getIt<TaskRepository>()));
    getIt.registerLazySingleton(() => UpdateTaskUseCase(repository: getIt<TaskRepository>()));
    getIt.registerLazySingleton(() => RemoveTaskUseCase(repository: getIt<TaskRepository>()));

    getIt.registerLazySingleton(() => GetUserInfoUseCase(repository: getIt<UserRepository>()));
    getIt.registerLazySingleton(() => UpdateUserInfoUseCase(repository: getIt<UserRepository>()));
    getIt.registerLazySingleton(() => UserLogoutUseCase(repository: getIt<UserRepository>()));
  }
}
