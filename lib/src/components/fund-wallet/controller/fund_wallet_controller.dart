import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:sprout_mobile/src/api-setup/api_setup.dart';
import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/components/home/model/wallet_model.dart';
import 'package:sprout_mobile/src/components/home/service/home_service.dart';

class FundWalletController extends GetxController {
  final storage = GetStorage();
  RxBool isInvoice = false.obs;

  //information
  String fullname = "";
  String accountNumber = "";
  String providusAccountNumber = "";
  String wemaAccountNumber = "";
  String accountNumberToUse = "";
  String bankToUse = "";
  late double walletBalance = 0.0;

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
    bankToUse = providusAccountNumber.isEmpty ? "Wema Bank" : "Providus Bank";
    accountNumberToUse = providusAccountNumber.isEmpty
        ? wemaAccountNumber
        : providusAccountNumber;
    super.onInit();
  }

  getWallet() async {
    AppResponse response = await locator.get<HomeService>().getWallet();
    if (response.status) {
      Wallet wallet = Wallet.fromJson(response.data);
      walletBalance = wallet.data!.balance!;
      storage.write("userBalance", walletBalance);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
