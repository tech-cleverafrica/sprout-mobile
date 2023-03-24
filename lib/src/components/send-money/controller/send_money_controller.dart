import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sprout_mobile/src/api-setup/api_setup.dart';
import 'package:sprout_mobile/src/components/send-money/model/bank_beneficiary.dart';
import 'package:sprout_mobile/src/components/send-money/service/send_money_service.dart';
import 'package:sprout_mobile/src/components/send-money/view/send_money_summary.dart';
import 'package:sprout_mobile/src/public/widgets/custom_text_form_field.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

import '../../../api/api_response.dart';
import '../../../public/widgets/custom_toast_notification.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_formatter.dart';

class SendMoneyController extends GetxController {
  RxList<BeneficiaryResponse> beneficiaryResponse = <BeneficiaryResponse>[].obs;
  RxList<Beneficiary> beneficiary = <Beneficiary>[].obs;
  RxList<Beneficiary> baseBeneficiary = <Beneficiary>[].obs;
  RxBool isBeneficiaryLoading = false.obs;
  RxBool canResolve = true.obs;
  RxBool isValidating = false.obs;
  RxBool showFields = false.obs;

  RxList<dynamic> bankList = [].obs;
  RxList<dynamic> baseBankList = [].obs;
  RxList<dynamic> bankCode = [].obs;
  RxString selectedBankCode = "".obs;
  RxString selectedUserName = "".obs;
  final storage = GetStorage();
  double? userBalance;

  TextEditingController bankController = new TextEditingController();
  TextEditingController accountNumberController = new TextEditingController();
  TextEditingController purposeController = new TextEditingController();
  TextEditingController nicknameController = new TextEditingController();

  RxString beneficiaryBank = "".obs;
  RxString beneficiaryAccountNumber = "".obs;
  RxString beneficiaryName = "".obs;
  RxString beneficiaryId = "".obs;
  final DateTime now = DateTime.now();
  String? transactionId;

