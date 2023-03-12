import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/authentication/controller/signup_controller.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../public/widgets/custom_text_form_field.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/helper_widgets.dart';

// ignore: must_be_immutable
class SignupPersonal2 extends StatelessWidget {
  SignupPersonal2({super.key});

  late SignUpController signUpController;

  @override
  Widget build(BuildContext context) {
    signUpController = Get.put(SignUpController());
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
                StepProgressIndicator(
                  totalSteps: 4,
                  currentStep: 2,
                  size: 3,
                  roundedEdges: Radius.circular(10),
                  selectedColor: AppColors.mainGreen,
                  unselectedColor: AppColors.grey,
                  padding: 4,
                ),
                addVerticalSpace(24.h),
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
                  style: TextStyle(
                      fontFamily: "DMSans",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode
                          ? AppColors.white
                          : AppColors.inputLabelColor),
                ),
                addVerticalSpace(36.h),
                CustomTextFormField(
                  controller: signUpController.businessNameController,
                  label: "Business name (optional)",
                  hintText: "Enter your business name",
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                ),
                CustomTextFormField(
                  controller: signUpController.fullAddressController,
                  label: "Full address",
                  hintText: "Enter your full address",
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: CustomTextFormField(
                          controller: signUpController.cityController,
                          fillColor: isDarkMode
                              ? AppColors.inputBackgroundColor
                              : AppColors.grey,
                          label: "City",
                        ),
                      ),
                    ),
                    addHorizontalSpace(10.w),
                    Expanded(
                        child: CustomTextFormField(
                      controller: signUpController.stateController,
                      label: "State",
                      fillColor: isDarkMode
                          ? AppColors.inputBackgroundColor
                          : AppColors.grey,
                    ))
                  ],
                ),
                CustomTextFormField(
                  controller: signUpController.referralController,
                  label: "Referral code",
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                ),
                addVerticalSpace(48.h),
                DecisionButton(
                    isDarkMode: isDarkMode,
                    buttonText: "Continue",
                    onTap: (() => signUpController.validateBusinessInfo())),
                addVerticalSpace(90.h),
                Center(
                    child: Image.asset(
                  isDarkMode ? AppImages.sprout_dark : AppImages.sprout_light,
                  height: 27.h,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
