import 'package:flutter/material.dart';
import 'package:orchestrate/core/constants/image_path.dart';
import 'package:orchestrate/core/constants/strings.dart';
import 'package:orchestrate/core/responsive/size_extension.dart';
import 'package:orchestrate/core/routes/app_routes.dart';
import 'package:orchestrate/core/themes/app_colors.dart';
import 'package:orchestrate/core/themes/app_text_styles.dart';
import 'package:orchestrate/features/authentication/controllers/signup_provider.dart';
import 'package:orchestrate/features/authentication/widgets/resend_code.dart';
import 'package:orchestrate/widgets/appbar/common_appbar.dart';
import 'package:orchestrate/widgets/buttons/app_button.dart';
import 'package:orchestrate/widgets/input_fields/otp_input_field.dart';
import 'package:provider/provider.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignupProvider signupProvider =
        Provider.of<SignupProvider>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.pureWhite,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 28.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonAppBar(
                    onBackButtonTap: () {
                      signupProvider.otpTimer.cancel();
                      signupProvider.otpController.clear();
                      signupProvider.updateOTPErrorText();
                      signupProvider.updateOTPVerifyErrorText();
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(
                    height: 300.h,
                    child: Center(
                      child: Image.asset(ImagePath.otpGraphics),
                    ),
                  ),
                  Text(
                    Strings.enterOTP,
                    style: AppTextStyles.f32w600Black,
                  ),
                  SizedBox(height: 20.h),
                  Text(Strings.codeSentMessage,
                      style: AppTextStyles.f16w600CoolDarkGray),
                  Text('+91 ${signupProvider.newMobileController.text}',
                      style: AppTextStyles.f16w600CoolDarkGray),
                  SizedBox(height: 40.h),
                  Consumer<SignupProvider>(
                    builder:
                        (BuildContext context, SignupProvider provider, _) {
                      return OTPInputField(
                        pinLength: 6,
                        showErrorState:
                            (provider.otpErrorText ?? "").isNotEmpty,
                        pinController: signupProvider.otpController,
                        errorText: provider.otpErrorText,
                        onFieldChanged: (String code) {
                          signupProvider.updateOTPErrorText();
                          signupProvider.updateOTPVerifyErrorText();
                        },
                      );
                    },
                  ),
                  SizedBox(height: 100.h),
                  Consumer<SignupProvider>(
                    builder:
                        (BuildContext context, SignupProvider provider, _) {
                      return SizedBox(
                        height: 20.h,
                        child: Text(
                          provider.otpVerifyErrorText ?? '',
                          style: AppTextStyles.f12w600Black
                              .copyWith(color: AppColors.fireRed),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 8.h),
                  Consumer<SignupProvider>(
                    builder:
                        (BuildContext context, SignupProvider provider, _) {
                      return AppButton(
                        title: Strings.verify,
                        isLoading: provider.isLoading,
                        onButtonTap: () async {
                          bool verified =
                              await signupProvider.onOTPVerifyButtonTap();
                          if (context.mounted && verified) {
                            provider.isRegisterUser
                                ? Navigator.pushNamed(
                                    context, AppRoutes.roleSelectionScreen)
                                : Navigator.pushNamed(context,
                                    AppRoutes.createResetPasswordScreen);
                          }
                        },
                      );
                    },
                  ),
                  SizedBox(height: 40.h),
                  Consumer<SignupProvider>(
                    builder:
                        (BuildContext context, SignupProvider provider, _) {
                      return ResendCode(
                        timerSecond: provider.timerSecond,
                        onResendTap: () {
                          signupProvider.startTimer();
                        },
                      );
                    },
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