  RxBool showSaver = false.obs;
  RxBool save = false.obs;
  RxBool isNewTransfer = true.obs;
  RxBool showBeneficiary = false.obs;

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
    isValidating.value = true;
    AppResponse response = await locator
        .get<SendMoneyService>()
        .validateBank(buildValidationModel(accountNumberController.text));
    canResolve.value = false;
    isValidating.value = false;
    if (response.status) {
      debugPrint("Hereeeeeeeeee!${json.encode(response.data)}");
      beneficiaryName.value =
          response.data['data']['account_name'].toString().trim();
      showBeneficiary.value = true;
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
      Beneficiary none = Beneficiary(
          id: "00",
          userID: "",
          nickname: "",
          beneficiaryBank: "New Beneficiary",
          beneficiaryName: "None",
          accountNumber: "");
      beneficiary.assignAll(beneficiaryResponse.data!);
      beneficiary.insert(0, none);
      baseBeneficiary.assignAll(beneficiary);
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
        baseBankList.add(value);
        bankCode.add(key);
        print(bankList);
      });
    }
  }

  filterBanks(String value) {
    bankList.value = value == ""
        ? baseBankList
        : baseBankList
            .where((i) => i!.toLowerCase().contains(value.toLowerCase()))
            .toList();
  }

  filterBeneficiaries(String value) {
    beneficiary.value = value == ""
        ? baseBeneficiary
        : baseBeneficiary
            .where((i) =>
                i.beneficiaryName!
                    .toLowerCase()
                    .contains(value.toLowerCase()) ||
                i.nickname!.toLowerCase().contains(value.toLowerCase()))
            .toList();
  }

  showBankList(context, isDarkMode) {
    return showModalBottomSheet(
        backgroundColor: AppColors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.6,
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Container(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 17.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 20.w),
                            child: Text(
                              "Select Bank",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: "DMSans",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: isDarkMode
                                      ? AppColors.mainGreen
                                      : AppColors.primaryColor),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: CustomTextFormField(
                              hasPrefixIcon: true,
                              prefixIcon: Icon(Icons.search_outlined),
                              hintText: "Search",
                              contentPaddingHorizontal: 10,
                              contentPaddingVertical: 8,
                              fillColor: isDarkMode
                                  ? AppColors.inputBackgroundColor
                                  : AppColors.grey,
                              onChanged: (value) => filterBanks(value),
                            ),
                          )
                        ]),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: bankList.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 20.w),
                              child: GestureDetector(
                                onTap: () {
                                  pop();
                                  beneficiaryBank.value = bankList[index];
                                  selectedBankCode.value = bankCode[
                                      bankList.indexOf(beneficiaryBank.value)];
                                  debugPrint(selectedBankCode.value);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: isDarkMode
                                          ? AppColors.inputBackgroundColor
                                          : AppColors.grey,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w, vertical: 16.h),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            bankList[index]!,
                                            style: TextStyle(
                                                fontFamily: "DMSans",
                                                fontSize: 12.sp,
                                                fontWeight: beneficiaryBank
                                                                .value !=
                                                            "" &&
                                                        beneficiaryBank.value ==
                                                            bankList[index]
                                                    ? FontWeight.w700
                                                    : FontWeight.w600,
                                                color: isDarkMode
                                                    ? AppColors.mainGreen
                                                    : AppColors.primaryColor),
                                          ),
                                          beneficiaryBank.value != "" &&
                                                  beneficiaryBank.value ==
                                                      bankList[index]
                                              ? SvgPicture.asset(
                                                  AppSvg.mark_green,
                                                  height: 20,
                                                  color: isDarkMode
                                                      ? AppColors.mainGreen
                                                      : AppColors.primaryColor,
                                                )
                                              : SizedBox()
                                        ],
                                      )),
                                ),
                              ),
                            );
                          }))),
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
            heightFactor: 0.6,
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Container(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 17.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 20.w),
                            child: Text(
                              "Select Beneficiary",
                              style: TextStyle(
                                  fontFamily: "DMSans",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: isDarkMode
                                      ? AppColors.mainGreen
                                      : AppColors.primaryColor),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: CustomTextFormField(
                              hasPrefixIcon: true,
                              prefixIcon: Icon(Icons.search_outlined),
                              hintText: "Search",
                              contentPaddingHorizontal: 10,
                              contentPaddingVertical: 8,
                              fillColor: isDarkMode
                                  ? AppColors.inputBackgroundColor
                                  : AppColors.grey,
                              onChanged: (value) => filterBeneficiaries(value),
                            ),
                          )
                        ]),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: beneficiary.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 20.w),
                              child: GestureDetector(
                                onTap: () {
                                  pop();
                                  showFields.value = true;
                                  if (beneficiary[index].id == "00") {
                                    showSaver.value = true;
                                    isNewTransfer.value = true;
                                    beneficiaryAccountNumber.value = "";
                                    beneficiaryName.value = "New Beneficiary";
                                    beneficiaryBank.value = "";
                                    beneficiaryId.value =
                                        beneficiary[index].id!;
                                    canResolve.value = true;
                                    accountNumberController.clear();
                                    showBeneficiary.value = false;
                                  } else {
                                    showSaver.value = false;
                                    isNewTransfer.value = false;
                                    selectedBankCode.value =
                                        beneficiary[index].id!;
                                    beneficiaryAccountNumber.value =
                                        beneficiary[index].accountNumber!;
                                    beneficiaryName.value =
                                        beneficiary[index].beneficiaryName!;
                                    beneficiaryBank.value =
                                        beneficiary[index].beneficiaryBank!;
                                    beneficiaryId.value =
                                        beneficiary[index].id!;
                                    showBeneficiary.value = true;
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: isDarkMode
                                          ? AppColors.inputBackgroundColor
                                          : AppColors.grey,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w, vertical: 16.h),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                beneficiary[index]
                                                    .beneficiaryName!,
                                                style: TextStyle(
                                                    fontFamily: "DMSans",
                                                    fontSize: 12.sp,
                                                    fontWeight: beneficiaryId
                                                                    .value !=
                                                                "" &&
                                                            beneficiaryId
                                                                    .value ==
                                                                beneficiary[
                                                                        index]
                                                                    .id
                                                        ? FontWeight.w700
                                                        : FontWeight.w600,
                                                    color: isDarkMode
                                                        ? AppColors.mainGreen
                                                        : AppColors
                                                            .primaryColor),
                                              ),
                                              Text(
                                                beneficiary[index]
                                                    .beneficiaryBank!,
                                                style: TextStyle(
                                                    fontFamily: "DMSans",
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: isDarkMode
                                                        ? AppColors.white
                                                        : AppColors.black),
                                              )
                                            ],
                                          ),
                                          beneficiaryId.value != "" &&
                                                  beneficiaryId.value ==
                                                      beneficiary[index].id
                                              ? SvgPicture.asset(
                                                  AppSvg.mark_green,
                                                  height: 20,
                                                  color: isDarkMode
                                                      ? AppColors.mainGreen
                                                      : AppColors.primaryColor,
                                                )
                                              : SizedBox()
                                        ],
                                      )),
                                ),
                              ),
                            );
                          })))
                ],
              )),
            ),
          );
        });
  }
}
