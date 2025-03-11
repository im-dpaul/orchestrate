import 'package:flutter/material.dart';
import 'package:orchestrate/core/constants/app_enums.dart';
import 'package:orchestrate/core/constants/image_path.dart';
import 'package:orchestrate/core/constants/strings.dart';
import 'package:orchestrate/core/responsive/size_extension.dart';
import 'package:orchestrate/core/routes/app_routes.dart';
import 'package:orchestrate/core/themes/app_colors.dart';
import 'package:orchestrate/core/themes/app_text_styles.dart';
import 'package:orchestrate/features/authentication/controllers/signup_provider.dart';
import 'package:orchestrate/widgets/appbar/common_appbar.dart';
import 'package:orchestrate/widgets/buttons/app_button.dart';
import 'package:orchestrate/widgets/input_fields/password_input_field.dart';
import 'package:provider/provider.dart';

class CreateResetPasswordScreen extends StatelessWidget {
  const CreateResetPasswordScreen({super.key});

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
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(
                    height: 300.h,
                    child: Center(
                      child: Image.asset(ImagePath.resetPasswordGraphics),
                    ),
                  ),
                  Consumer<SignupProvider>(
                    builder:
                        (BuildContext context, SignupProvider provider, _) {
                      return SizedBox(
                        width: 200.w,
                        child: Text(
                          provider.isCreatePassword
                              ? Strings.createPassword
                              : Strings.resetPassword,
                          style:
                              AppTextStyles.f32w600Black.copyWith(height: 1.2),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 30.h),
                  Consumer<SignupProvider>(
                    builder:
                        (BuildContext context, SignupProvider provider, _) {
                      return PasswordInputField(
                        hintText: Strings.newPassword,
                        errorText: provider.newPasswordErrorText,
                        isPasswordVisible: provider.showNewPassword,
                        passwordController:
                            signupProvider.newPasswordController,
                        onVisibilityTap: () {
                          signupProvider.toggleNewPasswordVisibility();
                        },
                        onFieldChanged: (String password) {
                          signupProvider.updateNewPasswordErrorText();
                        },
                      );
                    },
                  ),
                  SizedBox(height: 20.h),
                  Consumer<SignupProvider>(
                    builder:
                        (BuildContext context, SignupProvider provider, _) {
                      return PasswordInputField(
                        hintText: Strings.confirmPassword,
                        errorText: provider.confirmPasswordErrorText,
                        isPasswordVisible: provider.showConfirmPassword,
                        passwordController:
                            signupProvider.confirmPasswordController,
                        onVisibilityTap: () {
                          signupProvider.toggleConfirmPasswordVisibility();
                        },
                        onFieldChanged: (String password) {
                          signupProvider.updateConfirmPasswordErrorText();
                        },
                      );
                    },
                  ),
                  SizedBox(height: 130.h),
                  Consumer<SignupProvider>(
                    builder:
                        (BuildContext context, SignupProvider provider, _) {
                      return SizedBox(
                        height: 20.h,
                        child: Text(
                          provider.submitPasswordErrorText ?? '',
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
                        isLoading: provider.isLoading,
                        title: Strings.submit,
                        onButtonTap: () async {
                          bool registered =
                              await signupProvider.onSubmitPasswordTap();
                          if (context.mounted && registered) {
                            provider.userType == UserType.admin
                                ? Navigator.pushReplacementNamed(
                                    context, AppRoutes.dashboardScreen)
                                : Navigator.pushReplacementNamed(
                                    context, AppRoutes.homeScreen);
                          }
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
