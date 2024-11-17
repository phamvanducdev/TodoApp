import 'package:todo_plugin/core/models/user.dart';

abstract class UserRepository {
  Future<User?> get();
  Future<void> set(User userInfo);
}
