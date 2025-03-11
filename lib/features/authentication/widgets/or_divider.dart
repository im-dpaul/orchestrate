import 'package:flutter/material.dart';
import 'package:orchestrate/core/constants/strings.dart';
import 'package:orchestrate/core/responsive/size_extension.dart';
import 'package:orchestrate/core/themes/app_colors.dart';
import 'package:orchestrate/core/themes/app_text_styles.dart';
import 'package:orchestrate/widgets/divider/h_divider.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 20.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const HDivider(),
          Container(
            color: AppColors.pureWhite,
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Text(
              Strings.or.toUpperCase(),
              style: AppTextStyles.f16w600CoolDarkGray,
            ),
          ),
        ],
      ),
    );
  }
}
