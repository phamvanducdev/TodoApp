import 'package:todo_plugin/core/models/user.dart';
import 'package:todo_plugin/core/repositories/user_repository.dart';

class UpdateUserInfoUseCase {
  final UserRepository _repository;

  UpdateUserInfoUseCase({
    required UserRepository repository,
  }) : _repository = repository;

  Future<bool> execute(User userInfo) async {
    await _repository.set(userInfo);
    return true;
  }
}
