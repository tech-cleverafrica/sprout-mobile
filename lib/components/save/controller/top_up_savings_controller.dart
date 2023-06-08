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
import 'package:sprout_mobile/api-setup/api_setup.dart';
import 'package:sprout_mobile/api/api_response.dart';
import 'package:sprout_mobile/components/fund-wallet/model/customer_card_model.dart';
import 'package:sprout_mobile/components/fund-wallet/service/fund_wallet_service.dart';
import 'package:sprout_mobile/components/save/controller/savings_details_controller.dart';
import 'package:sprout_mobile/components/save/service/savings_service.dart';
import 'package:sprout_mobile/components/save/view/savings_approval_screen.dart';
import 'package:sprout_mobile/environment.dart';
import 'package:sprout_mobile/public/widgets/custom_loader.dart';
import 'package:sprout_mobile/public/widgets/custom_toast_notification.dart';
import 'package:sprout_mobile/utils/app_colors.dart';
import 'package:sprout_mobile/utils/app_formatter.dart';
import 'package:sprout_mobile/components/authentication/service/auth_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sprout_mobile/utils/app_svgs.dart';
import 'package:sprout_mobile/utils/nav_function.dart';

class TopUpSavingsController extends GetxController {
  final storage = GetStorage();
  final AppFormatter formatter = Get.put(AppFormatter());
  late SavingsDetailsController savingsDetailsController;
  TextEditingController savingsNameController = new TextEditingController();
  late MoneyMaskedTextController topUpAmountController =
      new MoneyMaskedTextController(
          initialValue: 0, decimalSeparator: ".", thousandSeparator: ",");
  TextEditingController paymentTypeController = new TextEditingController();
  TextEditingController cardController = new TextEditingController();

  RxList<String> paymentTypes = <String>['WALLET', 'CARD'].obs;
  RxString paymentType = "".obs;

  RxList<CustomerCard> cards = <CustomerCard>[].obs;
  var card = Rxn<CustomerCard>();
  var cardData;
  String transactionRef = "";

  @override
  void onInit() {
    savingsDetailsController = Get.put(SavingsDetailsController());
    savingsNameController = new TextEditingController(
        text: savingsDetailsController.savings.value!.portfolioName);
    // if (savingsDetailsController.savings.value!.currentAmount! <
    //     savingsDetailsController.savings.value!.startAmount!) {
    //   topUpAmountController = new MoneyMaskedTextController(
    //       initialValue:
    //           savingsDetailsController.savings.value!.targetAmount!.toDouble(),
    //       decimalSeparator: ".",
    //       thousandSeparator: ",");
    // }
    getCards();
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

  Future createTopUp(Map<String, dynamic> requestBody) async {
    AppResponse<dynamic> response =
        await locator.get<SavingsService>().createTopUp(requestBody);
    if (response.status) {
      pushUntil(
          page: SavingsApprovalScreen(
        message:
            "You have successfully top up for " + savingsNameController.text,
      ));
    } else if (response.statusCode == 999) {
      AppResponse res = await locator.get<AuthService>().refreshUserToken();
      if (res.status) {
        createTopUp(requestBody);
      }
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  Future<dynamic> validateTopUp() async {
    if ((double.parse(topUpAmountController.text.split(",").join()) >= 100) &&
        paymentType.value.isNotEmpty &&
        ((paymentType.value == "CARD" && card.value != null) ||
            paymentType.value == "WALLET")) {
      createTopUp(buildTopUpRequestModel());
    } else if (double.parse(topUpAmountController.text.split(",").join("")) ==
        0) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please enter a valid top up amount"),
          backgroundColor: AppColors.errorRed));
    } else if (double.parse(topUpAmountController.text.split(",").join("")) <
        1000) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Top up amount should be minimum of NGN 100"),
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

  buildTopUpRequestModel() {
    return {
      "amount": topUpAmountController.text.split(",").join(),
      "savingsId": savingsDetailsController.savings.value!.id!,
      "type": paymentType.value,
      "cardToken": paymentType.value == "WALLET" ? "" : card.value!.token,
    };
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
}
