import 'package:flutter/material.dart';
import 'package:orchestrate/core/constants/image_path.dart';
import 'package:orchestrate/core/constants/strings.dart';
import 'package:orchestrate/core/responsive/size_extension.dart';
import 'package:orchestrate/core/themes/app_colors.dart';
import 'package:orchestrate/core/themes/app_text_styles.dart';

class LoginWithGoogleButton extends StatelessWidget {
  final void Function() onLoginWithGoogleTap;

  const LoginWithGoogleButton({
    super.key,
    required this.onLoginWithGoogleTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onLoginWithGoogleTap,
      child: Container(
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.offWhite,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              Strings.loginGoogle,
              style: AppTextStyles.f16w600White.copyWith(
                color: AppColors.mediumGray,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Image.asset(
                  ImagePath.googleIcon,
                  height: 40.h,
                  width: 40.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
