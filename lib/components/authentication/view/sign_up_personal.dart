import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/components/authentication/controller/signup_controller.dart';
import 'package:sprout_mobile/config/Config.dart';
import 'package:sprout_mobile/public/screens/contact_us.dart';

import 'package:sprout_mobile/public/widgets/custom_text_form_field.dart';
import 'package:sprout_mobile/public/widgets/general_widgets.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/helper_widgets.dart';

// ignore: must_be_immutable
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
          body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
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
                  InkWell(
                    onTap: () => Get.back(),
                    child: Container(
                      decoration: BoxDecoration(color: AppColors.transparent),
                      padding: EdgeInsets.only(right: 12, top: 6, bottom: 6),
                      child: Icon(
                        Icons.arrow_back,
                        size: 26,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showPopUp(context, isDarkMode, theme);
                    },
                    child: Image.asset(
                      AppImages.question,
                      height: 20,
                      color: isDarkMode ? AppColors.white : AppColors.black,
                    ),
                  )
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
                    fontFamily: "Mont",
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
                validator: (value) {
                  if (value!.length == 0)
                    return "First name is required";
                  else if (value.length < 2) return "First name is too short";
                  return null;
                },
                textInputAction: TextInputAction.next,
              ),
              CustomTextFormField(
                controller: signUpController.lastNameController,
                label: "Last name",
                hintText: "Enter your last name",
                fillColor: isDarkMode
                    ? AppColors.inputBackgroundColor
                    : AppColors.grey,
                validator: (value) {
                  if (value!.length == 0)
                    return "Last name is required";
                  else if (value.length < 2) return "Last name is too short";
                  return null;
                },
                textInputAction: TextInputAction.next,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      signUpController.showGenderList(context, isDarkMode);
                    },
                    child: Container(
                      width: 100.w,
                      child: CustomTextFormField(
                        controller: signUpController.genderController,
                        enabled: false,
                        fillColor: isDarkMode
                            ? AppColors.inputBackgroundColor
                            : AppColors.grey,
                        label: "Gender",
                        hintText: "Select Gender",
                        borderRadius: 14,
                        hasSuffixIcon: true,
                        suffixIcon: Icon(
                          Icons.arrow_drop_down,
                          size: 16,
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
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
                            textInputAction: TextInputAction.go,
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
                height: 24,
              )),
            ],
          ),
        ),
      )),
    );
  }

  showPopUp(context, isDarkMode, theme) {
    showDialog(
      context: (context),
      builder: (BuildContext context) => ContactUs(
        heading: APP_CUSTOMER_SUPPORT_HEADING,
        title: APP_CUSTOMER_SUPPORT_PHONE_NUMBER_TITLE,
        phone: APP_CUSTOMER_SUPPORT_PHONE_NUMBER,
      ),
    );
  }
}
