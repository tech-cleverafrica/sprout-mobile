import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sprout_mobile/api-setup/api_setup.dart';
import 'package:sprout_mobile/api/api_response.dart';
import 'package:sprout_mobile/components/authentication/service/auth_service.dart';
import 'package:sprout_mobile/components/send-money/model/fx_rate.dart';
import 'package:sprout_mobile/components/send-money/service/send_money_service.dart';
import 'package:sprout_mobile/components/send-money/view/send-abroad/send_abroad_beneficiary.dart';
import 'package:sprout_mobile/components/send-money/view/send-abroad/send_abroad_summary.dart';
import 'package:sprout_mobile/config/Config.dart';
import 'package:sprout_mobile/public/widgets/custom_toast_notification.dart';
import 'package:sprout_mobile/utils/app_svgs.dart';
import 'package:sprout_mobile/utils/helper_widgets.dart';
import 'package:sprout_mobile/utils/nav_function.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_formatter.dart';

class SendAbroadController extends GetxController {
  final storage = GetStorage();
  final AppFormatter formatter = Get.put(AppFormatter());
  List<String> categories = ["Individual", "Business", "Education"];
  List<String> currencies = ["USD", "GBP", "EUR"];
  RxString category = "".obs;
  RxString destination = "".obs;
  RxString currency = "".obs;
  RxDouble rate = 0.0.obs;
  RxDouble beneficiaryValue = 0.0.obs;
  final DateTime now = DateTime.now();
  double? userBalance;

  TextEditingController categoryController = new TextEditingController();
  TextEditingController destinationController = new TextEditingController();
  TextEditingController beneficiaryFirstNameController =
      new TextEditingController();
  TextEditingController beneficiaryLastNameController =
      new TextEditingController();
  TextEditingController beneficiaryBankNameController =
      new TextEditingController();
  TextEditingController swiftOrBicCodeController = new TextEditingController();
  TextEditingController accountNumberController = new TextEditingController();

  late MoneyMaskedTextController amountToSendController =
      new MoneyMaskedTextController(
          initialValue: 0, decimalSeparator: ".", thousandSeparator: ",");
  var amountToReceiveController = Rxn<MoneyMaskedTextController>();

  RxList<FxRate> fxRate = <FxRate>[].obs;

