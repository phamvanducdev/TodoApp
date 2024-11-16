import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_plugin/config.dart';

class WidgetUtils {
  static Image image(
    String asset, {
    BoxFit? fit,
    double? width,
    double? height,
  }) {
    return Image.asset(
      asset,
      package: TodoAppConfig.packageName,
      fit: fit ?? BoxFit.contain,
      width: width,
      height: height,
    );
  }

  static SvgPicture svgPicture(
    String asset, {
    BoxFit? fit,
    double? width,
    double? height,
    Color? color,
  }) {
    return SvgPicture.asset(
      asset,
      package: TodoAppConfig.packageName,
      fit: fit ?? BoxFit.contain,
      width: width,
      height: height,
      colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
    );
  }
}
