extension UserNameExtension on String {
  String get firstName {
    if (isEmpty) return '';
    return split(' ').first;
  }
}
