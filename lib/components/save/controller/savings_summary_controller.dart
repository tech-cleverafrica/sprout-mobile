import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/api-setup/api_setup.dart';
import 'package:sprout_mobile/api/api_response.dart';
import 'package:sprout_mobile/components/save/controller/create_savings_controller.dart';
import 'package:sprout_mobile/components/save/model/savings_summary_model.dart';
import 'package:sprout_mobile/components/save/service/savings_service.dart';
import 'package:sprout_mobile/components/save/view/savings_approval_screen.dart';
import 'package:sprout_mobile/public/widgets/custom_toast_notification.dart';
import 'package:sprout_mobile/utils/app_colors.dart';
import 'package:sprout_mobile/utils/app_formatter.dart';
import 'package:sprout_mobile/components/authentication/service/auth_service.dart';
import 'package:sprout_mobile/utils/nav_function.dart';

class SavingsSummaryController extends GetxController {
  late CreateSavingsController createSavingsController;
  final AppFormatter formatter = Get.put(AppFormatter());

  // arguments
  var args;
  var summary = Rxn<SavingsSummary>();

  RxBool loading = false.obs;
  RxBool isChecked = false.obs;

  @override
  void onInit() {
    createSavingsController = Get.put(CreateSavingsController());
    super.onInit();
    args = Get.arguments;
    summary.value = args;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future createSavings(Map<String, dynamic> requestBody) async {
    AppResponse<dynamic> response =
        await locator.get<SavingsService>().createSavings(requestBody);
    if (response.status) {
      pushUntil(
          page: SavingsApprovalScreen(
        message: "You have successfully saved money for " +
            createSavingsController.savingsNameController.text,
      ));
    } else if (response.statusCode == 999) {
      AppResponse res = await locator.get<AuthService>().refreshUserToken();
      if (res.status) {
        createSavings(requestBody);
      }
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  Future<dynamic> validateSavings() async {
    if (isChecked.value) {
      if (summary.value!.data!.type == "TARGET")
        createSavings(buildTargetSavingsRequestModel());
      else
        createSavings(buildLockedFundsRequestModel());
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please check the terms and condition"),
          backgroundColor: AppColors.errorRed));
    }
    return null;
  }

  buildTargetSavingsRequestModel() {
    return {
      "name": createSavingsController.savingsNameController.text,
      "savingsAmount":
          createSavingsController.targetAmountController.text.split(",").join(),
      "sourceType": createSavingsController.paymentType.value,
      "startDate": DateTime.now().toIso8601String().split("T")[0],
      "startingAmount": createSavingsController.startingAmountController.text
          .split(",")
          .join(),
      "debitFrequency": createSavingsController.frequency.value,
      "type": "TARGET",
      "cardToken": createSavingsController.paymentType.value == "WALLET"
          ? ""
          : createSavingsController.card.value!.token,
      "rollover": false,
    };
  }

  buildLockedFundsRequestModel() {
    return {
      "name": createSavingsController.savingsNameController.text,
      "savingsAmount": createSavingsController.savingsAmountController.text
          .split(",")
          .join(),
      "sourceType": createSavingsController.paymentType.value,
      "startDate": DateTime.now().toIso8601String().split("T")[0],
      "tenure": createSavingsController.tenure.value!.tenure,
      "type": "LOCKED",
      "cardToken": createSavingsController.paymentType.value == "WALLET"
          ? ""
          : createSavingsController.card.value!.token,
      "rollover": false,
    };
  }
}
