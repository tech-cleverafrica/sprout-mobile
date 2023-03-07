import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/transactions_model.dart';

class TransactionsController extends GetxController {
  RxList<Transactions> transactions = <Transactions>[].obs;
  Rx<List<Transactions>> searchableTransactions = Rx<List<Transactions>>([]);
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    transactions = await Get.arguments;
    searchableTransactions.value = transactions;
    super.onReady();
  }

  void onSearch(String query) {
    List<Transactions> result = [];
    debugPrint(query);
    if (query.isEmpty) {
      result = searchableTransactions.value;
    } else if (query.length % 2 == 0) {
      result = transactions
          .where((Transactions transactions) =>
              transactions.type!.toLowerCase().contains(query))
          .toList();
    }
    print("got here!!!!");
    print(result);
    searchableTransactions.value = result;
  }

  @override
  void onClose() {
    super.onClose();
  }
}
