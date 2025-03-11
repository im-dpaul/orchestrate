import 'package:flutter/material.dart';
import 'package:orchestrate/core/responsive/size_extension.dart';
import 'package:orchestrate/core/themes/app_colors.dart';
import 'package:orchestrate/core/themes/app_text_styles.dart';

class UserRoleCard extends StatelessWidget {
  final String title;
  final bool isActive;
  final String cardIcon;
  final void Function() onCardTap;

  const UserRoleCard({
    super.key,
    required this.title,
    required this.cardIcon,
    required this.isActive,
    required this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardTap,
      child: AnimatedContainer(
        height: 156.h,
        width: 156.w,
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primaryBlue.withOpacity(0.2)
              : AppColors.pureWhite,
          border: Border.all(
            width: isActive ? 2 : 1,
            color: isActive ? AppColors.primaryBlue : AppColors.lightGray,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: Image.asset(
                cardIcon,
                height: 68.h,
                width: 68.w,
                color: AppColors.primaryBlue,
              ),
            ),
            Text(
              title,
              style: AppTextStyles.f16w600White
                  .copyWith(color: AppColors.pureBlack),
            ),
          ],
        ),
      ),
    );
  }
}
