import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/api-setup/api_setup.dart';
import 'package:sprout_mobile/src/components/send-money/model/bank_beneficiary.dart';
import 'package:sprout_mobile/src/components/send-money/model/banks.dart';
import 'package:sprout_mobile/src/components/send-money/service/send_money_service.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

import '../../../api/api_response.dart';
import '../../../utils/app_colors.dart';

class SendMoneyController extends GetxController {
  RxList<BeneficiaryResponse> beneficiaryResponse = <BeneficiaryResponse>[].obs;
  RxList<Beneficiary> beneficiary = <Beneficiary>[].obs;
  RxBool isBeneficiaryLoading = false.obs;

  RxList<dynamic> bankList = [].obs;
  RxList<dynamic> bankCode = [].obs;

  TextEditingController bankController = new TextEditingController();
  TextEditingController accountNumberController = new TextEditingController();
  TextEditingController amountController = new TextEditingController();
  TextEditingController purposeController = new TextEditingController();

  RxString beneficiaryBank = "".obs;
  RxString beneficiaryAccountNumber = "".obs;
  RxString beneficiaryName = "".obs;
  RxBool showSaver = false.obs;
  RxBool save = false.obs;
  RxBool isNewTransfer = false.obs;

  @override
  void onInit() {
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
      banks.forEach((final String key, final String value) {
        bankList.add(value);
        bankCode.add(key);
        print(bankList);
      });
    }
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
