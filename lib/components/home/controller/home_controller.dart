import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:intl/intl.dart';
import 'package:sprout_mobile/api-setup/api_setup.dart';
import 'package:sprout_mobile/api/api_response.dart';
import 'package:sprout_mobile/components/authentication/service/auth_service.dart';
import 'package:sprout_mobile/components/home/model/transactions_model.dart';
import 'package:sprout_mobile/components/home/model/wallet_model.dart';
import 'package:sprout_mobile/components/home/service/home_service.dart';
import 'package:sprout_mobile/components/save/model/savings_model.dart';
import 'package:sprout_mobile/components/save/service/savings_service.dart';
import 'package:sprout_mobile/public/services/shared_service.dart';
import 'package:sprout_mobile/repository/preference_repository.dart';
import 'package:sprout_mobile/utils/app_formatter.dart';
import 'package:sprout_mobile/utils/constants.dart';

class HomeController extends GetxController {
  final storage = GetStorage();
  final PreferenceRepository preferenceRepository =
      Get.put(PreferenceRepository());
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
  RxDouble savingsBalance = 0.0.obs;

  RxList<TransactionsResponse> transactionsResponse =
      <TransactionsResponse>[].obs;
  RxList<Transactions> transactions = <Transactions>[].obs;
  Rx<List<Transactions>> searchableTransactions = Rx<List<Transactions>>([]);
  RxBool isTransactionLoading = false.obs;
  RxBool isGraphLoading = false.obs;
  RxBool isApproved = false.obs;
  RxBool inReview = false.obs;
  RxBool showAmount = true.obs;
  RxBool showSavingsAmount = true.obs;

  var storageBalance;
  var storageSavingsBalance;
  var storageTransactions;

  var inflowGraph = Rxn<dynamic>();
  var outflowGraph = Rxn<dynamic>();

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() async {
    inflowGraph.value = dummyGraph();
    outflowGraph.value = dummyGraph();
    storageBalance = storage.read("userBalance");
    storageSavingsBalance = storage.read("savingsBalance");
    storageTransactions = storage.read("transactionResponse");
    if (storageBalance != null && storageBalance != "") {
      walletBalance.value = storageBalance;
    }
    if (storageSavingsBalance != null && storageSavingsBalance != "") {
      savingsBalance.value = storageSavingsBalance;
    }
    if (storageTransactions != null && storageTransactions != "") {
      transactions.value = [];
      jsonDecode(storageTransactions).forEach(
        (e) => transactions.add(Transactions.fromJson(e)),
      );
    }
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
    String approvalStatus = storage.read("approvalStatus");
    isApproved.value = approvalStatus == "APPROVED" ? true : false;
    inReview.value = approvalStatus == "IN_REVIEW" ? true : false;
    loadTransactions();
    getWallet();
    fetchPlans();
    getDashboardGraph();
    addNotificationID();
    super.onInit();
  }

  getWallet() async {
    if (!isApproved.value || (isApproved.value && inReview.value)) {
      walletBalance.value = 0.0;
    } else {
      AppResponse response = await locator.get<HomeService>().getWallet();
      if (response.status) {
        Wallet wallet = Wallet.fromJson(response.data);
        walletBalance.value = wallet.data!.balance!;
        storage.write("userBalance", walletBalance.value);
      } else if (response.statusCode == 999) {
        AppResponse res = await locator.get<AuthService>().refreshUserToken();
        if (res.status) {
          getWallet();
        }
      }
    }
  }

  addNotificationID() async {
    String? notificationId =
        await preferenceRepository.getStringPref(NOTIFICATION_ID);
    String? id = jsonDecode(notificationId);
    if (id != "" && id != null) {
      AppResponse response = await locator
          .get<SharedService>()
          .addNotificationID(buildRequestModel(id));
      if (response.statusCode == 999) {
        AppResponse res = await locator.get<AuthService>().refreshUserToken();
        if (res.status) {
          addNotificationID();
        }
      }
    }
  }

  fetchPlans() async {
    AppResponse response = await locator.get<SavingsService>().getPlans();
    if (response.status) {
      computeTotal(response.data!);
    } else if (response.statusCode == 999) {
      AppResponse res = await locator.get<AuthService>().refreshUserToken();
      if (res.status) {
        fetchPlans();
      }
    }
  }

  buildRequestModel(String id) {
    return {
      "deviceID": id,
    };
  }

  computeTotal(List<Savings> savings) {
    num currentAmount = 0;
    num interestAccrued = 0;
    savings.forEach((e) {
      currentAmount += e.currentAmount!;
      interestAccrued += e.interestAccrued!;
    });
    savingsBalance.value = (currentAmount + interestAccrued).toDouble();
    storage.write("savingsBalance", savingsBalance.value);
  }

