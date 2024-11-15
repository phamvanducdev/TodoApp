import 'dart:ui';

import 'package:todo_plugin/theme/app_assets.dart';

enum TaskThemeType { blue, purple, red }

extension TaskThemeTypeExt on TaskThemeType {
  Color get backgroundColor {
    switch (this) {
      case TaskThemeType.blue:
        return const Color(0xFF006EE9);
      case TaskThemeType.purple:
        return const Color(0xFF311F65);
      case TaskThemeType.red:
        return const Color(0xFFD92C2C);
      default:
        return const Color(0xFF006EE9);
    }
  }

  Color get progressBackgroundColor {
    switch (this) {
      case TaskThemeType.blue:
        return const Color(0xFF004797);
      case TaskThemeType.purple:
        return const Color(0xFF000000);
      case TaskThemeType.red:
        return const Color(0xFF920101);
      default:
        return const Color(0xFF004797);
    }
  }

  String get titleIcon {
    switch (this) {
      case TaskThemeType.blue:
        return AppAssets.iconTaskTitle3;
      case TaskThemeType.purple:
        return AppAssets.iconTaskTitle2;
      case TaskThemeType.red:
        return AppAssets.iconTaskTitle1;
      default:
        return AppAssets.iconTaskTitle1;
    }
  }
}
