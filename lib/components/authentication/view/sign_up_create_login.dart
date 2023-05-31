import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/components/authentication/controller/signup_controller.dart';
import 'package:sprout_mobile/public/screens/contact_us.dart';
import 'package:sprout_mobile/public/widgets/custom_text_form_password_field.dart';
import 'package:sprout_mobile/public/widgets/general_widgets.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:email_validator/email_validator.dart';

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
                  'Create login details',
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
                          ? AppColors.white
                          : AppColors.inputLabelColor),
                ),
                addVerticalSpace(36.h),
                CustomTextFormField(
                  controller: signUpController.emailController,
                  label: "Email Address",
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                  hintText: "davejossy9@gmail.com",
                  textInputAction: TextInputAction.next,
                  validator: (value) => EmailValidator.validate(value ?? "")
                      ? null
                      : "Please enter a valid email",
                ),
                CustomTextFormField(
                  controller: signUpController.phoneController,
                  label: "Phone Number",
                  hintText: "Enter Phone Number",
                  maxLength: 11,
                  showCounterText: false,
                  maxLengthEnforced: true,
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*$'))
                  ],
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.phone,
                  validator: (value) {
                    if (value!.length == 0)
                      return "Phone number is required";
                    else if (value.length < 11)
                      return "Phone number should be 11 digits";
                    return null;
                  },
                ),
                CustomTextFormPasswordField(
                  controller: signUpController.passwordController,
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                  label: "Create password",
                  hintText: "********",
                  textInputAction: TextInputAction.next,
                ),
                addVerticalSpace(10.h),
                FlutterPwValidator(
                  controller: signUpController.passwordController,
                  minLength: 8,
                  uppercaseCharCount: 1,
                  numericCharCount: 1,
                  specialCharCount: 1,
                  normalCharCount: 3,
                  successColor:
                      isDarkMode ? AppColors.mainGreen : AppColors.primaryColor,
                  failureColor: AppColors.red,
                  width: MediaQuery.of(context).size.width * .6,
                  height: 150,
                  onSuccess: () {
                    signUpController.matched = true;
                  },
                  onFail: () {
                    signUpController.matched = false;
                  },
                ),
                addVerticalSpace(16.h),
                CustomTextFormPasswordField(
                  controller: signUpController.confirmPasswordController,
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                  label: "Confirm password",
                  hintText: "********",
                  validator: (value) {
                    if (value!.length == 0)
                      return "Confirm password is required";
                    else if (value != signUpController.passwordController.text)
                      return "Password does not match";
                    return null;
                  },
                  textInputAction: TextInputAction.go,
                ),
                addVerticalSpace(48.h),
                DecisionButton(
                    isDarkMode: isDarkMode,
                    buttonText: "Continue",
                    onTap: (() => signUpController.validateLoginDetails()))
              ],
            ),
          ),
        ),
      ),
    );
  }

  showPopUp(context, isDarkMode, theme) {
    showDialog(
      context: (context),
      builder: (BuildContext context) => ContactUs(
        heading: "Contact Customer Support",
        title: "0817-9435-965",
        phone: "+2348179435965",
      ),
    );
  }
}