  @override
  void onInit() {
    amountToReceiveController.value = new MoneyMaskedTextController(
        initialValue: 0, decimalSeparator: ".", thousandSeparator: ",");
    userBalance = storage.read("userBalance");
    getFxRates();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  getFxRates() async {
    AppResponse<List<FxRate>> response =
        await locator.get<SendMoneyService>().getFxRates();
    if (response.status) {
      var fxRates = response.data;
      fxRate.assignAll(fxRates);
    } else if (response.statusCode == 999) {
      AppResponse res = await locator.get<AuthService>().refreshUserToken();
      if (res.status) {
        getFxRates();
      }
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
      pop();
    }
  }

  validateFields() {
    if (category.value.isNotEmpty &&
        (double.parse(amountToSendController.text.split(",").join()) >=
                MINIMUM_TRANSFER_AMOUNT &&
            double.parse(amountToSendController.text.split(",").join()) <=
                MAXIMUM_TRANSFER_AMOUNT &&
            double.parse(amountToSendController.text.split(",").join()) <=
                double.parse(userBalance.toString().split(",").join())) &&
        destination.value.isNotEmpty) {
      push(page: SendAbroadBeneficiary());
    } else if (category.value.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please select a category"),
          backgroundColor: AppColors.errorRed));
    } else if (double.parse(amountToSendController.text.split(",").join("")) ==
        0) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please enter a valid amount"),
          backgroundColor: AppColors.errorRed));
    } else if (double.parse(amountToSendController.text.split(",").join("")) <
        MINIMUM_TRANSFER_AMOUNT) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Amount is too small"),
          backgroundColor: AppColors.errorRed));
    } else if (double.parse(amountToSendController.text.split(",").join()) >
        double.parse(userBalance.toString().split(",").join())) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Amount is greater than wallet balance"),
          backgroundColor: AppColors.errorRed));
    } else if (double.parse(amountToSendController.text.split(",").join("")) >
        MAXIMUM_TRANSFER_AMOUNT) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Maximum amount is $MAXIMUM_TRANSFER_AMOUNT"),
          backgroundColor: AppColors.errorRed));
    } else if (destination.value.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please select a destination"),
          backgroundColor: AppColors.errorRed));
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please supply all required fields"),
          backgroundColor: AppColors.errorRed));
    }
  }

  validateBeneficiaryFields() {
    if ((beneficiaryFirstNameController.text.isNotEmpty &&
            beneficiaryFirstNameController.text.length > 1) &&
        (beneficiaryLastNameController.text.isNotEmpty &&
            beneficiaryLastNameController.text.length > 1) &&
        (beneficiaryBankNameController.text.isNotEmpty &&
            beneficiaryBankNameController.text.length > 1) &&
        (swiftOrBicCodeController.text.isNotEmpty &&
            swiftOrBicCodeController.text.length > 1) &&
        (accountNumberController.text.isNotEmpty &&
            accountNumberController.text.length == 10)) {
      push(page: SendAbroadSummaryScreen());
    } else if (beneficiaryFirstNameController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Beneficiary First name is required"),
          backgroundColor: AppColors.errorRed));
    } else if (beneficiaryFirstNameController.text.length < 2) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Beneficiary First name is too short"),
          backgroundColor: AppColors.errorRed));
    } else if (beneficiaryLastNameController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Beneficiary Last name is required"),
          backgroundColor: AppColors.errorRed));
    } else if (beneficiaryLastNameController.text.length < 2) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Beneficiary Last name is too short"),
          backgroundColor: AppColors.errorRed));
    } else if (beneficiaryBankNameController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Beneficiary Bank name is required"),
          backgroundColor: AppColors.errorRed));
    } else if (beneficiaryBankNameController.text.length < 2) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Beneficiary Bank name is too short"),
          backgroundColor: AppColors.errorRed));
    } else if (swiftOrBicCodeController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("SWIFT/BIC Code is required"),
          backgroundColor: AppColors.errorRed));
    } else if (swiftOrBicCodeController.text.length < 2) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("SWIFT/BIC Code is too short"),
          backgroundColor: AppColors.errorRed));
    } else if (accountNumberController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("IBAN/Account number is required"),
          backgroundColor: AppColors.errorRed));
    } else if (accountNumberController.text.length < 10) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("IBAN/Account number should be 10 digits"),
          backgroundColor: AppColors.errorRed));
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please supply all required fields"),
          backgroundColor: AppColors.errorRed));
    }
  }

  String processCurrencyIcon() {
    String icon = "";
    switch (currency.value) {
      case "AUD":
        icon = AppSvg.usa;
        break;
      case "CAD":
        icon = AppSvg.usa;
        break;
      case "CHF":
        icon = AppSvg.usa;
        break;
      case "CNH":
        icon = AppSvg.usa;
        break;
      case "EUR":
        icon = AppSvg.eur;
        break;
      case "GBP":
        icon = AppSvg.gbp;
        break;
      case "HKD":
        icon = AppSvg.usa;
        break;
      case "JPY":
        icon = AppSvg.usa;
        break;
      case "NZD":
        icon = AppSvg.usa;
        break;
      case "SAR":
        icon = AppSvg.usa;
        break;
      default:
        icon = AppSvg.usa;
    }
    return icon;
  }

  computeBeneficiaryValue() {
    if (rate.value > 0) {
      beneficiaryValue.value =
          (amountToSendController.numberValue / rate.value);
      amountToReceiveController.value = new MoneyMaskedTextController(
          initialValue: beneficiaryValue.value,
          decimalSeparator: ".",
          thousandSeparator: ",");
    }
  }

  Future<dynamic> makeFxTransfer(pin) async {
    AppResponse response = await locator
        .get<SendMoneyService>()
        .makeFxTransfer(buildTransferModel(pin));
    if (response.status) {
      return true;
    } else if (response.statusCode == 999) {
      AppResponse res = await locator.get<AuthService>().refreshUserToken();
      if (res.status) {
        makeFxTransfer(pin);
      }
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
    return false;
  }

  buildTransferModel(String pin) {
    return {
      "beneficiaryFirstName": beneficiaryFirstNameController.text,
      "beneficiaryLastName": beneficiaryLastNameController.text,
      "beneficiaryBankName": beneficiaryBankNameController.text,
      "swiftCode": swiftOrBicCodeController.text,
      "iban": accountNumberController.text,
      "category": category.value,
      "amount": amountToSendController.numberValue,
      "fromCurrency": "NGN",
      "toCurrency": currency.value,
      "transactionPin": pin,
    };
  }

  showCategoryList(context, isDarkMode) {
    return showModalBottomSheet(
        backgroundColor: AppColors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.4,
            child: Container(
              decoration: BoxDecoration(
                  color: isDarkMode ? AppColors.greyDot : AppColors.white,
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
                              "Select Category",
                              style: TextStyle(
                                  fontFamily: "Mont",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: isDarkMode
                                      ? AppColors.mainGreen
                                      : AppColors.primaryColor),
                            ),
                          ),
                        ]),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: categories.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 20.w),
                              child: GestureDetector(
                                onTap: () {
                                  category.value = categories[index];
                                  pop();
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
                                                categories[index],
                                                style: TextStyle(
                                                    fontFamily: "Mont",
                                                    fontSize: 12.sp,
                                                    fontWeight: category
                                                                    .value !=
                                                                "" &&
                                                            category.value ==
                                                                categories[
                                                                    index]
                                                        ? FontWeight.w700
                                                        : FontWeight.w600,
                                                    color: isDarkMode
                                                        ? AppColors.mainGreen
                                                        : AppColors
                                                            .primaryColor),
                                              ),
                                            ],
                                          ),
                                          category.value != "" &&
                                                  category.value ==
                                                      categories[index]
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

  showDestinationList(context, isDarkMode) {
    return showModalBottomSheet(
        backgroundColor: AppColors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.5,
            child: Container(
              decoration: BoxDecoration(
                  color: isDarkMode ? AppColors.greyDot : AppColors.white,
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
                              "Select Destination",
                              style: TextStyle(
                                  fontFamily: "Mont",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: isDarkMode
                                      ? AppColors.mainGreen
                                      : AppColors.primaryColor),
                            ),
                          ),
                        ]),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: fxRate.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 20.w),
                              child: GestureDetector(
                                onTap: () {
                                  destination.value =
                                      fxRate[index].countryName!;
                                  currency.value = fxRate[index].currency!;
                                  rate.value = fxRate[index].rate!;
                                  processCurrencyIcon();
                                  computeBeneficiaryValue();
                                  pop();
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
                                                fxRate[index].countryName!,
                                                style: TextStyle(
                                                    fontFamily: "Mont",
                                                    fontSize: 12.sp,
                                                    fontWeight: destination
                                                                    .value !=
                                                                "" &&
                                                            destination.value ==
                                                                fxRate[index]
                                                                    .countryName!
                                                        ? FontWeight.w700
                                                        : FontWeight.w600,
                                                    color: isDarkMode
                                                        ? AppColors.mainGreen
                                                        : AppColors
                                                            .primaryColor),
                                              ),
                                            ],
                                          ),
                                          destination.value != "" &&
                                                  destination.value ==
                                                      fxRate[index].countryName!
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

  showCurrencyList(context, isDarkMode) {
    return showModalBottomSheet(
        backgroundColor: AppColors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.5,
            child: Container(
              decoration: BoxDecoration(
                  color: isDarkMode ? AppColors.greyDot : AppColors.white,
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
                              "Select Currency",
                              style: TextStyle(
                                  fontFamily: "Mont",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: isDarkMode
                                      ? AppColors.mainGreen
                                      : AppColors.primaryColor),
                            ),
                          ),
                        ]),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: currencies.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 20.w),
                              child: GestureDetector(
                                onTap: () {
                                  currency.value = currencies[index];
                                  pop();
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
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              ClipRRect(
                                                child: SvgPicture.asset(
                                                  currencies[index] == "USD"
                                                      ? AppSvg.usa
                                                      : currencies[index] ==
                                                              "GBP"
                                                          ? AppSvg.gbp
                                                          : AppSvg.eur,
                                                  height: 20,
                                                  width: 20,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              addHorizontalSpace(10.w),
                                              Text(
                                                currencies[index],
                                                style: TextStyle(
                                                    fontFamily: "Mont",
                                                    fontSize: 12.sp,
                                                    fontWeight: currency
                                                                    .value !=
                                                                "" &&
                                                            currency.value ==
                                                                currencies[
                                                                    index]
                                                        ? FontWeight.w700
                                                        : FontWeight.w600,
                                                    color: isDarkMode
                                                        ? AppColors.mainGreen
                                                        : AppColors
                                                            .primaryColor),
                                              ),
                                            ],
                                          ),
                                          currency.value != "" &&
                                                  currency.value ==
                                                      currencies[index]
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