  loadTransactions() async {
    if (storageTransactions != null && storageTransactions != "") {
      isTransactionLoading.value = false;
    } else {
      isTransactionLoading.value = true;
    }
    if (!isApproved.value || (isApproved.value && inReview.value)) {
      isTransactionLoading.value = false;
      transactions.clear();
    } else {
      AppResponse<List<Transactions>> transactionsResponse =
          await locator.get<HomeService>().getTransactions();
      isTransactionLoading.value = false;
      if (transactionsResponse.status) {
        transactions.clear();
        transactions.assignAll(transactionsResponse.data);
        storage.write(
            "transactionResponse", jsonEncode(transactionsResponse.data!));
      } else if (transactionsResponse.statusCode == 999) {
        AppResponse res = await locator.get<AuthService>().refreshUserToken();
        if (res.status) {
          loadTransactions();
        }
      }
    }
  }

  getDashboardGraph() async {
    if (!isApproved.value || (isApproved.value && inReview.value)) {
      isGraphLoading.value = false;
    } else {
      isGraphLoading.value = true;
      AppResponse<dynamic> response =
          await locator.get<HomeService>().getDashboardGraph();
      isGraphLoading.value = false;
      if (response.status) {
        dynamic inflowData = response.data['data']['inflow'];
        dynamic outflowData = response.data['data']['outflow'];
        inflowGraph.value = setGraph(inflowData, "amount");
        outflowGraph.value = setGraph(outflowData, "amount");
      } else if (response.statusCode == 999) {
        AppResponse res = await locator.get<AuthService>().refreshUserToken();
        if (res.status) {
          getDashboardGraph();
        }
      }
    }
  }

  getUserInfo() async {
    AppResponse<dynamic> response =
        await locator.get<AuthService>().getUserDetails();
    if (response.statusCode == 999) {
      AppResponse res = await locator.get<AuthService>().refreshUserToken();
      if (res.status) {
        getUserInfo();
      }
    }
  }

  Future<void> refreshData() async {
    try {
      getWallet();
      loadTransactions();
      getUserInfo();
      getDashboardGraph();
    } catch (err) {
      rethrow;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  dynamic dummyGraph() {
    List<FlSpot> spots = [
      FlSpot(1, 0),
      FlSpot(2, 0),
      FlSpot(3, 0),
      FlSpot(4, 0),
      FlSpot(5, 0),
      FlSpot(6, 0),
      FlSpot(7, 0),
    ];
    dynamic items = {
      "spots": spots,
      "maxY": 100.0,
      "dates": ['', '', '', '', '', '', ''],
      "interval": 100.0
    };
    return items;
  }

  dynamic setGraph(dynamic data, String key) {
    double index = 1;
    String char = '';
    // String month = '';
    // String day = '';

    List<FlSpot> spots = [];
    double maxY = 0;
    List<String> dates = [];
    data.forEach((k, v) => {
          // create spots
          spots.add(
            FlSpot(index, double.parse(v[key].toString())),
          ),
          index = index + 1,
          // compute maxY
          if (double.parse(v[key].toString()) > maxY)
            {
              maxY = double.parse(v[key].toString()),
            },
          // create dates
          char = k.toString().split('')[0],
          // month = v['transactionDateTime'] != null
          //     ? v['transactionDateTime'].toString().split(' ')[1]
          //     : 'NILL',
          // day = v['transactionDateTime'] != null
          //     ? v['transactionDateTime'].toString().split(' ')[2]
          //     : '',
          dates.add('$char'),
          // dates.add('$char-$month $day'),
        });
    dynamic items = {
      "spots": spots,
      "maxY": maxY,
      "dates": dates,
      "interval": maxY > 500 && maxY <= 1000
          ? 100.0
          : maxY > 1000 && maxY <= 2000
              ? 200.0
              : maxY > 2000 && maxY <= 5000
                  ? 400.0
                  : maxY > 5000 && maxY <= 10000
                      ? 1000.0
                      : maxY > 10000 && maxY <= 20000
                          ? 2000.0
                          : maxY > 20000 && maxY <= 50000
                              ? 4000.0
                              : maxY > 50000 && maxY <= 100000
                                  ? 10000.0
                                  : maxY > 100000
                                      ? 20000.0
                                      : 50.0
    };
    return items;
  }

  String nth(String n) {
    String nths;
    List<String> ns = n.split('');
    int val = int.parse(ns[ns.length - 1]);
    if (val == 0 ||
        val == 4 ||
        val == 5 ||
        val == 6 ||
        val == 7 ||
        val == 8 ||
        val == 9) {
      nths = 'th';
    } else if (val == 1) {
      nths = 'st';
    } else {
      nths = 'rd';
    }
    return nths;
  }

  String mode(int n) {
    String modes;
    if (n > 11) {
      modes = 'pm';
    } else {
      modes = 'am';
    }
    return modes;
  }

  String formatDate(String date) {
    String _date;
    List<String> months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'November',
      'December'
    ];
    var locale =
        DateFormat("yyyy-MM-ddTHH:mm:ssZ").parseUTC(date).toLocal().toString();
    var dateTime = DateTime.parse(locale);
    _date =
        "${dateTime.day}${nth(dateTime.day.toString())}.${months[dateTime.month]}. ${dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour}:${dateTime.minute}${mode(dateTime.hour)}";
    return _date;
  }
}