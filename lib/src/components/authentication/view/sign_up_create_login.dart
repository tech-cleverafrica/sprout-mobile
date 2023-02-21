import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/authentication/view/otp_screen.dart';
import 'package:sprout_mobile/src/public/widgets/custom_text_form_password_field.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../public/widgets/custom_button.dart';
import '../../../public/widgets/custom_text_form_field.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/helper_widgets.dart';

class SignUpCreateLogin extends StatefulWidget {
  SignUpCreateLogin({super.key});

  @override
  State<SignUpCreateLogin> createState() => _SignUpCreateLoginState();
}

class _SignUpCreateLoginState extends State<SignUpCreateLogin> {
  final TextEditingController controller = TextEditingController();

  bool success = false;

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
                StepProgressIndicator(
                  totalSteps: 4,
                  currentStep: 3,
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
                  'Create login details',
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
                  label: "Email Address",
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                ),
                CustomTextFormField(
                  label: "Phone Number",
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                ),
                CustomTextFormPasswordField(
                  controller: controller,
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                  label: "Create password",
                ),
                addVerticalSpace(10.h),
                FlutterPwValidator(
                  controller: controller,
                  minLength: 8,
                  uppercaseCharCount: 2,
                  numericCharCount: 3,
                  specialCharCount: 1,
                  normalCharCount: 3,
                  successColor:
                      isDarkMode ? AppColors.mainGreen : AppColors.primaryColor,
                  failureColor: AppColors.red,
                  width: MediaQuery.of(context).size.width * .6,
                  height: 150,
                  onSuccess: () {
                    setState(() {
                      success = true;
                    });
                    print("MATCHED");
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Password is good")));
                  },
                  onFail: () {
                    setState(() {
                      success = false;
                    });
                    print("NOT MATCHED");
                  },
                ),
                addVerticalSpace(16.h),
                CustomTextFormPasswordField(
                  // controller: controller,
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                  label: "Confirm password",
                ),
                addVerticalSpace(48.h),
                Row(
                  children: [
                    Container(
                      width: 246.w,
                      child: CustomButton(
                        title: "Continue",
                        onTap: () {
                          Get.to(() => OTPScreen());
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
