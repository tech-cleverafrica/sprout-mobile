import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/authentication/controller/password_reset_controller.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/validators.dart';

import '../../../public/widgets/custom_text_form_field.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/helper_widgets.dart';

// ignore: must_be_immutable
class EmailConfirmation extends StatelessWidget {
  String? process;
  EmailConfirmation({super.key, required this.process});

  late PasswordResetController passwordResetController;

  @override
  Widget build(BuildContext context) {
    passwordResetController = Get.put(PasswordResetController());
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addVerticalSpace(10.h),
                Center(
                    child: Image.asset(
                  isDarkMode ? AppImages.sprout_dark : AppImages.sprout_light,
                  height: 27.h,
                )),
                SizedBox(
                  height: 24.h,
                ),
                Text(
                  "Reset Password",
                  style: TextStyle(
                      fontFamily: "Mont",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w400,
                      color:
                          isDarkMode ? AppColors.white : AppColors.boxesColor),
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomTextFormField(
                  controller: passwordResetController.emailController,
                  label: "Enter Email Address",
                  hintText: "Your Email",
                  onChanged: (value) {
                    Validators.emptyFieldValidator(value);
                  },
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                ),
                addVerticalSpace(40.h),
                DecisionButton(
                    isDarkMode: isDarkMode,
                    buttonText: "Proceed",
                    onTap: () {
                      passwordResetController.validateEmail();
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
