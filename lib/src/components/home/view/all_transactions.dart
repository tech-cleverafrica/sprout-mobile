import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/home/controller/transactions_controller.dart';
import 'package:sprout_mobile/src/components/home/view/transaction_details.dart';
import 'package:sprout_mobile/src/components/home/view/widgets.dart';
import 'package:sprout_mobile/src/public/widgets/custom_loader.dart';
import 'package:sprout_mobile/src/public/widgets/filter_popup.dart';
import 'package:sprout_mobile/src/utils/app_images.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

import '../../../public/widgets/general_widgets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/helper_widgets.dart';

// ignore: must_be_immutable
class AlltransactionScreen extends StatelessWidget {
  AlltransactionScreen({super.key});
  late TransactionsController trxCtrl;

  @override
  Widget build(BuildContext context) {
    trxCtrl = Get.put(TransactionsController());
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Obx((() => trxCtrl.transactions.isNotEmpty
            ? GestureDetector(
                onTap: () => trxCtrl.downloadTransactionRecords(),
                child: Container(
                    padding: EdgeInsets.only(top: 0, bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Download transactions",
                          style: TextStyle(
                            color: AppColors.deepOrange,
                            fontSize: 12.sp,
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SvgPicture.asset(
                          AppSvg.download_statement,
                          height: 20.h,
                          width: 20.w,
                        ),
                        // Image.asset(AppImages.download, height: 15),
                      ],
                    )),
              )
            : SizedBox())),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getHeader(isDarkMode),
                addVerticalSpace(20.h),
                Obx((() => Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 35,
                            width: 110,
                            alignment: Alignment.center,
                            child: FilterPopup(
                                title: "All Transactions",
                                altColor: isDarkMode
                                    ? AppColors.mainGreen
                                    : AppColors.primaryColor,
                                altTextColor: AppColors.white,
                                padding: EdgeInsets.only(left: 5),
                                callback: (value) => {
                                      trxCtrl.screen = value,
                                      trxCtrl.startDate = "",
                                      trxCtrl.endDate = "",
                                      trxCtrl.size = 15,
                                      trxCtrl.loading.value = true,
                                      trxCtrl.loadTransactions(),
                                    },
                                store: [
                                  "All Transactions",
                                  "Cash Withdrawal",
                                  "Funds Transfer",
                                  "Wallet Top-up",
                                  "Bills Payment",
                                  "Airtime Purchase",
                                  "Debit",
                                ],
                                borderRadius: BorderRadius.circular(6),
                                arrowSize: 15,
                                maxHeight: 450,
                                icon: AppImages.filter,
                                open: !trxCtrl.loading.value ? true : false),
                          ),
                          Container(
                            height: 35,
                            width: 100,
                            child: FilterPopup(
                                title: trxCtrl.date,
                                altColor: isDarkMode
                                    ? AppColors.mainGreen
                                    : AppColors.primaryColor,
                                altTextColor: AppColors.white,
                                padding: EdgeInsets.only(left: 7),
                                callback: (value) => {
                                      trxCtrl.date = value,
                                      trxCtrl.size = 15,
                                      trxCtrl.loading.value = true,
                                      trxCtrl.loadTransactions(),
                                    },
                                store: [
                                  "Today",
                                  "Yesterday",
                                  "This week",
                                  "Last week",
                                  "This month",
                                  "Last month"
                                ],
                                borderRadius: BorderRadius.circular(6),
                                maxHeight: 400,
                                icon: AppImages.whiteCheck,
                                open: !trxCtrl.loading.value ? true : false),
                          ),
                          Container(
                            height: 35,
                            width: 100,
                            alignment: Alignment.center,
                            child: FilterPopup(
                                title: "Successful",
                                altColor: isDarkMode
                                    ? AppColors.mainGreen
                                    : AppColors.primaryColor,
                                altTextColor: AppColors.white,
                                padding: EdgeInsets.only(left: 5),
                                callback: (value) => {
                                      trxCtrl.size = 15,
                                      trxCtrl.status = value.toLowerCase(),
                                      trxCtrl.loading.value = true,
                                      trxCtrl.loadTransactions(),
                                    },
                                store: [
                                  "Successful",
                                  "Processing",
                                  "Unsuccessful",
                                  "Reversed",
                                ],
                                borderRadius: BorderRadius.circular(6),
                                arrowSize: 15,
                                maxHeight: 450,
                                icon: AppImages.filter,
                                open: !trxCtrl.loading.value ? true : false),
                          ),
                        ],
                      ),
                    ))),
                addVerticalSpace(20.h),
                Expanded(
                    child: Container(
                        child: Obx((() => trxCtrl.transactions.length > 0 &&
                                !trxCtrl.loading.value
                            ? ListView.builder(
                                controller: trxCtrl.scrollController,
                                itemCount: trxCtrl.transactions.length,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: ((context, index) {
                                  return InkWell(
                                      onTap: () => push(
                                          page: TransactionDetailsScreen(),
                                          arguments:
                                              trxCtrl.transactions[index]),
                                      child: HistoryCard(
                                        theme: theme,
                                        isDarkMode: isDarkMode,
                                        transactionType:
                                            trxCtrl.transactions[index].type!,
                                        transactionAmount:
                                            trxCtrl.transactions[index].type ==
                                                        "WALLET_TOP_UP" ||
                                                    trxCtrl.transactions[index]
                                                            .type ==
                                                        "DEBIT"
                                                ? trxCtrl.transactions[index]
                                                    .totalAmount!
                                                : trxCtrl.transactions[index]
                                                    .transactionAmount!,
                                        createdAt: trxCtrl
                                            .transactions[index].createdAt,
                                        balance: trxCtrl
                                            .transactions[index].postBalance,
                                        tfFee: trxCtrl
                                            .transactions[index].transactionFee,
                                        commission: trxCtrl
                                            .transactions[index].agentCut,
                                        incoming: trxCtrl
                                                    .transactions[index].type ==
                                                "CASH_OUT" ||
                                            trxCtrl.transactions[index].type ==
                                                "WALLET_TOP_UP",
                                        successful:
                                            trxCtrl.status == 'successful',
                                        narration: trxCtrl.transactions[index]
                                                        .type ==
                                                    "DEPOSIT" ||
                                                trxCtrl.transactions[index]
                                                        .type ==
                                                    "FUNDS_TRANSFER" ||
                                                trxCtrl.transactions[index]
                                                        .type ==
                                                    "WALLET_TOP_UP"
                                            ? trxCtrl
                                                .transactions[index].narration
                                            : trxCtrl.transactions[index]
                                                        .type ==
                                                    "BILLS_PAYMENT"
                                                ? trxCtrl.transactions[index]
                                                    .billerPackage
                                                : trxCtrl.transactions[index]
                                                            .type ==
                                                        "AIRTIME_VTU"
                                                    ? trxCtrl
                                                        .transactions[index]
                                                        .billerPackage
                                                    : trxCtrl
                                                        .transactions[index]
                                                        .transactionID,
                                      ));
                                }))
                            : trxCtrl.loading.value
                                ? Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 0.w),
                                    child: buildShimmer(10),
                                  )
                                : Center(
                                    child: Text(
                                      "You have no transaction!",
                                      style: TextStyle(
                                          color: AppColors.primaryColor),
                                    ),
                                  ))))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
