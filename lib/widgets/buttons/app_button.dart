import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:orchestrate/core/themes/app_colors.dart';
import 'package:orchestrate/core/themes/app_text_styles.dart';

class AppButton extends StatelessWidget {
  final String title;
  final Color? color;
  final double? width;
  final double? height;
  final bool isLoading;
  final Color? loaderColor;
  final TextStyle? titleStyle;
  final void Function() onButtonTap;

  const AppButton({
    super.key,
    this.color,
    this.width,
    this.height,
    this.titleStyle,
    this.loaderColor,
    this.isLoading = false,
    required this.title,
    required this.onButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonTap,
      child: Container(
        width: width,
        height: height ?? 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color ?? AppColors.primaryBlue,
          borderRadius: BorderRadius.circular(12),
        ),
        child: isLoading
            ? LoadingAnimationWidget.waveDots(
                size: 36,
                color: loaderColor ?? AppColors.pureWhite,
              )
            : Text(
                title,
                style: titleStyle ?? AppTextStyles.f16w600White,
              ),
      ),
    );
  }
}
