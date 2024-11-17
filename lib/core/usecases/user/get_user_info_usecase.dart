import 'package:todo_plugin/core/models/user.dart';
import 'package:todo_plugin/core/repositories/user_repository.dart';

class GetUserInfoUseCase {
  final UserRepository _repository;

  GetUserInfoUseCase({
    required UserRepository repository,
  }) : _repository = repository;

  Future<User?> execute() => _repository.get();
}
