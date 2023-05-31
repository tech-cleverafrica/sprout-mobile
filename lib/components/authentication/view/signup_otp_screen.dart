import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/components/authentication/controller/signup_controller.dart';
import 'package:sprout_mobile/public/screens/contact_us.dart';
import 'package:sprout_mobile/public/widgets/custom_button.dart';
import 'package:sprout_mobile/public/widgets/custom_text_form_field.dart';
import 'package:sprout_mobile/utils/app_images.dart';
import 'package:sprout_mobile/utils/helper_widgets.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../utils/app_colors.dart';

// ignore: must_be_immutable
class SignupOtpScreen extends StatelessWidget {
  SignupOtpScreen({super.key});

  late SignUpController signUpController;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    signUpController = Get.put(SignUpController());

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StepProgressIndicator(
                    totalSteps: 4,
                    currentStep: 4,
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
                          decoration:
                              BoxDecoration(color: AppColors.transparent),
                          padding:
                              EdgeInsets.only(right: 12, top: 6, bottom: 6),
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
                ],
              ),
              addVerticalSpace(20.h),
              Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  "Please enter the OTP sent to your registered email address ",
                              style: TextStyle(
                                  fontFamily: "Mont",
                                  fontSize: 12.sp,
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            TextSpan(
                              text: "- " + signUpController.email,
                              style: TextStyle(
                                  fontFamily: "Mont",
                                  fontSize: 12.sp,
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
              CustomTextFormField(
                  controller: signUpController.otpController,
                  label: "",
                  maxLength: 6,
                  maxLengthEnforced: true,
                  textInputAction: TextInputAction.next,
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                  textInputType: TextInputType.phone,
                  showCounterText: false,
                  validator: (value) {
                    if (value!.length == 0)
                      return "OTP cannot be empty";
                    else if (value.length < 6) return "OTP must be 6 digits";
                    return null;
                  },
                  hintTextStyle: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    fontFamily: "Mont",
                    letterSpacing: 20,
                  ),
                  contentPaddingHorizontal: 12,
                  contentPaddingVertical: 18,
                  textFormFieldStyle: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    fontFamily: "Mont",
                    letterSpacing: 20,
                  ),
                  textAlign: TextAlign.center,
                  autofocus: true),
              addVerticalSpace(42.h),
              CustomButton(
                title: "Submit",
                onTap: () {
                  signUpController.createUser();
                },
              )
            ],
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
