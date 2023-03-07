import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/home/controller/transactions_controller.dart';
import 'package:sprout_mobile/src/components/home/view/widgets.dart';

import '../../../public/widgets/custom_text_form_field.dart';
import '../../../public/widgets/general_widgets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/helper_widgets.dart';

class AlltransactionScreen extends StatelessWidget {
  AlltransactionScreen({super.key});
  late TransactionsController transactionsController;

  @override
  Widget build(BuildContext context) {
    transactionsController = Get.put(TransactionsController());
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getHeader(isDarkMode),
                addVerticalSpace(15.h),
                CustomTextFormField(
                  hintText: "Search your transactions",
                  hasPrefixIcon: true,
                  prefixIcon: Icon(Icons.search),
                  onChanged: transactionsController.onSearch,
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                ),
                addVerticalSpace(20.h),
                Obx((() =>
                    transactionsController.searchableTransactions.value.length >
                            0
                        ? ListView.builder(
                            itemCount: transactionsController
                                        .searchableTransactions.value.length >
                                    5
                                ? 5
                                : transactionsController
                                    .searchableTransactions.value.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: ((context, index) {
                              return HistoryCard(
                                theme: theme,
                                isDarkMode: isDarkMode,
                                transactionType: transactionsController
                                    .searchableTransactions.value[index].type!,
                                transactionAmount: transactionsController
                                                .searchableTransactions
                                                .value[index]
                                                .type ==
                                            "WALLET_TOP_UP" ||
                                        transactionsController
                                                .searchableTransactions
                                                .value[index]
                                                .type ==
                                            "DEBIT"
                                    ? transactionsController
                                        .searchableTransactions
                                        .value[index]
                                        .totalAmount!
                                    : transactionsController
                                        .searchableTransactions
                                        .value[index]
                                        .transactionAmount!,
                                transactionRef: transactionsController
                                    .searchableTransactions.value[index].ref,
                                transactionId: transactionsController
                                    .searchableTransactions.value[index].id,
                                createdAt: transactionsController
                                    .searchableTransactions
                                    .value[index]
                                    .createdAt,
                              );
                            }))
                        : Center(
                            child: Text(
                              "No transaction yet!",
                              style: TextStyle(color: AppColors.primaryColor),
                            ),
                          )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
