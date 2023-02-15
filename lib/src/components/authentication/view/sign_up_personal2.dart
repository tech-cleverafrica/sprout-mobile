import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/authentication/view/sign_up_create_login.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../public/widgets/custom_button.dart';
import '../../../public/widgets/custom_text_form_field.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/helper_widgets.dart';

class SignupPersonal2 extends StatelessWidget {
  const SignupPersonal2({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addVerticalSpace(10.h),
                StepProgressIndicator(
                  totalSteps: 4,
                  currentStep: 2,
                  size: 4,
                  roundedEdges: Radius.circular(10),
                  selectedColor: AppColors.mainGreen,
                  unselectedColor: AppColors.grey,
                ),
                addVerticalSpace(20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          size: 30,
                        )),
                    Image.asset(
                      AppImages.question,
                      height: 20,
                      color: isDarkMode ? AppColors.white : AppColors.black,
                    ),
                  ],
                ),
                addVerticalSpace(20.h),
                Text(
                  'You are almost there',
                  style: theme.textTheme.headline1,
                ),
                addVerticalSpace(10.h),
                Text(
                  "Let's get to know you!",
                  style: theme.textTheme.subtitle2,
                ),
                addVerticalSpace(30.h),
                CustomTextFormField(
                  label: "Business name (optional)",
                  hintText: "Enter your business name",
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                ),
                CustomTextFormField(
                  label: "Full Address",
                  hintText: "Enter your full address",
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                ),
                Row(
                  children: [
                    Container(
                      width: 150.w,
                      child: CustomTextFormField(
                        fillColor: isDarkMode
                            ? AppColors.inputBackgroundColor
                            : AppColors.grey,
                        label: "City",
                      ),
                    ),
                    addHorizontalSpace(20.w),
                    Expanded(
                        child: CustomTextFormField(
                      label: "State",
                      fillColor: isDarkMode
                          ? AppColors.inputBackgroundColor
                          : AppColors.grey,
                    ))
                  ],
                ),
                CustomTextFormField(
                  label: "State",
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                ),
                addVerticalSpace(45.h),
                Row(
                  children: [
                    Container(
                      width: 190.w,
                      child: CustomButton(
                        title: "Complete",
                        onTap: () {
                          Get.to(() => SignUpCreateLogin());
                        },
                      ),
                    ),
                    addHorizontalSpace(8.w),
                    Expanded(
                        child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: isDarkMode
                              ? AppColors.inputBackgroundColor
                              : AppColors.black,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "Go Back",
                          style: TextStyle(
                              fontFamily: "DMSans", color: AppColors.white),
                        ),
                      ),
                    ))
                  ],
                ),
                addVerticalSpace(30.h),
                Center(
                    child: Image.asset(
                  isDarkMode ? AppImages.sprout_dark : AppImages.sprout_light,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
