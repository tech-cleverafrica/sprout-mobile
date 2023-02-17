import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/authentication/view/sign_up_personal2.dart';
import 'package:sprout_mobile/src/public/widgets/custom_button.dart';
import 'package:sprout_mobile/src/public/widgets/custom_text_form_field.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../public/widgets/custom_dropdown_button_field.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/helper_widgets.dart';

class SignupPersonalScreen extends StatelessWidget {
  const SignupPersonalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpace(10.h),
              StepProgressIndicator(
                totalSteps: 4,
                currentStep: 1,
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
                'Personal Details',
                style: theme.textTheme.headline1,
              ),
              addVerticalSpace(10.h),
              Text(
                "Let's get to know you!",
                style: theme.textTheme.subtitle2,
              ),
              addVerticalSpace(30.h),
              CustomTextFormField(
                label: "First name",
                hintText: "Enter your first name",
                fillColor: isDarkMode
                    ? AppColors.inputBackgroundColor
                    : AppColors.grey,
              ),
              CustomTextFormField(
                label: "Last name",
                hintText: "Enter your last name",
                fillColor: isDarkMode
                    ? AppColors.inputBackgroundColor
                    : AppColors.grey,
              ),
              Row(
                children: [
                  Container(
                    width: 80.w,
                    child: CustomDropdownButtonFormField(
                        fillColor: isDarkMode
                            ? AppColors.inputBackgroundColor
                            : AppColors.grey,
                        label: "Gender",
                        items: ["Male", "Female"],
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 20.0),
                        borderRadius: 14),
                  ),
                  addHorizontalSpace(20.w),
                  Expanded(
                      child: CustomTextFormField(
                    label: "D.O.B",
                    fillColor: isDarkMode
                        ? AppColors.inputBackgroundColor
                        : AppColors.grey,
                  ))
                ],
              ),
              addVerticalSpace(45.h),
              Row(
                children: [
                  Container(
                    width: 190.w,
                    child: CustomButton(
                      title: "Continue",
                      onTap: () {
                        Get.to(() => SignupPersonal2());
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
              addVerticalSpace(100.h),
              Center(
                  child: Image.asset(
                isDarkMode ? AppImages.sprout_dark : AppImages.sprout_light,
              )),
            ],
          ),
        ),
      )),
    );
  }
}
