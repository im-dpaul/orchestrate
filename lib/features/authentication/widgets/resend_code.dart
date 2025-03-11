import 'package:flutter/material.dart';
import 'package:orchestrate/core/constants/strings.dart';
import 'package:orchestrate/core/responsive/size_extension.dart';
import 'package:orchestrate/core/themes/app_colors.dart';
import 'package:orchestrate/core/themes/app_text_styles.dart';

class ResendCode extends StatelessWidget {
  final int timerSecond;
  final void Function() onResendTap;

  const ResendCode({
    super.key,
    required this.timerSecond,
    required this.onResendTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          Strings.didntReceiveCode,
          style: AppTextStyles.f16w600White.copyWith(
            color: AppColors.coolDarkGray,
          ),
        ),
        SizedBox(width: 6.w),
        Visibility(
          visible: timerSecond == 0,
          child: GestureDetector(
            onTap: onResendTap,
            child: Text(
              Strings.resend,
              style: AppTextStyles.f16w600White.copyWith(
                color: AppColors.deepBlue,
              ),
            ),
          ),
        ),
        Visibility(
          visible: timerSecond > 0,
          child: Text(
            timerSecond > 9 ? '0:$timerSecond' : '0:0$timerSecond',
            style: AppTextStyles.f16w600White.copyWith(
              color: AppColors.coolDarkGray,
            ),
          ),
        ),
      ],
    );
  }
}
