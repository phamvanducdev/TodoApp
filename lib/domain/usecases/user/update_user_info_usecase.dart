import 'package:todo_plugin/data/models/user.dart';
import 'package:todo_plugin/data/repositories/user_repository.dart';

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
