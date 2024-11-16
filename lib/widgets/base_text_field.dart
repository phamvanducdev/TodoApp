import 'package:flutter/material.dart';
import 'package:todo_plugin/theme/app_colors.dart';
import 'package:todo_plugin/theme/app_text_styles.dart';

class BaseTextField extends StatelessWidget {
  final Function(String)? onChanged;
  final String? hint;
  final int? maxLines;
  final int? minLines;
  final int? maxLenght;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool autoFocus;

  const BaseTextField({
    super.key,
    this.onChanged,
    this.hint,
    this.focusNode,
    this.controller,
    this.maxLines,
    this.minLines,
    this.maxLenght,
    this.keyboardType = TextInputType.text,
    this.autoFocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      maxLength: maxLenght,
      maxLines: maxLines,
      minLines: minLines,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.subBrandColor.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.brandColor.withOpacity(0.08)),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.destructiveColor),
          borderRadius: BorderRadius.circular(10),
        ),
        counterStyle: AppTextStyle.text2XSRegular.copyWith(color: AppColors.textColor),
        hintStyle: AppTextStyle.textSMRegular.copyWith(color: AppColors.textColor.withOpacity(0.5)),
      ),
      style: AppTextStyle.textSMRegular.copyWith(color: AppColors.textColor),
      keyboardType: keyboardType,
      cursorColor: AppColors.brandColor,
      cursorHeight: 20,
      autofocus: autoFocus,
    );
  }
}
