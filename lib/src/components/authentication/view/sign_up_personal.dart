import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/authentication/controller/signup_controller.dart';

import 'package:sprout_mobile/src/public/widgets/custom_text_form_field.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../public/widgets/custom_dropdown_button_field.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/helper_widgets.dart';

class SignupPersonalScreen extends StatelessWidget {
  SignupPersonalScreen({super.key});

  late SignUpController signUpController;

  @override
  Widget build(BuildContext context) {
    signUpController = Get.put(SignUpController());
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
              StepProgressIndicator(
                totalSteps: 4,
                currentStep: 1,
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
                'Personal Details',
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
                        ? AppColors.semi_white
                        : AppColors.inputLabelColor),
              ),
              addVerticalSpace(36.h),
              CustomTextFormField(
                controller: signUpController.firstnameController,
                label: "First name",
                hintText: "Enter your first name",
                fillColor: isDarkMode
                    ? AppColors.inputBackgroundColor
                    : AppColors.grey,
              ),
              CustomTextFormField(
                controller: signUpController.lastNameController,
                label: "Last name",
                hintText: "Enter your last name",
                fillColor: isDarkMode
                    ? AppColors.inputBackgroundColor
                    : AppColors.grey,
              ),
              Row(
                children: [
                  Container(
                    width: 100.w,
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
                      child: InkWell(
                    onTap: () => signUpController.selectDob(),
                    child: Obx(
                      (() => CustomTextFormField(
                            controller: signUpController.dateOfBirthController,
                            label: "D.O.B",
                            enabled: false,
                            hintText: signUpController.birthDate.value,
                            fillColor: isDarkMode
                                ? AppColors.inputBackgroundColor
                                : AppColors.grey,
                          )),
                    ),
                  ))
                ],
              ),
              addVerticalSpace(48.h),
              DecisionButton(
                  isDarkMode: isDarkMode,
                  buttonText: "Continue",
                  onTap: (() => signUpController.validatePersonalDetails())),
              addVerticalSpace(152.h),
              Center(
                  child: Image.asset(
                isDarkMode ? AppImages.sprout_dark : AppImages.sprout_light,
                height: 40,
              )),
            ],
          ),
        ),
      )),
    );
  }
}
