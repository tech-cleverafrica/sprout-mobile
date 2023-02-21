import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/authentication/view/sign_in_screen.dart';
import 'package:sprout_mobile/src/components/authentication/view/sign_up_personal.dart';
import 'package:sprout_mobile/src/public/widgets/custom_button.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';

import '../../../utils/app_images.dart';
import '../../../utils/helper_widgets.dart';

class SignUpStart extends StatelessWidget {
  const SignUpStart({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: SingleChildScrollView(
              child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    addVerticalSpace(20.h),
                    Center(
                        child: Image.asset(
                      isDarkMode
                          ? AppImages.sprout_dark
                          : AppImages.sprout_light,
                    )),
                    addVerticalSpace(30.h),
                    TypeCard(
                      isDarkMode: isDarkMode,
                      text:
                          "I do not have a registered business name, LLC or partnership.",
                    ),
                    addVerticalSpace(10.h),
                    TypeCard(
                      isDarkMode: isDarkMode,
                      text:
                          "I do not have a registered business name, LLC or partnership.",
                    ),
                    addVerticalSpace(10.h),
                    TypeCard(
                      isDarkMode: isDarkMode,
                      text:
                          "I do not have a registered business name, LLC or partnership.",
                    ),
                    addVerticalSpace(10.h),
                    TypeCard(
                      isDarkMode: isDarkMode,
                      text:
                          "I do not have a registered business name, LLC or partnership.",
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                          fontFamily: "DMSans",
                          fontSize: 13.sp,
                          color: isDarkMode ? AppColors.white : AppColors.black,
                          fontWeight: FontWeight.w700),
                    ),
                    addHorizontalSpace(10.w),
                    Container(
                        width: 130,
                        child: CustomButton(
                          title: "Login",
                          onTap: () {
                            Get.to(() => SignInScreen());
                          },
                        ))
                  ],
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}

class TypeCard extends StatelessWidget {
  const TypeCard({Key? key, required this.isDarkMode, required this.text})
      : super(key: key);

  final bool isDarkMode;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => SignupPersonalScreen());
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: isDarkMode ? AppColors.grey : AppColors.black,
                width: 0.64)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDarkMode ? AppColors.grey : AppColors.grey),
              ),
              addHorizontalSpace(11.5.w),
              Container(
                width: 180.w,
                child: Text(
                  text,
                  style: TextStyle(
                      fontFamily: "DMSans",
                      fontSize: 13.sp,
                      color: isDarkMode ? AppColors.grey : AppColors.black,
                      fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
