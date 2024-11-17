import 'package:todo_plugin/data/models/user.dart';

abstract class UserRepository {
  Future<User?> get();
  Future<void> set(User userInfo);
}
