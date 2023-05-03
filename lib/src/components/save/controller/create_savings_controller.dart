import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterwave_standard/core/flutterwave.dart';
import 'package:flutterwave_standard/models/requests/customer.dart';
import 'package:flutterwave_standard/models/requests/customizations.dart';
import 'package:flutterwave_standard/models/responses/charge_response.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sprout_mobile/src/api-setup/api_setup.dart';
import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/components/fund-wallet/model/customer_card_model.dart';
import 'package:sprout_mobile/src/components/fund-wallet/service/fund_wallet_service.dart';
import 'package:sprout_mobile/src/components/save/model/savings_summary_model.dart';
import 'package:sprout_mobile/src/components/save/service/savings_service.dart';
import 'package:sprout_mobile/src/components/save/view/savings_summary.dart';
import 'package:sprout_mobile/src/environment.dart';
import 'package:sprout_mobile/src/public/widgets/custom_loader.dart';
import 'package:sprout_mobile/src/public/widgets/custom_toast_notification.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/app_formatter.dart';
import 'package:sprout_mobile/src/components/authentication/service/auth_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

class CreateSavingsController extends GetxController {
  final storage = GetStorage();
  final AppFormatter formatter = Get.put(AppFormatter());
  TextEditingController savingsNameController = new TextEditingController();
  late MoneyMaskedTextController targetAmountController =
      new MoneyMaskedTextController(
          initialValue: 0, decimalSeparator: ".", thousandSeparator: ",");
  late MoneyMaskedTextController startingAmountController =
      new MoneyMaskedTextController(
          initialValue: 0, decimalSeparator: ".", thousandSeparator: ",");
  late MoneyMaskedTextController savingsAmountController =
      new MoneyMaskedTextController(
          initialValue: 0, decimalSeparator: ".", thousandSeparator: ",");
  TextEditingController paymentTypeController = new TextEditingController();
  TextEditingController frequencyController = new TextEditingController();
  TextEditingController tenureController = new TextEditingController();
  TextEditingController cardController = new TextEditingController();

  RxList<String> frequencies = <String>['DAILY', 'WEEKLY', 'MONTHLY'].obs;
  RxString frequency = "".obs;
  RxList<String> paymentTypes = <String>['WALLET', 'CARD'].obs;
  RxString paymentType = "".obs;
  RxList<dynamic> tenures = <dynamic>[
    {"name": '30 days', "value": 30},
    {"name": '60 days', "value": 60},
    {"name": '90 days', "value": 90},
    {"name": '180 days', "value": 180},
    {"name": '270 days', "value": 270},
    {"name": '360 days', "value": 360},
  ].obs;
  var tenure = Rxn<dynamic>();
  RxList<CustomerCard> cards = <CustomerCard>[].obs;
  var card = Rxn<CustomerCard>();
  var cardData;
  String transactionRef = "";

  @override
  void onInit() {
    storage.remove("removeAll");
    getCards();
    super.onInit();
  }

  getCards() async {
    CustomLoader.show();
    AppResponse<List<CustomerCard>> response =
        await locator.get<FundWalletService>().getCards();
    CustomLoader.dismiss();
    if (response.status) {
      cards.clear();
      CustomerCard none = CustomerCard(
        id: "00",
        userID: "",
        agentID: "",
        pan: "Use New Card",
        cardHash: "",
        expiryMonth: "",
        expiryYear: "",
        issuingCountry: "",
        token: "",
        scheme: "",
        status: "",
        provider: "",
        createdAt: "",
        updatedAt: "",
      );
      cards.assignAll(response.data!);
      cards.insert(0, none);
    } else if (response.statusCode == 999) {
      AppResponse res = await locator.get<AuthService>().refreshUserToken();
      if (res.status) {
        getCards();
      }
    }
  }

