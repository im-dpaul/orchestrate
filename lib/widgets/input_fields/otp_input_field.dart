import 'package:flutter/material.dart';
import 'package:orchestrate/core/responsive/size_extension.dart';
import 'package:orchestrate/core/themes/app_colors.dart';
import 'package:orchestrate/core/themes/app_text_styles.dart';
import 'package:pinput/pinput.dart';

class OTPInputField extends StatelessWidget {
  final bool? enabled;
  final int? pinLength;
  final Widget? cursor;
  final String? errorText;
  final Color? cursorColor;
  final bool? showErrorState;
  final bool? enableSuggestions;
  final bool? enableAutoValidator;
  final TextStyle? errorTextStyle;
  final TextInputType? keyboardType;
  final bool? closeKeyboardWhenCompleted;
  final TextEditingController pinController;

  final void Function(String)? onFieldChanged;
  final void Function(String)? onFieldCompleted;
  final String? Function(String?)? pinValidator;

  const OTPInputField({
    super.key,
    this.cursor,
    this.enabled,
    this.pinLength,
    this.errorText,
    this.cursorColor,
    this.keyboardType,
    this.errorTextStyle,
    this.showErrorState,
    this.enableSuggestions,
    this.enableAutoValidator,
    this.closeKeyboardWhenCompleted,
    this.onFieldChanged,
    this.onFieldCompleted,
    this.pinValidator,
    required this.pinController,
  });

  @override
  Widget build(BuildContext context) {
    final PinTheme defaultPinTheme = PinTheme(
      width: 48.w,
      height: 48.h,
      textStyle:
          AppTextStyles.f16w600White.copyWith(color: AppColors.pureBlack),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.coolDarkGray),
      ),
    );

    return Pinput(
      forceErrorState: showErrorState ?? true,
      errorText: errorText,
      length: pinLength ?? 4,
      enabled: enabled ?? true,
      controller: pinController,
      defaultPinTheme: defaultPinTheme,
      enableSuggestions: enableSuggestions ?? true,
      keyboardType: keyboardType ?? TextInputType.number,
      hapticFeedbackType: HapticFeedbackType.lightImpact,
      closeKeyboardWhenCompleted: closeKeyboardWhenCompleted ?? true,
      cursor: cursor ??
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10.h),
                width: 20.w,
                height: 1.h,
                color: cursorColor ?? AppColors.primaryBlue,
              ),
            ],
          ),
      pinputAutovalidateMode: (enableAutoValidator ?? false)
          ? PinputAutovalidateMode.onSubmit
          : PinputAutovalidateMode.disabled,
      errorTextStyle: errorTextStyle ??
          AppTextStyles.f12w600Black.copyWith(color: AppColors.fireRed),
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: AppColors.primaryBlue),
        ),
      ),
      submittedPinTheme: defaultPinTheme.copyBorderWith(
        border: Border.all(color: AppColors.coolDarkGray),
      ),
      errorPinTheme: defaultPinTheme.copyBorderWith(
        border: Border.all(color: AppColors.fireRed),
      ),
      validator: pinValidator,
      onChanged: onFieldChanged,
      onCompleted: onFieldCompleted,
    );
  }
}
