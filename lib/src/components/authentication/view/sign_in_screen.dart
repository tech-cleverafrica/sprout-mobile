import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/authentication/view/sign_up_start.dart';
import 'package:sprout_mobile/src/components/home/view/bottom_nav.dart';
import 'package:sprout_mobile/src/public/widgets/custom_button.dart';
import 'package:sprout_mobile/src/public/widgets/custom_text_form_field.dart';
import 'package:sprout_mobile/src/public/widgets/custom_text_form_password_field.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/app_images.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                child: Text(
                  "Welcome Back, Mubarak",
                  style: TextStyle(
                      fontFamily: "DMSans",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w400,
                      color:
                          isDarkMode ? AppColors.white : AppColors.boxesColor),
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              CustomTextFormField(
                label: "Enter Email Address",
                hintText: "Your Email",
                fillColor: isDarkMode
                    ? AppColors.inputBackgroundColor
                    : AppColors.grey,
              ),
              CustomTextFormPasswordField(
                label: "Enter Password",
                hintText: "Your password",
                fillColor: isDarkMode
                    ? AppColors.inputBackgroundColor
                    : AppColors.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(value: false, onChanged: (value) {}),
                      Text(
                        "Remember Me",
                        style: TextStyle(
                            fontFamily: "DMSans",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: isDarkMode
                                ? AppColors.greyText
                                : AppColors.inputLabelColor),
                      )
                    ],
                  ),
                  Text(
                    'Forgot Password?',
                    style: TextStyle(
                        fontFamily: "DMSans",
                        fontSize: 12.sp,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode
                            ? AppColors.mainGreen
                            : AppColors.primaryColor),
                  ),
                ],
              ),
              SizedBox(
                height: 32.h,
              ),
              CustomButton(
                title: "Login",
                onTap: () {
                  Get.to(() => BottomNav());
                },
              ),
              SizedBox(
                height: 19.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "You do not have an account? ",
                    style: TextStyle(
                        fontFamily: "DMSans",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: isDarkMode ? AppColors.white : AppColors.black),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(SignUpStart());
                    },
                    child: Text(
                      "Create Account",
                      style: TextStyle(
                          fontFamily: "DMSans",
                          fontSize: 12.sp,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w700,
                          color: isDarkMode
                              ? AppColors.mainGreen
                              : AppColors.primaryColor),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 54.h,
              ),
              Center(
                  child: Column(
                children: [
                  SvgPicture.asset(
                    AppSvg.fingerprint,
                    height: 49,
                    width: 49,
                    color: isDarkMode ? AppColors.white : AppColors.black,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text('Use Fingerprint',
                      style: TextStyle(
                          fontFamily: "DMSans",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: isDarkMode
                              ? AppColors.greyText
                              : AppColors.black))
                ],
              ))
            ],
          ),
        ),
      )),
    );
  }
}
