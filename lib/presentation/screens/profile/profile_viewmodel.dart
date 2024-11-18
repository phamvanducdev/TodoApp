import 'package:rxdart/rxdart.dart';
import 'package:todo_plugin/data/models/task.dart';
import 'package:todo_plugin/data/models/user.dart';
import 'package:todo_plugin/domain/usecases/task/get_tasks_usecase.dart';
import 'package:todo_plugin/domain/usecases/user/get_user_info_usecase.dart';
import 'package:todo_plugin/utils/extensions/task_list_extension.dart';

class ProfileViewModel {
  final GetUserInfoUseCase _getUserInfoUseCase;
  final GetAllTasksUseCase _getAllTasksUseCase;

  ProfileViewModel({
    required GetUserInfoUseCase getUserInfoUseCase,
    required GetAllTasksUseCase getAllTasksUseCase,
  })  : _getUserInfoUseCase = getUserInfoUseCase,
        _getAllTasksUseCase = getAllTasksUseCase;

  final _userInfoSubject = BehaviorSubject<User?>();
  Stream<User?> get userInfoStream => _userInfoSubject.stream;
  User? get userInfo => _userInfoSubject.valueOrNull;

  final _taskCompletedNumberSubject = BehaviorSubject<int>();
  Stream<int> get taskCompletedNumberStream => _taskCompletedNumberSubject.stream;

  initializer() async {
    await fetchUserInfo();
    await fetchTaskComplete();
  }

  fetchUserInfo() async {
    _userInfoSubject.add(await _getUserInfoUseCase.execute());
  }

  fetchTaskComplete() async {
    final List<Task> taskList = await _getAllTasksUseCase.execute();
    final List<Task> taskListCompleted = taskList.filterCompleted();
    _taskCompletedNumberSubject.add(taskListCompleted.length);
  }

  dispose() {
    _userInfoSubject.close();
  }
}
