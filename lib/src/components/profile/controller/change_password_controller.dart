import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sprout_mobile/src/api-setup/api_setup.dart';
import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/components/profile/service/profile_service.dart';
import 'package:sprout_mobile/src/public/screens/approval_page.dart';
import 'package:sprout_mobile/src/public/widgets/custom_toast_notification.dart';
import 'package:sprout_mobile/src/components/authentication/service/auth_service.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

class ChangePasswordController extends GetxController {
  final storage = GetStorage();
  final TextEditingController currentPasswordController =
      new TextEditingController();
  final TextEditingController newPasswordController =
      new TextEditingController();
  final TextEditingController confirmPasswordController =
      new TextEditingController();
  final TextEditingController otpController = new TextEditingController();
  RxBool success = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  validate() async {
    if (currentPasswordController.text.isNotEmpty &&
        newPasswordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        success.value &&
        newPasswordController.text == confirmPasswordController.text) {
      changePassword(buildRequestModel());
    } else if (currentPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Current password cannot be empty"),
          backgroundColor: AppColors.errorRed));
    } else if (newPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Password cannot be empty"),
          backgroundColor: AppColors.errorRed));
    } else if (confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Confirm password cannot be empty"),
          backgroundColor: AppColors.errorRed));
    } else if (!success.value) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Invalid password"),
          backgroundColor: AppColors.errorRed));
    } else if (newPasswordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Password does not match"),
          backgroundColor: AppColors.errorRed));
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("All fields are required"),
          backgroundColor: AppColors.errorRed));
    }
    return null;
  }

  changePassword(Map<String, dynamic> model) async {
    AppResponse response =
        await locator.get<ProfileService>().changePassword(model);
    if (response.status) {
      pushUntil(
          page: ApprovalScreen(
        containShare: false,
        heading: "Good Job!",
        messages: "Password changed Successfully",
      ));
    } else if (response.statusCode == 999) {
      AppResponse res = await locator.get<AuthService>().refreshUserToken();
      if (res.status) {
        changePassword(model);
      }
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  buildRequestModel() {
    return {
      "currentPassword": currentPasswordController.text,
      "newPassword": newPasswordController.text,
    };
  }
}
