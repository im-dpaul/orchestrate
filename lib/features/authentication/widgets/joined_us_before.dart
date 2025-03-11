import 'package:flutter/material.dart';
import 'package:orchestrate/core/constants/strings.dart';
import 'package:orchestrate/core/responsive/size_extension.dart';
import 'package:orchestrate/core/themes/app_colors.dart';
import 'package:orchestrate/core/themes/app_text_styles.dart';

class JoinedUsBefore extends StatelessWidget {
  final void Function() onLoginTap;

  const JoinedUsBefore({
    super.key,
    required this.onLoginTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          Strings.joinedBefore,
          style: AppTextStyles.f16w600White.copyWith(
            color: AppColors.coolDarkGray,
          ),
        ),
        SizedBox(width: 6.w),
        GestureDetector(
          onTap: onLoginTap,
          child: Text(
            Strings.login,
            style: AppTextStyles.f16w600White.copyWith(
              color: AppColors.deepBlue,
            ),
          ),
        ),
      ],
    );
  }
}
