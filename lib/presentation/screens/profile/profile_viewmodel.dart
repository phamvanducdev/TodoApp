import 'package:rxdart/rxdart.dart';
import 'package:todo_plugin/data/models/user.dart';
import 'package:todo_plugin/domain/usecases/user/get_user_info_usecase.dart';

class ProfileViewModel {
  final GetUserInfoUseCase _getUserInfoUseCase;

  ProfileViewModel({
    required GetUserInfoUseCase getUserInfoUseCase,
  }) : _getUserInfoUseCase = getUserInfoUseCase;

  final _userInfoSubject = BehaviorSubject<User?>();
  Stream<User?> get userInfoStream => _userInfoSubject.stream;
  User? get userInfo => _userInfoSubject.valueOrNull;

  initializer() async {
    await fetchUserInfo();
  }

  fetchUserInfo() async {
    _userInfoSubject.add(await _getUserInfoUseCase.execute());
  }

  dispose() {
    _userInfoSubject.close();
  }
}
