import 'package:flutter/material.dart';
import 'package:orchestrate/core/constants/strings.dart';
import 'package:orchestrate/core/themes/app_colors.dart';
import 'package:orchestrate/core/themes/app_text_styles.dart';

class TermsAndPrivacyAgreed extends StatelessWidget {
  final void Function() onTermsTap;
  final void Function() onPrivacyTap;

  const TermsAndPrivacyAgreed({
    super.key,
    required this.onTermsTap,
    required this.onPrivacyTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              Strings.bySigningUp,
              style: AppTextStyles.f12w600Black
                  .copyWith(color: AppColors.coolDarkGray),
            ),
            GestureDetector(
              onTap: onTermsTap,
              child: Text(
                Strings.termsConditions,
                style: AppTextStyles.f12w600Black
                    .copyWith(color: AppColors.deepBlue),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "${Strings.and} ",
              style: AppTextStyles.f12w600Black
                  .copyWith(color: AppColors.coolDarkGray),
            ),
            GestureDetector(
              onTap: onPrivacyTap,
              child: Text(
                Strings.privacyPolicy,
                style: AppTextStyles.f12w600Black
                    .copyWith(color: AppColors.deepBlue),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
