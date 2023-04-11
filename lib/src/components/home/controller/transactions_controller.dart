import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sprout_mobile/src/api-setup/api_setup.dart';
import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/components/home/service/home_service.dart';
import 'package:sprout_mobile/src/public/model/date_range.dart';
import 'package:sprout_mobile/src/public/services/date_service.dart';
import 'package:sprout_mobile/src/public/widgets/custom_toast_notification.dart';

import '../model/transactions_model.dart';

class TransactionsController extends GetxController {
  final storage = GetStorage();
  final ScrollController scrollController = new ScrollController();
  RxList<Transactions> transactions = <Transactions>[].obs;
  RxBool loading = false.obs;
  int pageIndex = 0;
  int size = 15;
  String screen = "All Transactions";
  String date = "Today";
  bool showClearIcon = false;
  String startDate = "";
  String endDate = "";
  String status = "successful";
  String transactionFilters = "";

  @override
  void onInit() {
    super.onInit();
    loading.value = true;
    loadTransactions();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        size = size + 10;
        loadTransactions();
      }
    });
  }

  @override
  void onReady() async {
    // transactions = await Get.arguments;
    // searchableTransactions.value = transactions;
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  loadTransactions() async {
    AppResponse<List<Transactions>> transactionsResponse = await locator
        .get<HomeService>()
        .getTransactionsWithFilter(buildFilters());
    loading.value = false;
    transactions.clear();
    if (transactionsResponse.status) {
      transactions.assignAll(transactionsResponse.data!);
    }
  }

  downloadTransactionRecords() async {
    AppResponse response = await locator
        .get<HomeService>()
        .downloadTransactionRecords(transactionFilters);
    if (response.status) {
      CustomToastNotification.show(response.message, type: ToastType.success);
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  Future<void> refreshData() async {
    try {
      loadTransactions();
    } catch (err) {
      rethrow;
    }
  }

  String buildFilters() {
    String userId = storage.read("userId");
    DateRange dateFilter = locator.get<DateService>().dateRangeFormatter(date);
    String typeFilter = "";
    String filters = "";
    if (screen == 'All Transactions') {
      typeFilter = "";
    }

    if (screen == 'Cash Withdrawal') {
      typeFilter = "CASH_OUT";
    }

    if (screen == 'Funds Transfer') {
      typeFilter = "FUNDS_TRANSFER";
    }

    if (screen == 'Wallet Top-up') {
      typeFilter = "WALLET_TOP_UP";
    }

    if (screen == 'Bills Payment') {
      typeFilter = "BILLS_PAYMENT";
    }

    if (screen == 'Airtime Purchase') {
      typeFilter = "AIRTIME_VTU";
    }

    if (screen == 'Debit') {
      typeFilter = "DEBIT";
    }

    if (status == "reversed") {
      filters = typeFilter == ""
          ? '?size=$size&startDate=${dateFilter.startDate}&endDate=${dateFilter.endDate}&reversed=true'
          : '?size=$size&startDate=${dateFilter.startDate}&endDate=${dateFilter.endDate}&reversed=true&type=$typeFilter';
      transactionFilters = typeFilter == ""
          ? '?startDate=${dateFilter.startDate}&endDate=${dateFilter.endDate}&userID=$userId'
          : '?startDate=${dateFilter.startDate}&endDate=${dateFilter.endDate}&type=$typeFilter&userID=$userId';
    } else {
      filters = typeFilter == ""
          ? '?size=$size&startDate=${dateFilter.startDate}&endDate=${dateFilter.endDate}&status=$status'
          : '?size=$size&startDate=${dateFilter.startDate}&endDate=${dateFilter.endDate}&status=$status&type=$typeFilter';
      transactionFilters = typeFilter == ""
          ? '?startDate=${dateFilter.startDate}&endDate=${dateFilter.endDate}&userID=$userId'
          : '?startDate=${dateFilter.startDate}&endDate=${dateFilter.endDate}&type=$typeFilter&userID=$userId';
    }
    return filters;
  }
}
