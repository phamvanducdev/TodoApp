import 'package:flutter/material.dart';
import 'package:todo_plugin/theme/app_assets.dart';
import 'package:todo_plugin/utils/widget_utils.dart';

class HomeFloatingButton extends StatelessWidget {
  final Function() onPressed;

  const HomeFloatingButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 56,
        height: 56,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Color(0xFF025892),
              Color(0xFFD31249),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: WidgetUtils.svgPicture(AppAssets.iconPlus),
        ),
      ),
    );
  }
}
