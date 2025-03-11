import 'package:flutter/material.dart';
import 'package:orchestrate/core/constants/image_path.dart';
import 'package:orchestrate/core/constants/strings.dart';
import 'package:orchestrate/core/responsive/size_extension.dart';
import 'package:orchestrate/core/themes/app_colors.dart';
import 'package:orchestrate/core/themes/app_text_styles.dart';
import 'package:orchestrate/features/authentication/controllers/login_provider.dart';
import 'package:orchestrate/widgets/appbar/common_appbar.dart';
import 'package:orchestrate/widgets/buttons/app_button.dart';
import 'package:orchestrate/widgets/input_fields/text_input_field.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 28.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonAppBar(
                    onBackButtonTap: () {
                      loginProvider.updateResetEmailErrorText();
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(
                    height: 300.h,
                    child: Center(
                      child: Image.asset(ImagePath.forgetPasswordGraphics),
                    ),
                  ),
                  SizedBox(
                    width: 200.w,
                    child: Text(
                      Strings.forgotPassword,
                      style: AppTextStyles.f32w600Black.copyWith(height: 1.2),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(Strings.dontWorryMessage,
                      style: AppTextStyles.f16w600CoolDarkGray),
                  SizedBox(height: 40.h),
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
                        errorText: provider.resetEmailErrorText,
                        textController: loginProvider.resetEmailController,
                        onFieldChanged: (String text) {
                          loginProvider.updateResetEmailErrorText();
                        },
                      );
                    },
                  ),
                  SizedBox(height: 142.h),
                  Consumer<LoginProvider>(
                    builder: (BuildContext context, LoginProvider provider, _) {
                      return AppButton(
                        title: Strings.submit,
                        isLoading: provider.isLoading,
                        onButtonTap: () async {
                          bool sent = await loginProvider.onSubmitTap();
                          if (sent && context.mounted) {
                            Navigator.of(context).pop();
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
