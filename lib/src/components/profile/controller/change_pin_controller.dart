import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sprout_mobile/src/api-setup/api_setup.dart';
import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/components/profile/service/profile_service.dart';
import 'package:sprout_mobile/src/components/profile/view/otp_screen.dart';
import 'package:sprout_mobile/src/public/screens/approval_page.dart';
import 'package:sprout_mobile/src/public/widgets/custom_toast_notification.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

class ChangePinController extends GetxController {
  final storage = GetStorage();
  final ScrollController scrollController = new ScrollController();
  final TextEditingController currentPinController =
      new TextEditingController();
  final TextEditingController newPinController = new TextEditingController();
  final TextEditingController confirmPinController =
      new TextEditingController();
  final TextEditingController otpController = new TextEditingController();

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
    if (currentPinController.text.isNotEmpty &&
        newPinController.text.isNotEmpty &&
        confirmPinController.text.isNotEmpty &&
        currentPinController.text.length == 4 &&
        newPinController.text.length == 4 &&
        confirmPinController.text.length == 4 &&
        newPinController.text == confirmPinController.text) {
      sendOtp(buildRequestModel());
    } else if (currentPinController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Current PIN cannot be empty"),
          backgroundColor: AppColors.errorRed));
    } else if (newPinController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("New PIN cannot be empty"),
          backgroundColor: AppColors.errorRed));
    } else if (confirmPinController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Confirm PIN cannot be empty"),
          backgroundColor: AppColors.errorRed));
    } else if (currentPinController.text.length < 4) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Current PIN must be 4 digits"),
          backgroundColor: AppColors.errorRed));
    } else if (newPinController.text.length < 4) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("New PIN must be 4 digits"),
          backgroundColor: AppColors.errorRed));
    } else if (confirmPinController.text.length < 4) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Confirm PIN must be 4 digits"),
          backgroundColor: AppColors.errorRed));
    } else if (newPinController.text != confirmPinController.text) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("PIN does not match"),
          backgroundColor: AppColors.errorRed));
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("All fields are required"),
          backgroundColor: AppColors.errorRed));
    }
    return null;
  }

  validateOtp() async {
    if (otpController.text.isNotEmpty && otpController.text.length == 6) {
      changePin(buildChangePinRequestModel());
    } else if (otpController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("OTP cannot be empty"),
          backgroundColor: AppColors.errorRed));
    } else if (otpController.text.length < 6) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("OTP must be 6 digits"),
          backgroundColor: AppColors.errorRed));
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("All fields are required"),
          backgroundColor: AppColors.errorRed));
    }
    return null;
  }

  sendOtp(Map<String, dynamic> model) async {
    AppResponse response =
        await locator.get<ProfileService>().sendOtp(model, "Please wait");
    if (response.status) {
      push(page: OtpScreen());
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  changePin(Map<String, dynamic> model) async {
    AppResponse response =
        await locator.get<ProfileService>().changePin(model, "Please wait");
    if (response.status) {
      pushUntil(
          page: ApprovalScreen(
        containShare: false,
        heading: "Good Job!",
        messages: "Your PIN has been changed Successfully",
      ));
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  buildRequestModel() {
    String email = storage.read("email");
    return {
      "email": email,
    };
  }

  buildChangePinRequestModel() {
    return {
      "pin": newPinController.text,
      "currentPin": currentPinController.text,
      "otp": otpController.text
    };
  }
}
