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

class CreatePinController extends GetxController {
  final storage = GetStorage();
  final TextEditingController pinController = new TextEditingController();
  final TextEditingController confirmPinController =
      new TextEditingController();
  final TextEditingController otpController = new TextEditingController();
  String email = "";

  @override
  void onInit() {
    super.onInit();
    email = storage.read("email");
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
    if (pinController.text.isNotEmpty &&
        confirmPinController.text.isNotEmpty &&
        pinController.text.length == 4 &&
        confirmPinController.text.length == 4 &&
        pinController.text == confirmPinController.text) {
      sendOtp(buildRequestModel());
    } else if (pinController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("New PIN cannot be empty"),
          backgroundColor: AppColors.errorRed));
    } else if (confirmPinController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Confirm PIN cannot be empty"),
          backgroundColor: AppColors.errorRed));
    } else if (pinController.text.length < 4) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("New PIN must be 4 digits"),
          backgroundColor: AppColors.errorRed));
    } else if (confirmPinController.text.length < 4) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Confirm PIN must be 4 digits"),
          backgroundColor: AppColors.errorRed));
    } else if (pinController.text != confirmPinController.text) {
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
      createPin(buildCreatePinRequestModel());
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
      push(
          page: OtpScreen(
        screen: "CREATE_PIN",
      ));
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  createPin(Map<String, dynamic> model) async {
    AppResponse response =
        await locator.get<ProfileService>().createPin(model, "Please wait");
    if (response.status) {
      pushUntil(
          page: ApprovalScreen(
        containShare: false,
        heading: "Good Job!",
        messages: "Your PIN has been created Successfully",
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

  buildCreatePinRequestModel() {
    return {"transactionPin": pinController.text, "otp": otpController.text};
  }
}
