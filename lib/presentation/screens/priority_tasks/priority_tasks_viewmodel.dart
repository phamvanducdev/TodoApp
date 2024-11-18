import 'package:rxdart/rxdart.dart';
import 'package:todo_plugin/data/models/task.dart';
import 'package:todo_plugin/data/models/user.dart';
import 'package:todo_plugin/domain/usecases/task/get_tasks_usecase.dart';
import 'package:todo_plugin/domain/usecases/user/get_user_info_usecase.dart';
import 'package:todo_plugin/utils/date_time_utils.dart';

class PriorityTasksViewModel {
  final GetAllTasksUseCase _getTaskUseCase;
  final GetUserInfoUseCase _getUserInfoUseCase;

  PriorityTasksViewModel({
    required GetAllTasksUseCase getTaskUseCase,
    required GetUserInfoUseCase getUserInfoUseCase,
  })  : _getTaskUseCase = getTaskUseCase,
        _getUserInfoUseCase = getUserInfoUseCase;

  final _priorityTaskListSubject = BehaviorSubject<List<Task>>();
  Stream<List<Task>> get priorityTaskListStream => _priorityTaskListSubject.stream;

  final _userInfoSubject = BehaviorSubject<User?>();
  Stream<User?> get userInfoStream => _userInfoSubject.stream;

  initializer() async {
    fetchUserInfo();
    fetchPriorityTaskList();
  }

  fetchUserInfo() async {
    final User? userInfo = await _getUserInfoUseCase.execute();
    _userInfoSubject.add(userInfo);
  }

  fetchPriorityTaskList() async {
    final List<Task> taskList = await _getTaskUseCase.execute();
    // Filter priority and unfinished
    final List<Task> priorityTaskList = taskList.where((task) {
      final DateTime endTime = DateTimeUtils.from(task.endTime);
      return task.priority && endTime.isAfter(DateTime.now());
    }).toList();
    _priorityTaskListSubject.add(priorityTaskList);
  }

  dispose() {
    _priorityTaskListSubject.close();
  }
}
