import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_plugin/data/models/user.dart';
import 'package:todo_plugin/utils/constants.dart';

class UserStorageService {
  final SharedPreferences _prefs;

  UserStorageService({required SharedPreferences prefs}) : _prefs = prefs;

  Future<User?> getUserInfo() async {
    final String? userInfoString = _prefs.getString(AppConstants.USER_STORAGE_KEY);
    if (userInfoString != null) {
      return User.fromJson(jsonDecode(userInfoString));
    }
    return null;
  }

  Future<void> setUserInfo(User user) async {
    final userInfoString = jsonEncode(user.toJson());
    await _prefs.setString(AppConstants.USER_STORAGE_KEY, userInfoString);
  }
}
