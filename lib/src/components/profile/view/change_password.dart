import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/profile/controller/change_password_controller.dart';
import 'package:sprout_mobile/src/public/widgets/custom_text_form_password_field.dart';

import '../../../public/widgets/custom_button.dart';
import '../../../public/widgets/general_widgets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/helper_widgets.dart';

// ignore: must_be_immutable
class ChangePassword extends StatelessWidget {
  ChangePassword({super.key});
  late ChangePasswordController changePasswordController;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    changePasswordController = Get.put(ChangePasswordController());
    return SafeArea(
      child: Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getHeader(isDarkMode),
                  addVerticalSpace(15.h),
                  CustomTextFormPasswordField(
                    controller:
                        changePasswordController.currentPasswordController,
                    label: "Enter Current Password",
                    fillColor: isDarkMode
                        ? AppColors.inputBackgroundColor
                        : AppColors.grey,
                  ),
                  CustomTextFormPasswordField(
                    controller: changePasswordController.newPasswordController,
                    fillColor: isDarkMode
                        ? AppColors.inputBackgroundColor
                        : AppColors.grey,
                    label: "Create password",
                  ),
                  addVerticalSpace(10.h),
                  FlutterPwValidator(
                    controller: changePasswordController.newPasswordController,
                    minLength: 8,
                    uppercaseCharCount: 1,
                    numericCharCount: 1,
                    specialCharCount: 1,
                    normalCharCount: 3,
                    successColor: isDarkMode
                        ? AppColors.mainGreen
                        : AppColors.primaryColor,
                    failureColor: AppColors.red,
                    width: MediaQuery.of(context).size.width * .6,
                    height: 150,
                    onSuccess: () {
                      changePasswordController.success.value = true;
                      print("MATCHED");
                    },
                    onFail: () {
                      changePasswordController.success.value = false;
                      print("NOT MATCHED");
                    },
                  ),
                  addVerticalSpace(16.h),
                  CustomTextFormPasswordField(
                    controller:
                        changePasswordController.confirmPasswordController,
                    fillColor: isDarkMode
                        ? AppColors.inputBackgroundColor
                        : AppColors.grey,
                    label: "Confirm password",
                    validator: (value) {
                      if (value!.length == 0)
                        return "Password cannot be empty";
                      else if (value !=
                          changePasswordController.newPasswordController.text)
                        return "Password does not match";
                      return null;
                    },
                  ),
                  addVerticalSpace(42.h),
                  CustomButton(
                    title: "Change Password",
                    onTap: () {
                      changePasswordController.validate();
                    },
                  )
                ],
              ),
            )),
      ),
    );
  }
}
