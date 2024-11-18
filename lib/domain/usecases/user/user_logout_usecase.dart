import 'package:todo_plugin/data/repositories/user_repository.dart';

class UserLogoutUseCase {
  final UserRepository _repository;

  UserLogoutUseCase({
    required UserRepository repository,
  }) : _repository = repository;

  Future<void> execute() => _repository.clear();
}
