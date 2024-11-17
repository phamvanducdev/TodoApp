import 'dart:ui';

import 'package:todo_plugin/config/app_assets.dart';
import 'package:todo_plugin/config/app_colors.dart';

enum TaskThemeType { blue, purple, red }

extension TaskThemeTypeExt on TaskThemeType {
  Color get backgroundColor {
    switch (this) {
      case TaskThemeType.blue:
        return AppColors.subBrandColor;
      case TaskThemeType.purple:
        return const Color(0xFF311F65);
      case TaskThemeType.red:
        return const Color(0xFFD92C2C);
      default:
        return AppColors.subBrandColor;
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

  String get icon {
    switch (this) {
      case TaskThemeType.blue:
        return AppAssets.iconTaskLogoType1;
      case TaskThemeType.purple:
        return AppAssets.iconTaskLogoType2;
      case TaskThemeType.red:
        return AppAssets.iconTaskLogoType3;
      default:
        return AppAssets.iconTaskLogoType1;
    }
  }

  String get iconTintColor {
    switch (this) {
      case TaskThemeType.blue:
        return AppAssets.iconTaskLogoType1TintColor;
      case TaskThemeType.purple:
        return AppAssets.iconTaskLogoType2TintColor;
      case TaskThemeType.red:
        return AppAssets.iconTaskLogoType3TintColor;
      default:
        return AppAssets.iconTaskLogoType1TintColor;
    }
  }
}
