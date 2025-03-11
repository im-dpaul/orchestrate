import 'package:flutter/material.dart';
import 'package:orchestrate/core/responsive/size_extension.dart';
import 'package:orchestrate/core/themes/app_colors.dart';

class AppBackButton extends StatelessWidget {
  final void Function()? onButtonTap;

  const AppBackButton({
    super.key,
    required this.onButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonTap,
      child: Icon(
        Icons.arrow_back,
        size: 26.h,
        color: AppColors.pureBlack,
      ),
    );
  }
}
