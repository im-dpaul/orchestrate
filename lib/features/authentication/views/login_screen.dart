import 'package:flutter/material.dart';
import 'package:orchestrate/core/constants/image_path.dart';
import 'package:orchestrate/core/constants/strings.dart';
import 'package:orchestrate/core/responsive/size_extension.dart';
import 'package:orchestrate/core/routes/app_routes.dart';
import 'package:orchestrate/core/themes/app_colors.dart';
import 'package:orchestrate/core/themes/app_text_styles.dart';
import 'package:orchestrate/features/authentication/controllers/login_provider.dart';
import 'package:orchestrate/features/authentication/widgets/forgot_password.dart';
import 'package:orchestrate/features/authentication/widgets/new_to_orchestra.dart';
import 'package:orchestrate/widgets/buttons/app_button.dart';
import 'package:orchestrate/widgets/input_fields/password_input_field.dart';
import 'package:orchestrate/widgets/input_fields/text_input_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginProvider loginProvider =
        Provider.of<LoginProvider>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.pureWhite,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 28.h, horizontal: 28.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 300.h,
                    child: Center(
                      child: Image.asset(ImagePath.loginGraphics),
                    ),
                  ),
                  Text(
                    Strings.login,
                    style: AppTextStyles.f32w600Black,
                  ),
                  SizedBox(height: 30.h),
                  Consumer<LoginProvider>(
                    builder: (BuildContext context, LoginProvider provider, _) {
                      return TextInputField(
                        hintText: Strings.emailID,
                        icon: Image.asset(
                          ImagePath.emailIcon,
                          height: 20.h,
                          width: 20.w,
                          color: AppColors.coolDarkGray.withOpacity(0.9),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textController: loginProvider.emailController,
                        errorText: provider.emailErrorText,
                        onFieldChanged: (String text) {
                          loginProvider.updateEmailErrorText();
                        },
                      );
                    },
                  ),
                  SizedBox(height: 20.h),
                  Consumer<LoginProvider>(
                    builder: (BuildContext context, LoginProvider provider, _) {
                      return PasswordInputField(
                        isPasswordVisible: provider.showPassword,
                        passwordController: loginProvider.passwordController,
                        errorText: provider.passwordErrorText,
                        onVisibilityTap: () {
                          loginProvider.togglePasswordVisibility();
                        },
                        onFieldChanged: (String text) {
                          loginProvider.updatePasswordErrorText();
                        },
                      );
                    },
                  ),
                  SizedBox(height: 28.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ForgotPassword(
                      onForgotPasswordTap: () {
                        Navigator.pushNamed(
                            context, AppRoutes.forgotPasswordScreen);
                      },
                    ),
                  ),
                  SizedBox(height: 66.h),
                  Consumer<LoginProvider>(
                    builder: (BuildContext context, LoginProvider provider, _) {
                      return SizedBox(
                        height: 20.h,
                        child: Text(
                          provider.authErrorText ?? '',
                          style: AppTextStyles.f12w600Black
                              .copyWith(color: AppColors.fireRed),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 8.h),
                  Consumer<LoginProvider>(
                    builder: (BuildContext context, LoginProvider provider, _) {
                      return AppButton(
                        title: Strings.login,
                        isLoading: provider.isLoading,
                        onButtonTap: () async {
                          bool isAuthenticated =
                              await loginProvider.onLoginButtonTap();
                          if (isAuthenticated && context.mounted) {
                            provider.isAdmin
                                ? Navigator.pushReplacementNamed(
                                    context, AppRoutes.dashboardScreen)
                                : Navigator.pushReplacementNamed(
                                    context, AppRoutes.homeScreen);
                          }
                        },
                      );
                    },
                  ),
                  // const OrDivider(),
                  // LoginWithGoogleButton(
                  //   onLoginWithGoogleTap: () {},
                  // ),
                  SizedBox(height: 40.h),
                  NewToOrchestra(
                    onRegisterTap: () {
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.signupScreen);
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
