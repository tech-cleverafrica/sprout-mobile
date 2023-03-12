import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/authentication/controller/password_reset_controller.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/validators.dart';

import '../../../public/widgets/custom_text_form_field.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/helper_widgets.dart';

// ignore: must_be_immutable
class PasswordReset extends StatelessWidget {
  PasswordReset({super.key});

  late PasswordResetController passwordResetController;

  @override
  Widget build(BuildContext context) {
    passwordResetController = Get.put(PasswordResetController());
    final theme = Theme.of(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addVerticalSpace(10.h),
                Center(
                    child: Image.asset(
                  isDarkMode ? AppImages.sprout_dark : AppImages.sprout_light,
                  height: 27.h,
                )),
                SizedBox(
                  height: 24.h,
                ),
                Text(
                  "Reset Password",
                  style: TextStyle(
                      fontFamily: "DMSans",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w400,
                      color:
                          isDarkMode ? AppColors.white : AppColors.boxesColor),
                ),
                addVerticalSpace(10.h),
                Text(
                  "Reset your password with the OTP sent to your mail",
                  style: TextStyle(
                      fontFamily: "DMSans",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode
                          ? AppColors.semi_white
                          : AppColors.inputLabelColor),
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomTextFormField(
                  controller: passwordResetController.passwordController,
                  label: "New Password",
                  hintText: "New Password",
                  validator: Validators.passwordValidator,
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                ),
                CustomTextFormField(
                  controller: passwordResetController.confirmPasswordController,
                  label: "Repeat Password",
                  hintText: "Repeat Password",
                  validator: Validators.passwordValidator,
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                ),
                CustomTextFormField(
                  controller: passwordResetController.otpController,
                  label: "Supply otp",
                  hintText: "OTP",
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                ),
                addVerticalSpace(40.h),
                DecisionButton(
                    isDarkMode: isDarkMode,
                    buttonText: "Reset Password",
                    onTap: () {
                      passwordResetController.validatePasswords();
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
