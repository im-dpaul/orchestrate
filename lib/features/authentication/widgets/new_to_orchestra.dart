import 'package:flutter/material.dart';
import 'package:orchestrate/core/constants/strings.dart';
import 'package:orchestrate/core/responsive/size_extension.dart';
import 'package:orchestrate/core/themes/app_colors.dart';
import 'package:orchestrate/core/themes/app_text_styles.dart';

class NewToOrchestra extends StatelessWidget {
  final void Function() onRegisterTap;

  const NewToOrchestra({
    super.key,
    required this.onRegisterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          Strings.newToOrchestra,
          style: AppTextStyles.f16w600White.copyWith(
            color: AppColors.coolDarkGray,
          ),
        ),
        SizedBox(width: 6.w),
        GestureDetector(
          onTap: onRegisterTap,
          child: Text(
            Strings.register,
            style: AppTextStyles.f16w600White.copyWith(
              color: AppColors.deepBlue,
            ),
          ),
        ),
      ],
    );
  }
}
