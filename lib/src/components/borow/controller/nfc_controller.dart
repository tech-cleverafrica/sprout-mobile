import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sprout_mobile/src/api-setup/api_setup.dart';
import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/components/authentication/service/auth_service.dart';
import 'package:sprout_mobile/src/components/borow/service/borrow_service.dart';
import 'package:sprout_mobile/src/public/screens/approval_page.dart';
import 'package:sprout_mobile/src/public/widgets/custom_toast_notification.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/app_formatter.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

class NfcController extends GetxController {
  MoneyMaskedTextController amountController = new MoneyMaskedTextController(
      initialValue: 0, decimalSeparator: ".", thousandSeparator: ",");
  final AppFormatter formatter = Get.put(AppFormatter());
  final storage = GetStorage();
  String bankTID = "";
  String businessName = "";
  String businessAddress = "";
  String customerName = "";
  String amountToSend = "";

  @override
  void onInit() {
    super.onInit();
    bankTID = storage.read("bankTID");
    businessName = storage.read("businessName");
    businessAddress = storage.read("address");
    customerName = storage.read("firstname") + " " + storage.read("lastname");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future getUserInfo() async {
    AppResponse response = await locator.get<AuthService>().getUserDetails();
    if (response.status) {
      bankTID = storage.read("bankTID");
    }
  }

  Future requestTerminalId() async {
    AppResponse response = await locator.get<AuthService>().getUserDetails();
    if (response.status) {
      bankTID = storage.read("bankTID");
    }
  }

  Future<dynamic> validate() async {
    List breaks = amountController.text.split(".");
    String formartedAmount = amountController.text.split(".")[0];
    String nextAmount =
        breaks.length > 1 ? amountController.text.split(".")[1] : "00";
    String amountString = formartedAmount.split(",").join("");
    int amount = int.parse(amountString);
    int intNextAmount = int.parse(nextAmount);
    amountToSend = amountString + nextAmount;
    if (amount != 0) {
      return initiateCardlessPayment(
          buildRequestModel(amountString + nextAmount));
    } else if (amount == 0 && intNextAmount > 0) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Amount cannot be less than 0"),
          backgroundColor: AppColors.errorRed));
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Amount is required"),
          backgroundColor: AppColors.errorRed));
    }
    return null;
  }

  validateNext(String model) async {
    saveCardlessPayment(buildSaveRequestModel(model));
  }

  Future<dynamic> initiateCardlessPayment(Map<String, dynamic> model) async {
    AppResponse response =
        await locator.get<BorrowService>().initiateCardlessPayment(model);
    if (response.status) {
      return response.data["data"];
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
      return null;
    }
  }

  saveCardlessPayment(Map<String, dynamic> model) async {
    AppResponse response =
        await locator.get<BorrowService>().saveCardlessPayment(model);
    if (response.status) {
      pushUntil(
          page: ApprovalScreen(
        containShare: true,
        heading: "Good Job!",
        messages: "Cash Withdrawal Successful",
      ));
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  buildRequestModel(amount) {
    return {
      "amount": amount,
      "bankTid": bankTID,
    };
  }

  buildSaveRequestModel(model) {
    var data = jsonDecode(model);
    return {
      "stan": data['STAN'],
      "accountType": data['accountType'],
      "acquiringInstCode": data['acquiringInstCode'],
      "amount": data['amount'],
      "authCode": data['authCode'],
      "cardExpiry": data['cardExpiry'],
      "cardHolder": data['cardHolder'],
      "netPosId": data['id'],
      "maskedPan": data['maskedPan'],
      "merchantId": data['merchantId'],
      "originalForwardingInstCode": data['originalForwardingInstCode'],
      "remark": data['remark'],
      "responseCode": data['responseCode'],
      "responseMessage": data['responseMessage'],
      "rrn": data['rrn'],
      "terminalId": data['terminalId'],
      "transactionTimeInMillis": data['transactionTimeInMillis'],
      "transactionType": data['transactionType'],
      "transmissionDateTime": data['transmissionDateTime'],
    };
  }
}
