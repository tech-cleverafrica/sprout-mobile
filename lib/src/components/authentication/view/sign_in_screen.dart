import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/authentication/view/email_confirmation.dart';
import 'package:sprout_mobile/src/components/authentication/view/sign_up_start.dart';
import 'package:sprout_mobile/src/public/widgets/custom_button.dart';
import 'package:sprout_mobile/src/public/widgets/custom_text_form_field.dart';
import 'package:sprout_mobile/src/public/widgets/custom_text_form_password_field.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/app_images.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

import '../controller/sign_in_controller.dart';

// ignore: must_be_immutable
class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  late SignInController signInController;

  @override
  Widget build(BuildContext context) {
    signInController = Get.put(SignInController());
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpace(25.h),
              Center(
                  child: Image.asset(
                isDarkMode ? AppImages.sprout_dark : AppImages.sprout_light,
                height: 30.h,
              )),
              SizedBox(
                height: 24.h,
              ),
              Center(
                child: Obx((() => Text(
                      signInController.fullname.value != ""
                          ? "Welcome Back, " + signInController.fullname.value
                          : "Welcome Back",
                      style: TextStyle(
                          fontFamily: "Mont",
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w400,
                          color: isDarkMode
                              ? AppColors.white
                              : AppColors.boxesColor),
                    ))),
              ),
              SizedBox(
                height: 24.h,
              ),
              CustomTextFormField(
                controller: signInController.emailController,
                label: "Enter Email Address",
                hintText: "Your Email",
                fillColor: isDarkMode
                    ? AppColors.inputBackgroundColor
                    : AppColors.grey,
              ),
              CustomTextFormPasswordField(
                controller: signInController.passwordController,
                label: "Enter Password",
                hintText: "Your password",
                textInputAction: TextInputAction.go,
                fillColor: isDarkMode
                    ? AppColors.inputBackgroundColor
                    : AppColors.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () => push(
                        page: EmailConfirmation(
                      process: "reset",
                    )),
                    child: Container(
                      padding: EdgeInsets.only(left: 20, bottom: 20),
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                            fontFamily: "Mont",
                            fontSize: 12.sp,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w700,
                            color: isDarkMode
                                ? AppColors.mainGreen
                                : AppColors.primaryColor),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              CustomButton(
                title: "Login",
                onTap: () {
                  signInController.validate();
                },
              ),
              SizedBox(
                height: 9.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "You do not have an account? ",
                    style: TextStyle(
                        fontFamily: "Mont",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: isDarkMode ? AppColors.white : AppColors.black),
                  ),
                  InkWell(
                      onTap: () {
                        Get.to(SignUpStart());
                      },
                      child: Container(
                        padding:
                            EdgeInsets.only(right: 20, bottom: 20, top: 20),
                        child: Text(
                          "Create Account",
                          style: TextStyle(
                              fontFamily: "Mont",
                              fontSize: 12.sp,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w700,
                              color: isDarkMode
                                  ? AppColors.mainGreen
                                  : AppColors.primaryColor),
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: 54.h,
              ),
              Center(
                  child: Column(
                children: [
                  Obx(() => signInController.isFingerPrintEnabled.value
                      ? signInController.getBiometricIcon(isDarkMode)
                      : Container()),
                  SizedBox(
                    height: 8.h,
                  ),
                  Obx(
                    () => Text(
                        signInController.isFingerPrintEnabled.value
                            ? 'Use Biometric Login'
                            : "",
                        style: TextStyle(
                            fontFamily: "Mont",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: isDarkMode
                                ? AppColors.greyText
                                : AppColors.black)),
                  )
                ],
              ))
            ],
          ),
        ),
      )),
    );
  }
}
