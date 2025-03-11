import 'package:flutter/material.dart';
import 'package:orchestrate/core/constants/strings.dart';
import 'package:orchestrate/core/themes/app_colors.dart';
import 'package:orchestrate/core/themes/app_text_styles.dart';

class ForgotPassword extends StatelessWidget {
  final void Function() onForgotPasswordTap;

  const ForgotPassword({
    super.key,
    required this.onForgotPasswordTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onForgotPasswordTap,
      child: Text(
        Strings.forgotPassword,
        style: AppTextStyles.f16w600White.copyWith(
          color: AppColors.deepBlue,
        ),
      ),
    );
  }
}
