import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/profile/controller/change_pin_controller.dart';
import 'package:sprout_mobile/src/components/profile/controller/create_pin_controller.dart';
import 'package:sprout_mobile/src/public/widgets/custom_button.dart';
import 'package:sprout_mobile/src/public/widgets/custom_text_form_field.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';

import '../../../utils/app_colors.dart';

// ignore: must_be_immutable
class OtpScreen extends StatelessWidget {
  OtpScreen({super.key, required this.screen});

  String screen;

  late ChangePinController changePinController;
  late CreatePinController createPinController;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    changePinController = Get.put(ChangePinController());
    createPinController = Get.put(CreatePinController());

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getHeader(isDarkMode),
              addVerticalSpace(15.h),
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
                              text: "- " + screen == "CHANGE_PIN"
                                  ? changePinController.email
                                  : screen == "CREATE_PIN"
                                      ? createPinController.email
                                      : "",
                              style: TextStyle(
                                  fontFamily: "Mont",
                                  fontSize: 14.sp,
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
              CustomTextFormField(
                  controller: screen == "CHANGE_PIN"
                      ? changePinController.otpController
                      : createPinController.otpController,
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
                  if (screen == "CHANGE_PIN") {
                    changePinController.validateOtp();
                  } else if (screen == "CREATE_PIN") {
                    createPinController.validateOtp();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
