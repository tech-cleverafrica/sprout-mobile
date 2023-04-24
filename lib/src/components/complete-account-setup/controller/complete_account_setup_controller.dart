import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sprout_mobile/src/api-setup/api_setup.dart';
import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/components/complete-account-setup/service/complete_account_setup_service.dart';
import 'package:sprout_mobile/src/components/authentication/service/auth_service.dart';
import 'package:sprout_mobile/src/public/screens/approval_page.dart';
import 'package:sprout_mobile/src/public/services/shared_service.dart';
import 'package:sprout_mobile/src/public/widgets/custom_toast_notification.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

class CompleteAccountSetupController extends GetxController {
  TextEditingController bvnController = new TextEditingController();
  final storage = GetStorage();
  String identityCardUrl = "";
  String utilityBillUrl = "";
  String? identityCardUploadError;
  String? utilityBillUploadError;
  bool loading = false;
  bool isIDValid = false;
  bool isUtilityValid = false;

  RxString uploadBillText = "Upload your preferred Utility Bill".obs;
  RxString uploadIdText = "Upload your preferred ID".obs;

  File? preferredID, utilityBill;

  @override
  void onInit() {
    super.onInit();
    preferredID = null;
    utilityBill = null;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  validate() {
    if (bvnController.text.isNotEmpty &&
        bvnController.text.length == 11 &&
        utilityBillUrl != "" &&
        identityCardUrl != "") {
      requestVerification(buildRequestModel(
          bvnController.text, utilityBillUrl, identityCardUrl));
    } else if (bvnController.text.length < 11) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("BVN must be 11 digits"),
          backgroundColor: AppColors.errorRed));
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("All fields are required"),
          backgroundColor: AppColors.errorRed));
    }
  }

  requestVerification(Map<String, dynamic> model) async {
    AppResponse response = await locator
        .get<CompleteAccountSetupService>()
        .requestVerification(model);
    if (response.status) {
      pushUntil(
          page: ApprovalScreen(
        containShare: false,
        heading: "Your information has been successfully submitted",
        messages: "You will be notified once your account is verified",
      ));
    } else if (response.statusCode == 999) {
      AppResponse res = await locator.get<AuthService>().refreshUserToken();
      if (res.status) {
        requestVerification(model);
      }
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  Future uploadAndCommit(File? image, String fileType) async {
    AppResponse response =
        await locator.get<SharedService>().uploadAndCommit(image, fileType);
    if (response.status) {
      if (fileType == "identityCard") {
        identityCardUrl = response.data["data"];
        // uploadingIdentityCard.value = false;
        uploadIdText.value = preferredID!.path;
        isIDValid = true;
      } else if (fileType == "utilityBill") {
        utilityBillUrl = response.data["data"];
        // uploadingUtilityBill.value = false;
        uploadBillText.value = utilityBill!.path;
        isUtilityValid = true;
      }
    } else if (response.statusCode == 999) {
      AppResponse res = await locator.get<AuthService>().refreshUserToken();
      if (res.status) {
        uploadAndCommit(image, fileType);
      }
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  void processIdUpload(File file) async {
    identityCardUploadError = null;
    String message = locator.get<SharedService>().validateFileSize(file, 5);
    if (message == "") {
      preferredID = file;
      // uploadingIdentityCard.value = true;
      uploadAndCommit(
        preferredID,
        "identityCard",
      );
    } else {
      identityCardUploadError = message;
      uploadIdText.value = identityCardUploadError!;
      isIDValid = false;
    }
  }

  void processUtilityUpload(File file) {
    utilityBillUploadError = null;
    String message = locator.get<SharedService>().validateFileSize(file, 5);
    if (message == "") {
      utilityBill = file;
      // uploadingUtilityBill.value = true;
      uploadAndCommit(
        utilityBill,
        "utilityBill",
      );
    } else {
      utilityBillUploadError = message;
      uploadBillText.value = utilityBillUploadError!;
      isUtilityValid = false;
    }
  }

  buildRequestModel(bvn, identityCard, utilityBill) {
    return {
      "bvn": bvn,
      "identityCard": identityCard,
      "utilityBill": utilityBill
    };
  }
}