  Future getSavingsSummary(Map<String, dynamic> requestBody) async {
    AppResponse<dynamic> response =
        await locator.get<SavingsService>().getSavingsSummary(requestBody);
    if (response.status) {
      SavingsSummary savingsSummary = SavingsSummary.fromJson(response.data);
      if (savingsSummary.data!.tenure! >= 30) {
        Get.to(() => SavingsSummaryScreen(), arguments: savingsSummary);
      } else {
        CustomToastNotification.show(
            "Tenure can not be less 30 days. Please adjust Target Amount, Recurring Amount or Frequency",
            type: ToastType.error);
      }
    } else if (response.statusCode == 999) {
      AppResponse res = await locator.get<AuthService>().refreshUserToken();
      if (res.status) {
        getSavingsSummary(requestBody);
      }
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  Future fundWalletWithNewCard() async {
    AppResponse response = await locator
        .get<FundWalletService>()
        .fundWalletWithNewCard(buildBeneficiaryModel());
    if (response.status) {
      cardData = response.data;
      handlePaymentInitialization(Get.context!);
    } else if (response.statusCode == 999) {
      AppResponse res = await locator.get<AuthService>().refreshUserToken();
      if (res.status) {
        fundWalletWithNewCard();
      }
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  Future<dynamic> validateTargetSavings() async {
    if (savingsNameController.text.length > 1 &&
        (double.parse(targetAmountController.text.split(",").join()) >= 1000 &&
            double.parse(startingAmountController.text.split(",").join()) >=
                100) &&
        frequency.value.isNotEmpty &&
        paymentType.value.isNotEmpty &&
        ((paymentType.value == "CARD" && card.value != null) ||
            paymentType.value == "WALLET")) {
      getSavingsSummary(buildTargetSavingsSummaryModel());
    } else if (savingsNameController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Savings name is required"),
          backgroundColor: AppColors.errorRed));
    } else if (savingsNameController.text.length < 2) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Savings name is too short"),
          backgroundColor: AppColors.errorRed));
    } else if (double.parse(targetAmountController.text.split(",").join("")) ==
        0) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please enter a valid target amount"),
          backgroundColor: AppColors.errorRed));
    } else if (double.parse(targetAmountController.text.split(",").join("")) <
        1000) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Target amount should be minimum of NGN 1,000"),
          backgroundColor: AppColors.errorRed));
    } else if (double.parse(
            startingAmountController.text.split(",").join("")) ==
        0) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please enter a valid recurring amount"),
          backgroundColor: AppColors.errorRed));
    } else if (double.parse(startingAmountController.text.split(",").join("")) <
        100) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Recurring amount should be minimum of NGN 100"),
          backgroundColor: AppColors.errorRed));
    } else if (frequency.value.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Freqency is required"),
          backgroundColor: AppColors.errorRed));
    } else if (paymentType.value.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Payment type is required"),
          backgroundColor: AppColors.errorRed));
    } else if (paymentType.value == "CARD" && card.value == null) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please select a card or add a new one"),
          backgroundColor: AppColors.errorRed));
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please supply all required fields"),
          backgroundColor: AppColors.errorRed));
    }
    return null;
  }

  Future<dynamic> validateLockedFunds() async {
    if (savingsNameController.text.length > 1 &&
        double.parse(savingsAmountController.text.split(",").join()) >= 5000 &&
        tenure.value != null &&
        paymentType.value.isNotEmpty &&
        ((paymentType.value == "CARD" && card.value != null) ||
            paymentType.value == "WALLET")) {
      getSavingsSummary(buildLockedFundsSummaryModel());
    } else if (savingsNameController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Savings name is required"),
          backgroundColor: AppColors.errorRed));
    } else if (savingsNameController.text.length < 2) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Savings name is too short"),
          backgroundColor: AppColors.errorRed));
    } else if (double.parse(savingsAmountController.text.split(",").join("")) ==
        0) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please enter a valid savings amount"),
          backgroundColor: AppColors.errorRed));
    } else if (double.parse(savingsAmountController.text.split(",").join("")) <
        5000) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Savings amount should be minimum of NGN 5,000"),
          backgroundColor: AppColors.errorRed));
    } else if (tenure.value == null) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Tenure is required"),
          backgroundColor: AppColors.errorRed));
    } else if (paymentType.value.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Payment type is required"),
          backgroundColor: AppColors.errorRed));
    } else if (paymentType.value == "CARD" && card.value == null) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please select a card or add a new one"),
          backgroundColor: AppColors.errorRed));
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please supply all required fields"),
          backgroundColor: AppColors.errorRed));
    }
    return null;
  }

  buildBeneficiaryModel() {
    String id = storage.read("userId");
    String suffix = DateTime.now().year.toString() +
        DateTime.now().month.toString() +
        DateTime.now().day.toString() +
        DateTime.now().hour.toString() +
        DateTime.now().minute.toString() +
        DateTime.now().second.toString();
    transactionRef = "CLV-SAVINGS$id$suffix".toUpperCase();
    return {"amount": "100.00", "txRef": transactionRef, "saveCard": true};
  }

  buildTargetSavingsSummaryModel() {
    return {
      "savingsAmount": targetAmountController.text.split(",").join(),
      "startDate": DateTime.now().toIso8601String().split("T")[0],
      "startingAmount": startingAmountController.text.split(",").join(),
      "debitFrequency": frequency.value,
      "type": "TARGET",
    };
  }

  buildLockedFundsSummaryModel() {
    return {
      "savingsAmount": savingsAmountController.text.split(",").join(),
      "startDate": DateTime.now().toIso8601String().split("T")[0],
      "tenure": tenure.value["value"],
      "type": "LOCKED",
    };
  }

  showFrequencyList(context, isDarkMode) {
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
                              "Select Frequency",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: "Mont",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: isDarkMode
                                      ? AppColors.mainGreen
                                      : AppColors.primaryColor),
                            ),
                          )
                        ]),
                  ),
                  Obx((() => Expanded(
                      child: ListView.builder(
                          itemCount: frequencies.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 20.w),
                              child: GestureDetector(
                                onTap: () {
                                  pop();
                                  frequency.value = frequencies[index];
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
                                                frequencies[index],
                                                style: TextStyle(
                                                    fontFamily: "Mont",
                                                    fontSize: 12.sp,
                                                    fontWeight: frequency
                                                                    .value !=
                                                                "" &&
                                                            frequency.value ==
                                                                frequencies[
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
                                          frequency.value != "" &&
                                                  frequency.value ==
                                                      frequencies[index]
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
                          }))))),
                ],
              )),
            ),
          );
        });
  }

  showPaymentTypeList(context, isDarkMode) {
    return showModalBottomSheet(
        backgroundColor: AppColors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.3,
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
                              "Select Payment Type",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: "Mont",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: isDarkMode
                                      ? AppColors.mainGreen
                                      : AppColors.primaryColor),
                            ),
                          )
                        ]),
                  ),
                  Obx((() => Expanded(
                      child: ListView.builder(
                          itemCount: paymentTypes.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 20.w),
                              child: GestureDetector(
                                onTap: () {
                                  pop();
                                  paymentType.value = paymentTypes[index];
                                  card.value = null;
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
                                                paymentTypes[index],
                                                style: TextStyle(
                                                    fontFamily: "Mont",
                                                    fontSize: 12.sp,
                                                    fontWeight: paymentType
                                                                    .value !=
                                                                "" &&
                                                            paymentType.value ==
                                                                paymentTypes[
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
                                          paymentType.value != "" &&
                                                  paymentType.value ==
                                                      paymentTypes[index]
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
                          }))))),
                ],
              )),
            ),
          );
        });
  }

  showTenureList(context, isDarkMode) {
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
                              "Select Tenure",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: "Mont",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: isDarkMode
                                      ? AppColors.mainGreen
                                      : AppColors.primaryColor),
                            ),
                          )
                        ]),
                  ),
                  Obx((() => Expanded(
                      child: ListView.builder(
                          itemCount: tenures.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 20.w),
                              child: GestureDetector(
                                onTap: () {
                                  pop();
                                  tenure.value = tenures[index];
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
                                                tenures[index]["name"],
                                                style: TextStyle(
                                                    fontFamily: "Mont",
                                                    fontSize: 12.sp,
                                                    fontWeight: tenure.value !=
                                                                null &&
                                                            tenure.value[
                                                                    "name"] ==
                                                                tenures[index]
                                                                    ["name"]
                                                        ? FontWeight.w700
                                                        : FontWeight.w600,
                                                    color: isDarkMode
                                                        ? AppColors.mainGreen
                                                        : AppColors
                                                            .primaryColor),
                                              ),
                                            ],
                                          ),
                                          tenure.value != null &&
                                                  tenure.value['name'] ==
                                                      tenures[index]['name']
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
                          }))))),
                ],
              )),
            ),
          );
        });
  }

  showCardList(context, isDarkMode) {
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
                              "Select Card",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: "Mont",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: isDarkMode
                                      ? AppColors.mainGreen
                                      : AppColors.primaryColor),
                            ),
                          )
                        ]),
                  ),
                  Obx((() => Expanded(
                      child: ListView.builder(
                          itemCount: cards.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 20.w),
                              child: GestureDetector(
                                onTap: () {
                                  pop();
                                  if (cards[index].id == "00") {
                                    card.value = null;
                                    fundWalletWithNewCard();
                                  } else {
                                    card.value = cards[index];
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
                                                cards[index].pan!,
                                                style: TextStyle(
                                                    fontFamily: "Mont",
                                                    fontSize: 12.sp,
                                                    fontWeight: card.value
                                                                    ?.id !=
                                                                "" &&
                                                            card.value?.id ==
                                                                cards[index].id
                                                        ? FontWeight.w700
                                                        : FontWeight.w600,
                                                    color: isDarkMode
                                                        ? AppColors.mainGreen
                                                        : AppColors
                                                            .primaryColor),
                                              ),
                                              cards[index].id != "00"
                                                  ? Text(
                                                      cards[index].provider!,
                                                      style: TextStyle(
                                                          fontFamily: "Mont",
                                                          fontSize: 10.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: isDarkMode
                                                              ? AppColors.white
                                                              : AppColors
                                                                  .black),
                                                    )
                                                  : SizedBox(),
                                            ],
                                          ),
                                          card.value?.id != "" &&
                                                  card.value?.id ==
                                                      cards[index].id
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
                          }))))),
                ],
              )),
            ),
          );
        });
  }

  handlePaymentInitialization(BuildContext context) async {
    String firstname = StringUtils.capitalize(storage.read("firstname"));
    String lastname = StringUtils.capitalize(storage.read("lastname"));
    String phoneNumber = storage.read("phoneNumber");
    String email = storage.read("email");
    final Customer customer = Customer(
        name: firstname + " " + lastname,
        phoneNumber: phoneNumber,
        email: email);
    final Flutterwave flutterwave = Flutterwave(
        context: context,
        publicKey: Environment.flutterWaveKey,
        currency: "NGN",
        redirectUrl: "https://business.cleverafrica.com",
        txRef: transactionRef,
        amount: "100.00",
        customer: customer,
        paymentOptions: "card",
        customization: Customization(
            title: "Fund Wallet",
            logo:
                "https://res.cloudinary.com/senjonnes/image/upload/v1680695198/Subtract_sjyu1o.png",
            description: "Fund Wallet"),
        isTestMode: Environment.isTestMode == "TEST");
    final ChargeResponse response = await flutterwave.charge();
    if (response.transactionId != null) {
      getCards();
    } else {
      CustomToastNotification.show(response.status!, type: ToastType.error);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    storage.write('removeAll', "1");
    super.onClose();
  }
}
