import 'package:flutter/material.dart';
import 'package:orchestrate/core/constants/image_path.dart';
import 'package:orchestrate/core/constants/strings.dart';
import 'package:orchestrate/core/responsive/size_extension.dart';
import 'package:orchestrate/core/themes/app_colors.dart';
import 'package:orchestrate/widgets/input_fields/text_input_field.dart';

class PasswordInputField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool isPasswordVisible;
  final TextEditingController passwordController;
  final void Function() onVisibilityTap;
  final void Function(String)? onFieldChanged;

  const PasswordInputField({
    super.key,
    this.hintText,
    this.errorText,
    this.onFieldChanged,
    required this.isPasswordVisible,
    required this.passwordController,
    required this.onVisibilityTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextInputField(
      hintText: hintText ?? Strings.password,
      icon: Image.asset(
        ImagePath.lockIcon,
        height: 20.h,
        width: 20.w,
        color: AppColors.coolDarkGray,
      ),
      suffixIcon: GestureDetector(
        onTap: onVisibilityTap,
        child: Icon(
          isPasswordVisible
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          size: 20.h,
          color: AppColors.coolDarkGray,
        ),
      ),
      errorText: errorText,
      obscureText: isPasswordVisible,
      keyboardType: TextInputType.visiblePassword,
      textController: passwordController,
      onFieldChanged: onFieldChanged,
    );
  }
}
