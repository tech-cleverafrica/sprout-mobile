import 'package:flutter/material.dart';
import 'package:flutterwave_standard/core/flutterwave.dart';
import 'package:flutterwave_standard/models/requests/customer.dart';
import 'package:flutterwave_standard/models/requests/customizations.dart';
import 'package:flutterwave_standard/models/responses/charge_response.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:sprout_mobile/src/api-setup/api_setup.dart';
import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/components/home/model/wallet_model.dart';
import 'package:sprout_mobile/src/components/home/service/home_service.dart';
import 'package:sprout_mobile/src/utils/app_formatter.dart';

class FundWalletController extends GetxController {
  final storage = GetStorage();
  RxBool isInvoice = false.obs;
  final AppFormatter formatter = Get.put(AppFormatter());

  //information
  String fullname = "";
  String accountNumber = "";
  String providusAccountNumber = "";
  String wemaAccountNumber = "";
  RxString accountNumberToUse = "".obs;
  RxString bankToUse = "".obs;
  late RxDouble walletBalance = 0.0.obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() async {
    getWallet();
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
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  handlePaymentInitialization(BuildContext context) async {
    String id = storage.read("userId");
    String suffix = DateTime.now().year.toString() +
        DateTime.now().month.toString() +
        DateTime.now().day.toString() +
        DateTime.now().hour.toString() +
        DateTime.now().minute.toString() +
        DateTime.now().second.toString();
    final Customer customer = Customer(
        name: "Flutterwave Developer",
        phoneNumber: "1234566677777",
        email: "customer@customer.com");
    final Flutterwave flutterwave = Flutterwave(
        context: context,
        publicKey: "FLWPUBK_TEST-c9c17e8e7f23ee3e840970bc2143326d-X",
        currency: "NGN",
        redirectUrl: "add-your-redirect-url-here",
        txRef: "CLV$id$suffix".toUpperCase(),
        amount: "3000",
        customer: customer,
        paymentOptions: "ussd, card, barter, payattitude",
        customization: Customization(title: "My Payment"),
        isTestMode: true);
    final ChargeResponse response = await flutterwave.charge();
    print("TEST OUTPUT");
    print(response.transactionId);
  }
}
