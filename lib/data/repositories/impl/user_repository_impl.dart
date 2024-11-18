import 'package:todo_plugin/data/models/user.dart';
import 'package:todo_plugin/data/repositories/user_repository.dart';
import 'package:todo_plugin/data/services/local/user_storage_service.dart';

class UserRepositoryImpl implements UserRepository {
  final UserStorageService _service;

  UserRepositoryImpl({
    required UserStorageService service,
  }) : _service = service;

  @override
  Future<User?> get() => _service.getUserInfo();

  @override
  Future<void> set(User userInfo) => _service.setUserInfo(userInfo);

  @override
  Future<void> clear() => _service.clearUserInfo();
}
