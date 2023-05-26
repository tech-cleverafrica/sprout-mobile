import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sprout_mobile/components/save/controller/savings_details_controller.dart';
import 'package:sprout_mobile/components/save/view/top_up_savings.dart';
import 'package:sprout_mobile/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/utils/global_function.dart';
import 'package:sprout_mobile/utils/helper_widgets.dart';
import 'package:sprout_mobile/utils/nav_function.dart';

import '../../../utils/app_colors.dart';

DateTime localDate(String date) {
  return DateTime.parse(date).toLocal();
}

// ignore: must_be_immutable
class SavingsDetailsScreen extends StatelessWidget {
  SavingsDetailsScreen({super.key});

  late SavingsDetailsController savingsDetailsController;
  var f = NumberFormat('#,##0.00########', 'en_Us');

  @override
  Widget build(BuildContext context) {
    savingsDetailsController = Get.put(SavingsDetailsController());
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getHeader(isDarkMode),
              addVerticalSpace(16.h),
              Obx((() => Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: isDarkMode
                                      ? AppColors.greyDot
                                      : AppColors.grey),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8, bottom: 8, right: 10, left: 10),
                                  child: Text(
                                    savingsDetailsController
                                        .savings.value!.status!,
                                    style: TextStyle(
                                        fontFamily: "Mont",
                                        fontSize: 12.sp,
                                        color: isDarkMode
                                            ? AppColors.white
                                            : AppColors.primaryColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                            savingsDetailsController.savings.value!.type ==
                                    "LOCKED"
                                ? Row(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          push(
                                              page: TopUpSavingsScreen(),
                                              arguments:
                                                  savingsDetailsController
                                                      .savings.value);
                                        },
                                        child: Container(
                                            height: 32.h,
                                            decoration: BoxDecoration(
                                                color: isDarkMode
                                                    ? AppColors.mainGreen
                                                    : AppColors.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Top Up Savings",
                                                      style: TextStyle(
                                                          fontFamily: "Mont",
                                                          fontSize: 12.sp,
                                                          color:
                                                              AppColors.white,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    )
                                                  ]),
                                            )),
                                      ),
                                    ],
                                  )
                                : SizedBox()
                          ],
                        ),
                      ),
                      addVerticalSpace(20.h),
                      Container(
                        decoration: BoxDecoration(
                          color:
                              isDarkMode ? AppColors.greyDot : AppColors.greyBg,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Summary",
                                style: TextStyle(
                                    fontFamily: "Mont",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.sp,
                                    color: isDarkMode
                                        ? AppColors.white
                                        : AppColors.black),
                              ),
                              addVerticalSpace(20.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Amount",
                                    style: TextStyle(
                                        color: isDarkMode
                                            ? AppColors.white
                                            : AppColors.black),
                                  ),
                                  Text(
                                      "$currencySymbol${f.format((savingsDetailsController.savings.value!.currentAmount! + savingsDetailsController.savings.value!.interestAccrued!).toDouble())}",
                                      style: theme.textTheme.headline6),
                                ],
                              ),
                              addVerticalSpace(10.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Interest Accrued",
                                      style: TextStyle(
                                          color: isDarkMode
                                              ? AppColors.white
                                              : AppColors.black)),
                                  Text(
                                      "$currencySymbol${f.format(savingsDetailsController.savings.value!.interestAccrued!.toDouble())}",
                                      style: theme.textTheme.headline6),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      addVerticalSpace(10.h),
                      Container(
                        decoration: BoxDecoration(
                            color: isDarkMode
                                ? AppColors.greyDot
                                : AppColors.greyBg,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              savingsDetailsController.savings.value!.type ==
                                      "TARGET"
                                  ? Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Target Amount:",
                                              style: titleStyle(),
                                            ),
                                            Text(
                                              "$currencySymbol${savingsDetailsController.formatter.formatAsMoney(savingsDetailsController.savings.value!.targetAmount!.toDouble())}",
                                              style: detailStyle(isDarkMode),
                                            )
                                          ],
                                        ),
                                        addVerticalSpace(20.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Recurring Amount:",
                                              style: titleStyle(),
                                            ),
                                            Text(
                                              "$currencySymbol${savingsDetailsController.formatter.formatAsMoney(savingsDetailsController.savings.value!.startAmount!.toDouble())}",
                                              style: detailStyle(isDarkMode),
                                            )
                                          ],
                                        ),
                                        addVerticalSpace(20.h),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Savings Amount:",
                                              style: titleStyle(),
                                            ),
                                            Text(
                                              "$currencySymbol${savingsDetailsController.formatter.formatAsMoney(savingsDetailsController.savings.value!.targetAmount!.toDouble())}",
                                              style: detailStyle(isDarkMode),
                                            )
                                          ],
                                        ),
                                        addVerticalSpace(20.h),
                                      ],
                                    ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Interest Rate:",
                                    style: titleStyle(),
                                  ),
                                  Text(
                                    savingsDetailsController
                                                .savings.value!.interestRate !=
                                            null
                                        ? savingsDetailsController
                                                .savings.value!.tenure
                                                .toString() +
                                            (savingsDetailsController.savings
                                                        .value!.tenure! >
                                                    1
                                                ? " days at "
                                                : " day at") +
                                            savingsDetailsController
                                                .savings.value!.interestRate
                                                .toString() +
                                            "% per annum"
                                        : "-",
                                    style: detailStyle(isDarkMode),
                                  )
                                ],
                              ),
                              addVerticalSpace(20.h),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Estimated Interest:",
                                        style: titleStyle(),
                                      ),
                                      Text(
                                        savingsDetailsController.savings.value!
                                                    .expectedInterest !=
                                                null
                                            ? "$currencySymbol${savingsDetailsController.formatter.formatAsMoney(savingsDetailsController.savings.value!.expectedInterest!.toDouble())}"
                                            : "-",
                                        style: detailStyle(isDarkMode),
                                      )
                                    ],
                                  ),
                                  addVerticalSpace(20.h),
                                ],
                              ),
                              savingsDetailsController.savings.value!.type ==
                                      "TARGET"
                                  ? Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Debit Frequency:",
                                              style: titleStyle(),
                                            ),
                                            Text(
                                              savingsDetailsController.savings
                                                  .value!.debitFrequency!,
                                              style: detailStyle(isDarkMode),
                                            )
                                          ],
                                        ),
                                        addVerticalSpace(20.h),
                                      ],
                                    )
                                  : SizedBox(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Source:",
                                    style: titleStyle(),
                                  ),
                                  Text(
                                    savingsDetailsController
                                        .savings.value!.source!,
                                    style: detailStyle(isDarkMode),
                                  )
                                ],
                              ),
                              addVerticalSpace(20.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Maturity Date:",
                                    style: titleStyle(),
                                  ),
                                  Text(
                                    savingsDetailsController
                                                .savings.value!.maturityDate !=
                                            null
                                        ? DateFormat('dd-MM-yyyy').format(
                                            localDate(savingsDetailsController
                                                .savings.value!.maturityDate!))
                                        : "-",
                                    style: detailStyle(isDarkMode),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
        fontWeight: FontWeight.w400,
        color: AppColors.inputLabelColor);
  }

  TextStyle detailStyle(isDark) {
    return TextStyle(
        fontFamily: "Mont",
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: isDark ? AppColors.white : Color(0xFF0D0D0D));
  }
}
