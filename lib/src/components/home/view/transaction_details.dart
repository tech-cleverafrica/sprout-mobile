import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/home/controller/transaction_details_controller.dart';
import 'package:sprout_mobile/src/public/widgets/custom_button.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

import '../../../public/widgets/general_widgets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/helper_widgets.dart';

// ignore: must_be_immutable
class TransactionDetailsScreen extends StatelessWidget {
  TransactionDetailsScreen({super.key});

  late TransactionDetailsController tDs;

  var oCcy = new NumberFormat("#,##0.00", "en_US");

  String joinFirst(String string) {
    List<String> stringArr = string.split("_");
    String finalString = "";
    for (var i = 0; i < stringArr.length; i++) {
      if (i == 2 && isNumeric(stringArr[1]) && isNumeric(stringArr[2])) {
        finalString = finalString + "." + stringArr[i];
      } else {
        finalString = finalString + " " + stringArr[i];
      }
    }
    return finalString;
  }

  bool isNumeric(String s) {
    if (s == "") {
      return false;
    }
    return double.tryParse(s) != null;
  }

  DateTime localDate(String date) {
    return DateTime.parse(date).toLocal();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    tDs = Get.put(TransactionDetailsController());
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(left: 24, right: 24, bottom: 24),
          child: Row(
            children: [
              Container(
                width: 246.w,
                child: CustomButton(title: "Go Back", onTap: () => pop()),
              ),
              addHorizontalSpace(8.w),
              Expanded(
                  child: InkWell(
                onTap: () =>
                    tDs.shareReceipt(tDs.transaction.value?.type ?? ""),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: AppColors.inputBackgroundColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(child: SvgPicture.asset(AppSvg.share)),
                ),
              ))
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getHeader(isDarkMode),
              addVerticalSpace(15.h),
              Obx((() => Container(
                    decoration: BoxDecoration(
                        color:
                            isDarkMode ? AppColors.greyDot : AppColors.greyBg,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Transaction Amount:",
                                style: titleStyle(),
                              ),
                              tDs.transaction.value?.type == "WALLET_TOP_UP" ||
                                      tDs.transaction.value?.type == "DEBIT"
                                  ? value(
                                      isDarkMode,
                                      "₦ " +
                                          oCcy.format(double.parse(tDs
                                                  .transaction
                                                  .value
                                                  ?.totalAmount
                                                  .toString() ??
                                              "")),
                                      context)
                                  : value(
                                      isDarkMode,
                                      "₦ " +
                                          oCcy.format(double.parse(tDs
                                                  .transaction
                                                  .value
                                                  ?.transactionAmount
                                                  .toString() ??
                                              "")),
                                      context),
                            ],
                          ),
                          addVerticalSpace(30.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Transaction Type:",
                                style: titleStyle(),
                              ),
                              value(
                                  isDarkMode,
                                  tDs.transaction.value?.type == "BILLS_PAYMENT"
                                      ? "BILLS PAYMENT"
                                      : tDs.transaction.value?.type ==
                                              "FUNDS_TRANSFER"
                                          ? "FUNDS TRANSFER"
                                          : tDs.transaction.value?.type ==
                                                  "CASH_OUT"
                                              ? "POS WITHDRAWAL"
                                              : tDs.transaction.value?.type ==
                                                      "WALLET_TOP_UP"
                                                  ? "WALLET TOP UP"
                                                  : tDs.transaction.value
                                                              ?.type ==
                                                          "AIRTIME_VTU"
                                                      ? "AIRTIME VTU"
                                                      : "DEBIT",
                                  context),
                            ],
                          ),
                          tDs.transaction.value?.type == "BILLS_PAYMENT"
                              ? addVerticalSpace(30.h)
                              : addVerticalSpace(0.h),
                          tDs.transaction.value?.type == "BILLS_PAYMENT"
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Bundle:",
                                      style: titleStyle(),
                                    ),
                                    value(
                                        isDarkMode,
                                        tDs.transaction.value?.group == "DATA"
                                            ? joinFirst(
                                                tDs.transaction.value?.bundle ??
                                                    "")
                                            : tDs.transaction.value?.bundle !=
                                                    null
                                                ? tDs.transaction.value?.bundle!
                                                    .split("_")
                                                    .join(" ")
                                                : "-",
                                        context),
                                  ],
                                )
                              : addVerticalSpace(0.h),
                          tDs.transaction.value?.type == "AIRTIME_VTU"
                              ? addVerticalSpace(30.h)
                              : addVerticalSpace(0.h),
                          tDs.transaction.value?.type == "AIRTIME_VTU"
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Network Provider:",
                                      style: titleStyle(),
                                    ),
                                    value(
                                        isDarkMode,
                                        tDs.transaction.value?.serviceType !=
                                                null
                                            ? tDs
                                                .transaction.value?.serviceType!
                                                .split("_")
                                                .join(" ")
                                            : "...",
                                        context),
                                  ],
                                )
                              : addVerticalSpace(0.h),
                          addVerticalSpace(30.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Transaction Date:",
                                style: titleStyle(),
                              ),
                              value(
                                  isDarkMode,
                                  DateFormat('dd/MM/yyyy \t\t h:mma').format(
                                      localDate(
                                          tDs.transaction.value?.createdAt ??
                                              "")),
                                  context),
                            ],
                          ),
                          tDs.transaction.value?.type != "FUNDS_TRANSFER"
                              ? addVerticalSpace(30.h)
                              : addVerticalSpace(0.h),
                          tDs.transaction.value?.type != "FUNDS_TRANSFER"
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Transaction Fee",
                                      style: titleStyle(),
                                    ),
                                    tDs.transaction.value?.type != "CASH_OUT" &&
                                            tDs.transaction.value?.type !=
                                                "WALLET_TOP_UP"
                                        ? value(
                                            isDarkMode,
                                            tDs.transaction.value?.transactionFee !=
                                                    null
                                                ? "₦ " +
                                                    double.parse(tDs.transaction.value?.transactionFee.toString() ?? "0.00")
                                                        .toStringAsFixed(2)
                                                : "₦ 0.0",
                                            context)
                                        : value(
                                            isDarkMode,
                                            tDs.transaction.value
                                                        ?.transactionFee !=
                                                    null
                                                ? "₦ " +
                                                    double.parse(tDs
                                                                .transaction
                                                                .value
                                                                ?.transactionFee
                                                                .toString() ??
                                                            "0.00")
                                                        .toStringAsFixed(2)
                                                : "-",
                                            context),
                                  ],
                                )
                              : addVerticalSpace(0.h),
                          tDs.transaction.value?.type == "DEBIT"
                              ? addVerticalSpace(30.h)
                              : addVerticalSpace(0.h),
                          tDs.transaction.value?.type == "DEBIT"
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Wallet Balance:",
                                      style: titleStyle(),
                                    ),
                                    value(
                                        isDarkMode,
                                        tDs.transaction.value?.postBalance !=
                                                null
                                            ? "₦ " +
                                                double.parse(tDs.transaction
                                                            .value?.postBalance
                                                            .toString() ??
                                                        "0.00")
                                                    .toStringAsFixed(2)
                                            : "0.00",
                                        context),
                                  ],
                                )
                              : addVerticalSpace(0.h),
                          tDs.transaction.value?.type != "DEBIT"
                              ? Column(
                                  children: [
                                    tDs.transaction.value?.type ==
                                                "BILLS_PAYMENT" ||
                                            tDs.transaction.value?.type ==
                                                "AIRTIME_VTU"
                                        ? addVerticalSpace(30.h)
                                        : addVerticalSpace(0.h),
                                    tDs.transaction.value?.type ==
                                                "BILLS_PAYMENT" ||
                                            tDs.transaction.value?.type ==
                                                "AIRTIME_VTU"
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Commission:",
                                                style: titleStyle(),
                                              ),
                                              value(
                                                  isDarkMode,
                                                  tDs.transaction.value
                                                              ?.agentCut !=
                                                          null.toString()
                                                      ? "₦ " +
                                                          double.parse(tDs
                                                                      .transaction
                                                                      .value
                                                                      ?.agentCut
                                                                      .toString() ??
                                                                  "0.00")
                                                              .toStringAsFixed(
                                                                  2)
                                                      : "0.00",
                                                  context),
                                            ],
                                          )
                                        : addVerticalSpace(0.h),
                                  ],
                                )
                              : addVerticalSpace(0.h),
                          tDs.transaction.value?.type == "AIRTIME_VTU"
                              ? addVerticalSpace(30.h)
                              : addVerticalSpace(0.h),
                          tDs.transaction.value?.type == "AIRTIME_VTU"
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Phone Number:",
                                      style: titleStyle(),
                                    ),
                                    value(
                                        isDarkMode,
                                        tDs.transaction.value?.phoneNumber,
                                        context),
                                  ],
                                )
                              : addVerticalSpace(0.h),
                          tDs.transaction.value?.type != "CASH_OUT" &&
                                  tDs.transaction.value?.type !=
                                      "WALLET_TOP_UP" &&
                                  tDs.transaction.value?.type !=
                                      "AIRTIME_VTU" &&
                                  tDs.transaction.value?.type != "DEBIT"
                              ? addVerticalSpace(30.h)
                              : addVerticalSpace(0.h),
                          tDs.transaction.value?.type != "CASH_OUT" &&
                                  tDs.transaction.value?.type !=
                                      "WALLET_TOP_UP" &&
                                  tDs.transaction.value?.type !=
                                      "AIRTIME_VTU" &&
                                  tDs.transaction.value?.type != "DEBIT"
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      tDs.transaction.value?.type ==
                                              'BILLS_PAYMENT'
                                          ? tDs.transaction.value?.group ==
                                                  "CABLE"
                                              ? "Smartcard Number"
                                              : tDs.transaction.value?.group ==
                                                          "DISCO" ||
                                                      tDs.transaction.value
                                                              ?.group ==
                                                          'ELECTRIC_DISCO'
                                                  ? "Meter Number"
                                                  : tDs.transaction.value
                                                              ?.group ==
                                                          "DATA"
                                                      ? "Phone Number"
                                                      : tDs.transaction.value
                                                                  ?.group ==
                                                              "BETTING"
                                                          ? "User ID"
                                                          : tDs.transaction.value
                                                                      ?.group ==
                                                                  "UTILITY_PAYMENT"
                                                              ? "Card Number"
                                                              : "Account Number"
                                          : 'Account Number',
                                      style: titleStyle(),
                                    ),
                                    value(
                                        isDarkMode,
                                        tDs.transaction.value?.type ==
                                                'BILLS_PAYMENT'
                                            ? tDs.transaction.value?.group ==
                                                    "CABLE"
                                                ? tDs.transaction.value
                                                    ?.smartCardNumber
                                                : tDs.transaction.value
                                                                ?.group ==
                                                            "DISCO" ||
                                                        tDs.transaction.value
                                                                ?.group ==
                                                            'ELECTRIC_DISCO'
                                                    ? tDs.transaction.value
                                                        ?.accountNumber
                                                    : tDs.transaction.value
                                                                ?.group ==
                                                            "DATA"
                                                        ? tDs.transaction.value
                                                            ?.phoneNumber
                                                        : tDs.transaction.value
                                                                    ?.group ==
                                                                "BETTING"
                                                            ? tDs
                                                                .transaction
                                                                .value
                                                                ?.phoneNumber
                                                            : tDs.transaction.value
                                                                        ?.group ==
                                                                    "UTILITY_PAYMENT"
                                                                ? tDs
                                                                    .transaction
                                                                    .value
                                                                    ?.phoneNumber
                                                                : tDs
                                                                    .transaction
                                                                    .value
                                                                    ?.phoneNumber
                                            : tDs.transaction.value
                                                ?.beneficiaryAccountNumber,
                                        context),
                                  ],
                                )
                              : addVerticalSpace(0.h),
                          tDs.transaction.value?.type != "CASH_OUT" &&
                                  tDs.transaction.value?.type !=
                                      "BILLS_PAYMENT" &&
                                  tDs.transaction.value?.type !=
                                      "WALLET_TOP_UP" &&
                                  tDs.transaction.value?.type !=
                                      "AIRTIME_VTU" &&
                                  tDs.transaction.value?.type != "DEBIT"
                              ? addVerticalSpace(30.h)
                              : addVerticalSpace(0.h),
                          tDs.transaction.value?.type != "CASH_OUT" &&
                                  tDs.transaction.value?.type !=
                                      "BILLS_PAYMENT" &&
                                  tDs.transaction.value?.type !=
                                      "WALLET_TOP_UP" &&
                                  tDs.transaction.value?.type !=
                                      "AIRTIME_VTU" &&
                                  tDs.transaction.value?.type != "DEBIT"
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Beneficiary Bank:",
                                      style: titleStyle(),
                                    ),
                                    value(
                                        isDarkMode,
                                        tDs.transaction.value
                                            ?.beneficiaryBankName,
                                        context),
                                  ],
                                )
                              : addVerticalSpace(0.h),
                          tDs.transaction.value?.type == "WALLET_TOP_UP"
                              ? Column(
                                  children: [
                                    addVerticalSpace(30.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Sender's Account Number:",
                                          style: titleStyle(),
                                        ),
                                        value(
                                            isDarkMode,
                                            tDs.transaction.value
                                                ?.originatorAccountNumber,
                                            context,
                                            customSize: 0.4),
                                      ],
                                    ),
                                    addVerticalSpace(30.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Sender's Name:",
                                          style: titleStyle(),
                                        ),
                                        value(
                                            isDarkMode,
                                            tDs.transaction.value
                                                ?.originatorName,
                                            context),
                                      ],
                                    ),
                                    addVerticalSpace(30.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Sender's Bank:",
                                          style: titleStyle(),
                                        ),
                                        value(
                                            isDarkMode,
                                            tDs.transaction.value?.bankName,
                                            context),
                                      ],
                                    ),
                                  ],
                                )
                              : addVerticalSpace(0.h),
                          addVerticalSpace(30.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Transaction Ref:",
                                style: titleStyle(),
                              ),
                              value(
                                  isDarkMode,
                                  tDs.transaction.value?.transactionID,
                                  context),
                            ],
                          ),
                          tDs.transaction.value?.type == "FUNDS_TRANSFER"
                              ? addVerticalSpace(30.h)
                              : addVerticalSpace(0.h),
                          tDs.transaction.value?.type == "FUNDS_TRANSFER"
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Session ID:",
                                      style: titleStyle(),
                                    ),
                                    value(
                                        isDarkMode,
                                        tDs.transaction.value?.sessionID,
                                        context),
                                  ],
                                )
                              : addVerticalSpace(0.h),
                          tDs.transaction.value?.type != "AIRTIME_VTU" &&
                                  tDs.transaction.value?.type != "DEBIT"
                              ? Column(
                                  children: [
                                    tDs.transaction.value?.type != "CASH_OUT" &&
                                            tDs.transaction.value?.type !=
                                                "AIRTIME_VTU"
                                        ? addVerticalSpace(30.h)
                                        : addVerticalSpace(30.h),
                                    tDs.transaction.value?.type != "CASH_OUT"
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Narration:",
                                                style: titleStyle(),
                                              ),
                                              value(
                                                  isDarkMode,
                                                  tDs.transaction.value
                                                      ?.narration,
                                                  context),
                                            ],
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "RRN:",
                                                style: titleStyle(),
                                              ),
                                              value(
                                                  isDarkMode,
                                                  tDs.transaction.value?.rrn,
                                                  context)
                                            ],
                                          ),
                                  ],
                                )
                              : addVerticalSpace(0.h),
                          tDs.transaction.value?.type == "DEBIT"
                              ? Column(
                                  children: [
                                    addVerticalSpace(30.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Comment:",
                                          style: titleStyle(),
                                        ),
                                        value(
                                            isDarkMode,
                                            tDs.transaction.value?.narration,
                                            context),
                                      ],
                                    ),
                                  ],
                                )
                              : addVerticalSpace(0.h),
                          addVerticalSpace(30.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Status:",
                                style: titleStyle(),
                              ),
                              value(
                                  isDarkMode,
                                  tDs.transaction.value?.responseMessage
                                      ?.toString()
                                      .toUpperCase(),
                                  context)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ))),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle titleStyle() {
    return TextStyle(
        fontFamily: "Mont",
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.inputLabelColor);
  }

  TextStyle detailStyle(isDark) {
    return TextStyle(
        fontFamily: "Mont",
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
        color: isDark ? AppColors.grey : AppColors.black);
  }

  Container value(isDarkMode, String? value, BuildContext context,
      {double customSize = 0.48}) {
    return Container(
      width: MediaQuery.of(context).size.width * customSize,
      child: Text(
        value ?? "",
        style: detailStyle(isDarkMode),
        textAlign: TextAlign.right,
      ),
    );
  }
}
