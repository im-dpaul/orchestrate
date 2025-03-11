import 'package:flutter/material.dart';
import 'package:orchestrate/core/responsive/size_extension.dart';
import 'package:orchestrate/core/themes/app_colors.dart';
import 'package:orchestrate/core/themes/app_text_styles.dart';

class TextInputField extends StatelessWidget {
  final bool? readOnly;
  final FocusNode? focusNode;
  final bool? obscureText;
  final EdgeInsetsGeometry? contentPadding;

  final String? hintText;
  final String? errorText;
  final Color? cursorColor;
  final double? cursorHeight;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final TextInputType? keyboardType;

  final InputBorder? border;
  final InputBorder? errorBorder;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;

  final Widget? icon;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final void Function()? onSearchTap;
  final void Function()? onTapOutside;
  final void Function(String)? onFieldChanged;
  final TextEditingController textController;

  /// Custom app text input field
  const TextInputField({
    super.key,
    this.border,
    this.errorBorder,
    this.focusedBorder,
    this.enabledBorder,
    this.obscureText,
    this.hintText,
    this.errorText,
    this.readOnly,
    this.textStyle,
    this.hintStyle,
    this.errorStyle,
    this.focusNode,
    this.cursorColor,
    this.cursorHeight,
    this.keyboardType,
    this.contentPadding,
    this.onSearchTap,
    this.onTapOutside,
    this.icon,
    this.prefixIcon,
    this.suffixIcon,
    required this.onFieldChanged,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.h,
      child: TextField(
        autofocus: false,
        controller: textController,
        focusNode: focusNode,
        cursorHeight: cursorHeight,
        obscureText: obscureText ?? false,
        keyboardAppearance: Brightness.light,
        keyboardType: keyboardType ?? TextInputType.text,
        style: textStyle ??
            AppTextStyles.f16w600CoolDarkGray
                .copyWith(color: AppColors.pureBlack),
        cursorColor: cursorColor ?? AppColors.primaryBlue,
        readOnly: readOnly ?? false,
        onTap: onSearchTap,
        onChanged: onFieldChanged,
        onTapOutside: (PointerDownEvent pointerDownEvent) {
          if (onTapOutside != null) {
            onTapOutside!();
          }
        },
        decoration: InputDecoration(
          isCollapsed: true,
          hintText: hintText,
          errorText: errorText,
          icon: icon,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          prefixIconConstraints:
              BoxConstraints(maxHeight: 40.h, maxWidth: 40.w),
          suffixIconConstraints:
              BoxConstraints(maxHeight: 40.h, maxWidth: 40.w),
          errorStyle: errorStyle ??
              AppTextStyles.f12w600Black.copyWith(color: AppColors.fireRed),
          hintStyle: hintStyle ?? AppTextStyles.f16w600CoolDarkGray,
          contentPadding: contentPadding ??
              EdgeInsets.symmetric(vertical: 8.h, horizontal: 0.w),
          border: border ??
              const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.softGray)),
          focusedBorder: focusedBorder ??
              const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryBlue)),
          enabledBorder: enabledBorder ??
              const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.softGray)),
          errorBorder: errorBorder ??
              const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.fireRed)),
        ),
      ),
    );
  }
}
