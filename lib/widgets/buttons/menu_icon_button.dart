import 'package:flutter/material.dart';
import 'package:orchestrate/core/responsive/size_extension.dart';
import 'package:orchestrate/core/themes/app_colors.dart';
import 'package:orchestrate/core/themes/app_text_styles.dart';

class MenuIconButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final void Function() onTap;

  const MenuIconButton({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 60.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: isSelected ? 30 : 28,
              color: isSelected ? AppColors.primaryBlue : AppColors.lightGray,
            ),
            SizedBox(height: 2.h),
            Text(
              title,
              style: AppTextStyles.f12w600Black
                  .copyWith(color: isSelected ? AppColors.primaryBlue : null),
            ),
          ],
        ),
      ),
    );
  }
}
