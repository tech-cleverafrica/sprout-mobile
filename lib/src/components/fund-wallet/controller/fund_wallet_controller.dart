import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutterwave_standard/core/flutterwave.dart';
import 'package:flutterwave_standard/models/requests/customer.dart';
import 'package:flutterwave_standard/models/requests/customizations.dart';
import 'package:flutterwave_standard/models/responses/charge_response.dart';
import 'package:sprout_mobile/src/components/authentication/service/auth_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:sprout_mobile/src/api-setup/api_setup.dart';
import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/components/fund-wallet/service/fund_wallet_service.dart';
import 'package:sprout_mobile/src/components/home/model/wallet_model.dart';
import 'package:sprout_mobile/src/components/home/service/home_service.dart';
import 'package:sprout_mobile/src/components/home/view/bottom_nav.dart';
import 'package:sprout_mobile/src/public/widgets/custom_toast_notification.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/app_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

class FundWalletController extends GetxController {
  final storage = GetStorage();
  RxBool isInvoice = false.obs;
  TextEditingController cardController = new TextEditingController();
  final AppFormatter formatter = Get.put(AppFormatter());
  late MoneyMaskedTextController amountController =
      new MoneyMaskedTextController(
          initialValue: 0, decimalSeparator: ".", thousandSeparator: ",");

  //information
  String fullname = "";
  String accountNumber = "";
  String providusAccountNumber = "";
  String wemaAccountNumber = "";
  RxString accountNumberToUse = "".obs;
  RxString bankToUse = "".obs;
  late RxDouble walletBalance = 0.0.obs;

  String transactionRef = "";

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() async {
    getWallet();
    getCards();
    fullname = StringUtils.capitalize(storage.read("firstname"));
    accountNumber = storage.read("accountNumber");
    providusAccountNumber = storage.read("providusAccount");
    wemaAccountNumber = storage.read("wemaAccount");
    bankToUse.value =
        providusAccountNumber.isEmpty ? "Wema Bank" : "Providus Bank";
    accountNumberToUse.value = providusAccountNumber.isEmpty
        ? wemaAccountNumber
        : providusAccountNumber;
    super.onInit();
  }

  getWallet() async {
    AppResponse response = await locator.get<HomeService>().getWallet();
    if (response.status) {
      Wallet wallet = Wallet.fromJson(response.data);
      walletBalance.value = wallet.data!.balance!;
      storage.write("userBalance", walletBalance.value);
    } else if (response.statusCode == 999) {
      AppResponse res = await locator<AuthService>().refreshUserToken();
      if (res.status) {
        getWallet();
      }
    }
  }

  getCards() async {
    AppResponse response = await locator.get<FundWalletService>().getCards();
    if (response.status) {
      print(response.data);
      // Wallet wallet = Wallet.fromJson(response.data);
      // walletBalance.value = wallet.data!.balance!;
      // storage.write("userBalance", walletBalance.value);
    }
  }

