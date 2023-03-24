import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:sprout_mobile/src/api-setup/api_setup.dart';
import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/components/authentication/controller/sign_in_controller.dart';
import 'package:sprout_mobile/src/components/home/model/transactions_model.dart';
import 'package:sprout_mobile/src/components/home/model/wallet_model.dart';
import 'package:sprout_mobile/src/components/home/service/home_service.dart';
import 'package:sprout_mobile/src/utils/app_formatter.dart';

class HomeController extends GetxController {
  final storage = GetStorage();
  RxBool isInvoice = false.obs;
  final AppFormatter formatter = Get.put(AppFormatter());

  //information
  String fullname = "";
  String abbreviation = "";
  String accountNumber = "";
  String providusAccountNumber = "";
  String wemaAccountNumber = "";
  RxString accountNumberToUse = "".obs;
  RxString bankToUse = "".obs;
  RxDouble walletBalance = 0.0.obs;

  RxList<TransactionsResponse> transactionsResponse =
      <TransactionsResponse>[].obs;
  RxList<Transactions> transactions = <Transactions>[].obs;
  Rx<List<Transactions>> searchableTransactions = Rx<List<Transactions>>([]);
  RxBool isTransactionLoading = false.obs;

  SignInController signInController = Get.put(SignInController());

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() async {
    getWallet();
    loadTransactions();
    fullname = StringUtils.capitalize(storage.read("firstname"));
    abbreviation = StringUtils.capitalize(storage.read("firstname")[0]) +
        StringUtils.capitalize(storage.read("lastname")[0]);
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

  loadTransactions() async {
    isTransactionLoading.value = true;
    AppResponse<List<Transactions>> transactionsResponse =
        await locator.get<HomeService>().getTransactions();
    isTransactionLoading.value = false;

    if (transactionsResponse.status) {
      transactions.assignAll(transactionsResponse.data!);
      print(transactionsResponse);
    }
  }

  Future<void> refreshData() async {
    try {
      getWallet();
      loadTransactions();
      signInController.getUserInfo();
    } catch (err) {
      rethrow;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
