import 'package:flutter/material.dart';
import 'package:todo_plugin/config/app_colors.dart';
import 'package:todo_plugin/config/app_text_styles.dart';

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
  final FormFieldValidator? validation;

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
    this.validation,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
          borderSide: BorderSide(color: AppColors.destructiveColor.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.destructiveColor.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.brandColor.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(10),
        ),
        counterStyle: AppTextStyle.text2XSRegular.copyWith(color: AppColors.textColor),
        hintStyle: AppTextStyle.textSMRegular.copyWith(color: AppColors.textColor.withOpacity(0.5)),
        errorStyle: AppTextStyle.textXSRegular.copyWith(color: AppColors.destructiveColor.withOpacity(0.6)),
      ),
      style: AppTextStyle.textSMRegular.copyWith(color: AppColors.textColor),
      keyboardType: keyboardType,
      cursorColor: AppColors.brandColor,
      cursorHeight: 20,
      autofocus: autoFocus,
      validator: validation,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