  Future<dynamic> validateFields() async {
    if ((double.parse(amountController.text.split(",").join()) >= 10 &&
        double.parse(amountController.text.split(",").join()) <= 450000)) {
      var response = await fundWalletWithNewCard();
      return response;
    } else if (double.parse(amountController.text.split(",").join("")) == 0) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please enter a valid amount"),
          backgroundColor: AppColors.errorRed));
    } else if (double.parse(amountController.text.split(",").join("")) < 10) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Amount is too small"),
          backgroundColor: AppColors.errorRed));
    } else if (double.parse(amountController.text.split(",").join("")) >
        450000) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Maximum amount is 450,000"),
          backgroundColor: AppColors.errorRed));
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please supply all required fields"),
          backgroundColor: AppColors.errorRed));
    }
    return null;
  }

  Future<dynamic> fundWalletWithNewCard() async {
    AppResponse response = await locator
        .get<FundWalletService>()
        .fundWalletWithNewCard(buildBeneficiaryModel(), "Please wait");
    if (response.status) {
      print(response.data);
      return response.data;
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
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
    transactionRef = "CLV$id$suffix".toUpperCase();
    return {
      "amount": amountController.text.split(",").join(),
      "txRef": "CLV$id$suffix".toUpperCase(),
    };
  }

  @override
  void onClose() {
    super.onClose();
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
                              "Select Card",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: "DMSans",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: isDarkMode
                                      ? AppColors.mainGreen
                                      : AppColors.primaryColor),
                            ),
                          )
                        ]),
                  ),
                  // Expanded(
                  //     child: ListView.builder(
                  //         itemCount: bankList.length,
                  //         shrinkWrap: true,
                  //         physics: BouncingScrollPhysics(),
                  //         itemBuilder: ((context, index) {
                  //           return Padding(
                  //             padding: EdgeInsets.symmetric(
                  //                 vertical: 10.h, horizontal: 20.w),
                  //             child: GestureDetector(
                  //               onTap: () {
                  //                 pop();
                  //                 print(bankList[index]);
                  //                 beneficiaryBank.value = bankList[index];
                  //                 selectedBankCode.value = bankCode[
                  //                     bankList.indexOf(beneficiaryBank.value)];
                  //                 canResolve.value = true;
                  //                 showBeneficiary.value = false;
                  //                 newBeneficiaryName.value = "";
                  //                 bankList = baseBankList;
                  //                 validateBank();
                  //               },
                  //               child: Container(
                  //                 decoration: BoxDecoration(
                  //                     color: isDarkMode
                  //                         ? AppColors.inputBackgroundColor
                  //                         : AppColors.grey,
                  //                     borderRadius: BorderRadius.circular(10)),
                  //                 child: Padding(
                  //                     padding: EdgeInsets.symmetric(
                  //                         horizontal: 15.w, vertical: 16.h),
                  //                     child: Row(
                  //                       crossAxisAlignment:
                  //                           CrossAxisAlignment.center,
                  //                       mainAxisAlignment:
                  //                           MainAxisAlignment.spaceBetween,
                  //                       children: [
                  //                         Text(
                  //                           bankList[index]!,
                  //                           style: TextStyle(
                  //                               fontFamily: "DMSans",
                  //                               fontSize: 12.sp,
                  //                               fontWeight: beneficiaryBank
                  //                                               .value !=
                  //                                           "" &&
                  //                                       beneficiaryBank.value ==
                  //                                           bankList[index]
                  //                                   ? FontWeight.w700
                  //                                   : FontWeight.w600,
                  //                               color: isDarkMode
                  //                                   ? AppColors.mainGreen
                  //                                   : AppColors.primaryColor),
                  //                         ),
                  //                         beneficiaryBank.value != "" &&
                  //                                 beneficiaryBank.value ==
                  //                                     bankList[index]
                  //                             ? SvgPicture.asset(
                  //                                 AppSvg.mark_green,
                  //                                 height: 20,
                  //                                 color: isDarkMode
                  //                                     ? AppColors.mainGreen
                  //                                     : AppColors.primaryColor,
                  //                               )
                  //                             : SizedBox()
                  //                       ],
                  //                     )),
                  //               ),
                  //             ),
                  //           );
                  //         }))),
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
        publicKey: "FLWPUBK_TEST-c9c17e8e7f23ee3e840970bc2143326d-X",
        currency: "NGN",
        redirectUrl: "https://business.cleverafrica.com",
        txRef: transactionRef,
        amount: amountController.text.split(",").join(),
        customer: customer,
        paymentOptions: "card",
        // paymentOptions: "ussd, card, barter, payattitude",
        customization: Customization(
            title: "Fund Wallet",
            logo:
                "https://res.cloudinary.com/senjonnes/image/upload/v1680695198/Subtract_sjyu1o.png",
            description: "Fund Wallet"),
        isTestMode: true);
    final ChargeResponse response = await flutterwave.charge();
    print("TEST OUTPUT");
    print(response.transactionId);
    if (response.transactionId != null) {
      CustomToastNotification.show("Your wallet has been funded successfully",
          type: ToastType.success);
      pushUntil(page: BottomNav());
    } else {
      pop();
      amountController = new MoneyMaskedTextController(
          initialValue: 0, decimalSeparator: ".", thousandSeparator: ",");
    }
  }
}
