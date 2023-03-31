import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/Utilities/Validator.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/authentication/view/password_reset.dart';
import 'package:sprout_mobile/src/components/authentication/view/sign_in_screen.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

import '../../../api-setup/api_setup.dart';
import '../../../api/api_response.dart';
import '../../../public/widgets/custom_toast_notification.dart';
import '../../../utils/app_colors.dart';
import '../service/auth_service.dart';

class PasswordResetController extends GetxController {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  TextEditingController otpController = new TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  buildRequestModel(email) {
    return {"email": email};
  }

  buildResetRequestModel(newPassword, otp) {
    return {"newPassword": newPassword, "otp": otp};
  }

  validateEmail() {
    if (emailController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please supply a valid email"),
          backgroundColor: AppColors.errorRed));
    } else {
      sendResetOtp(buildRequestModel(emailController.text));
    }
  }

  validatePasswords() {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Passwords are not matching"),
          backgroundColor: AppColors.errorRed));
    } else if (passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty ||
        otpController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please supply all required inputs"),
          backgroundColor: AppColors.errorRed));
    } else {
      resetPassword(buildResetRequestModel(
          confirmPasswordController.text, otpController.text));
    }
  }

  sendResetOtp(Map<String, dynamic> request) async {
    AppResponse response = await locator
        .get<AuthService>()
        .confirmEmail(request, "Verifying email");
    if (response.status) {
      push(page: PasswordReset());
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  resetPassword(Map<String, dynamic> request) async {
    AppResponse response = await locator
        .get<AuthService>()
        .resetPassword(request, "Resetting password");
    if (response.status) {
      CustomToastNotification.show("Password reset successful, kindly login",
          type: ToastType.success);
      push(page: SignInScreen());
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
