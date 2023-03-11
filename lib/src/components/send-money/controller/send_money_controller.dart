import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sprout_mobile/src/api-setup/api_setup.dart';
import 'package:sprout_mobile/src/components/send-money/model/bank_beneficiary.dart';
import 'package:sprout_mobile/src/components/send-money/service/send_money_service.dart';
import 'package:sprout_mobile/src/components/send-money/view/send_money_summary.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

import '../../../api/api_response.dart';
import '../../../public/widgets/custom_toast_notification.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_formatter.dart';

class SendMoneyController extends GetxController {
  RxList<BeneficiaryResponse> beneficiaryResponse = <BeneficiaryResponse>[].obs;
  RxList<Beneficiary> beneficiary = <Beneficiary>[].obs;
  RxBool isBeneficiaryLoading = false.obs;

  RxList<dynamic> bankList = [].obs;
  RxList<dynamic> bankCode = [].obs;
  RxString selectedBankCode = "".obs;
  RxString selectedUserName = "".obs;
  final storage = GetStorage();
  double? userBalance;

  TextEditingController bankController = new TextEditingController();
  TextEditingController accountNumberController = new TextEditingController();
  TextEditingController purposeController = new TextEditingController();

  RxString beneficiaryBank = "".obs;
  RxString beneficiaryAccountNumber = "".obs;
  RxString beneficiaryName = "".obs;
  final DateTime now = DateTime.now();
  String? transactionId;

  RxBool showSaver = false.obs;
  RxBool save = false.obs;
  RxBool isNewTransfer = false.obs;

  final AppFormatter formatter = Get.put(AppFormatter());
  late MoneyMaskedTextController amountController =
      new MoneyMaskedTextController(
          initialValue: 0, decimalSeparator: ".", thousandSeparator: ",");

