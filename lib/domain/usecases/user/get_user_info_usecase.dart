import 'package:todo_plugin/data/models/user.dart';
import 'package:todo_plugin/data/repositories/user_repository.dart';

class GetUserInfoUseCase {
  final UserRepository _repository;

  GetUserInfoUseCase({
    required UserRepository repository,
  }) : _repository = repository;

  Future<User?> execute() => _repository.get();
}
