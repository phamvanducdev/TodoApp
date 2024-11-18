import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todo_plugin/data/models/user.dart';
import 'package:todo_plugin/domain/usecases/user/get_user_info_usecase.dart';
import 'package:todo_plugin/domain/usecases/user/update_user_info_usecase.dart';
import 'package:todo_plugin/utils/date_time_utils.dart';
import 'package:todo_plugin/utils/extensions/email_validator_extension.dart';

class UpdateProfileViewModel {
  final GetUserInfoUseCase _getUserInfoUseCase;
  final UpdateUserInfoUseCase _updateUserInfoUseCase;

  UpdateProfileViewModel({
    required GetUserInfoUseCase getUserInfoUseCase,
    required UpdateUserInfoUseCase updateUserInfoUseCase,
  })  : _getUserInfoUseCase = getUserInfoUseCase,
        _updateUserInfoUseCase = updateUserInfoUseCase;

  final TextEditingController inputEmailController = TextEditingController();
  final TextEditingController inputUserNameController = TextEditingController();
  final TextEditingController inputProfessionController = TextEditingController();

  final FocusNode inputEmailFoucusNode = FocusNode();
  final FocusNode inputUserNameFoucusNode = FocusNode();
  final FocusNode inputProfessionFoucusNode = FocusNode();

  final _dateOfBirthSubject = BehaviorSubject<DateTime?>();
  Stream<DateTime?> get dateOfBirthStream => _dateOfBirthSubject.stream;
  DateTime? get dateOfBirth => _dateOfBirthSubject.valueOrNull;

  final _imageAvatarPathSubject = BehaviorSubject<String?>();
  Stream<String?> get imageAvatarPathStream => _imageAvatarPathSubject.stream;
  String? get imageAvatarPath => _imageAvatarPathSubject.valueOrNull;

  final _validateSubject = BehaviorSubject<bool>();
  Stream<bool> get validateStream => _validateSubject.stream;

  initializer() async {
    final userInfo = await _getUserInfoUseCase.execute();
    if (userInfo == null) return;
    inputEmailController.text = userInfo.email;
    inputUserNameController.text = userInfo.name;
    inputProfessionController.text = userInfo.profession ?? '';
    if (userInfo.dateOfBirth != null) {
      _dateOfBirthSubject.add(DateTimeUtils.from(userInfo.dateOfBirth!));
    }
    _imageAvatarPathSubject.add(userInfo.image);
    _validate();
  }

  onEmailChanged() => _validate();

  onUserNameChanged() => _validate();

  onProfessionChanged() => _validate();

  onDateOfBirthChanged(DateTime value) {
    _dateOfBirthSubject.add(value);
    _validate();
  }

  onImageAvatarChanged(String value) {
    _imageAvatarPathSubject.add(value);
  }

  Future<bool> onSavePressed() async {
    _updateUserInfoUseCase.execute(
      User(
        id: DateTime.now().millisecondsSinceEpoch,
        email: inputEmailController.text,
        name: inputUserNameController.text,
        image: imageAvatarPath,
        profession: inputProfessionController.text,
        dateOfBirth: (dateOfBirth ?? DateTime.now()).millisecondsSinceEpoch,
      ),
    );
    return true;
  }

  _validate() {
    _validateSubject.add(
      inputEmailController.text.isNotEmpty &&
          inputEmailController.text.isValidEmail() &&
          inputUserNameController.text.isNotEmpty &&
          inputProfessionController.text.isNotEmpty &&
          dateOfBirth != null,
    );
  }

  dispose() {
    inputEmailController.dispose();
    inputUserNameController.dispose();
    inputProfessionController.dispose();
    inputEmailFoucusNode.dispose();
    inputUserNameFoucusNode.dispose();
    inputProfessionFoucusNode.dispose();
    _validateSubject.close();
  }
}