  @override
  void onInit() {
    userBalance = storage.read("userBalance");
    transactionId = now.year.toString() +
        now.month.toString() +
        now.day.toString() +
        now.hour.toString() +
        now.minute.toString() +
        now.second.toString();
    loadBeneficiary();
    getBanks();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  toggleSaver() {
    save.value = !save.value;
  }

  buildValidationModel(String accountNumber) {
    return {
      "accountNumber": accountNumber,
      "bankCode": selectedBankCode.value,
      "currency": "NGN"
    };
  }

  buildTransferModel(String pin) {
    return {
      "accountNumber": accountNumberController.text.isEmpty
          ? beneficiaryAccountNumber.value
          : accountNumberController.text,
      "amount": amountController.text,
      "bankCode": selectedBankCode.value,
      "beneficiaryBankName": beneficiaryBank.value,
      "beneficiaryName": beneficiaryName.value,
      "currency": "NGN",
      "narration": purposeController.text,
      "senderName": storage.read("firstname") + storage.read("lastname"),
      "transactionId": transactionId,
      "transactionPin": pin,
      "userId": storage.read("userId")
    };
  }

  makeTransafer(pin) async {
    AppResponse response = await locator
        .get<SendMoneyService>()
        .makeTransfer(buildTransferModel(pin), "Process transfer");
    if (response.status) {
      debugPrint("Hereeeeeeeeee!${json.encode(response.data)}");
      beneficiaryName.value =
          json.encode(response.data['data']['account_name'].toString().trim());
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  validateFields() {
    print(beneficiaryName.value +
        beneficiaryBank.value +
        accountNumberController.text +
        beneficiaryAccountNumber.value +
        amountController.text);
    if (beneficiaryName.value.isEmpty ||
        beneficiaryBank.value.isEmpty ||
        accountNumberController.text.isEmpty &&
            beneficiaryAccountNumber.value.isEmpty ||
        amountController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please supply all required fields"),
          backgroundColor: AppColors.errorRed));
    } else {
      push(
          page: SendMoneySummaryScreen(
              source: beneficiaryBank.value,
              name: beneficiaryName.value,
              number: accountNumberController.text.isEmpty
                  ? beneficiaryAccountNumber.value
                  : accountNumberController.text,
              amount: amountController.numberValue));
    }
  }

  validateBank() async {
    AppResponse response = await locator.get<SendMoneyService>().validateBank(
        buildValidationModel(accountNumberController.text),
        "Validating account...");
    if (response.status) {
      debugPrint("Hereeeeeeeeee!${json.encode(response.data)}");
      beneficiaryName.value =
          json.encode(response.data['data']['account_name'].toString().trim());
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  loadBeneficiary() async {
    isBeneficiaryLoading.value = true;
    AppResponse<List<Beneficiary>> beneficiaryResponse =
        await locator.get<SendMoneyService>().getBeneficiary();
    isBeneficiaryLoading.value = false;

    if (beneficiaryResponse.status) {
      beneficiary.assignAll(beneficiaryResponse.data!);
      print(beneficiaryResponse);
    }
  }

  getBanks() async {
    AppResponse<dynamic> bankresponse =
        await locator.get<SendMoneyService>().getBanks();
    if (bankresponse.status) {
      print(bankresponse.data["data"]);
      var banks = bankresponse.data["data"];
      banks.forEach((final String key, final value) {
        bankList.add(value);
        bankCode.add(key);
        print(bankList);
      });
    }
  }

  showBankList(context, isDarkMode) {
    return showModalBottomSheet(
        backgroundColor: AppColors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.5,
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: SingleChildScrollView(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 17.h,
                  ),
                  ListView.builder(
                      itemCount: bankList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 20.w),
                          child: GestureDetector(
                            onTap: () {
                              pop();
                              beneficiaryBank.value = bankList.value[index];
                              selectedBankCode.value = bankCode.value[
                                  bankList.indexOf(beneficiaryBank.value)];
                              debugPrint(selectedBankCode.value);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: isDarkMode
                                      ? AppColors.inputBackgroundColor
                                      : AppColors.grey,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.w, vertical: 10.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      bankList.value[index]!,
                                      style: TextStyle(
                                          fontFamily: "DMSans",
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w700,
                                          color: isDarkMode
                                              ? AppColors.mainGreen
                                              : AppColors.primaryColor),
                                    ),
                                    // Text(
                                    //   beneficiary.value[index].beneficiaryBank!,
                                    //   style: TextStyle(
                                    //       fontFamily: "DMSans",
                                    //       fontSize: 12.sp,
                                    //       fontWeight: FontWeight.w500,
                                    //       color: isDarkMode
                                    //           ? AppColors.white
                                    //           : AppColors.black),
                                    // )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }))
                ],
              )),
            ),
          );
        });
  }

  showBeneficiaryList(context, isDarkMode) {
    return showModalBottomSheet(
        backgroundColor: AppColors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.5,
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: SingleChildScrollView(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 17.h,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                    child: GestureDetector(
                      onTap: () {
                        pop();
                        showSaver.value = true;
                        isNewTransfer.value = true;
                        beneficiaryAccountNumber.value = "";
                        beneficiaryName.value = "New Beneficiary";
                        beneficiaryBank.value = "";
                        accountNumberController.clear();
                      },
                      child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? AppColors.inputBackgroundColor
                                : AppColors.grey,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.w, vertical: 10.h),
                            child: Text(
                              "None",
                              style: TextStyle(
                                  fontFamily: "DMSans",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: isDarkMode
                                      ? AppColors.mainGreen
                                      : AppColors.primaryColor),
                            ),
                          )),
                    ),
                  ),
                  ListView.builder(
                      itemCount: beneficiary.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 20.w),
                          child: GestureDetector(
                            onTap: () {
                              pop();
                              showSaver.value = false;
                              isNewTransfer.value = false;
                              selectedBankCode.value =
                                  beneficiary.value[index].id!;
                              beneficiaryAccountNumber.value =
                                  beneficiary.value[index].accountNumber!;
                              beneficiaryName.value =
                                  beneficiary.value[index].beneficiaryName!;
                              beneficiaryBank.value =
                                  beneficiary.value[index].beneficiaryBank!;
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: isDarkMode
                                      ? AppColors.inputBackgroundColor
                                      : AppColors.grey,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.w, vertical: 10.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      beneficiary.value[index].beneficiaryName!,
                                      style: TextStyle(
                                          fontFamily: "DMSans",
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w700,
                                          color: isDarkMode
                                              ? AppColors.mainGreen
                                              : AppColors.primaryColor),
                                    ),
                                    Text(
                                      beneficiary.value[index].beneficiaryBank!,
                                      style: TextStyle(
                                          fontFamily: "DMSans",
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: isDarkMode
                                              ? AppColors.white
                                              : AppColors.black),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }))
                ],
              )),
            ),
          );
        });
  }
}
