import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sprout_mobile/components/save/controller/savings_summary_controller.dart';
import 'package:sprout_mobile/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/utils/global_function.dart';
import 'package:sprout_mobile/utils/helper_widgets.dart';

import '../../../utils/app_colors.dart';

DateTime localDate(String date) {
  return DateTime.parse(date).toLocal();
}

// ignore: must_be_immutable
class SavingsSummaryScreen extends StatelessWidget {
  SavingsSummaryScreen({super.key});

  late SavingsSummaryController savingsSummaryController;

  @override
  Widget build(BuildContext context) {
    savingsSummaryController = Get.put(SavingsSummaryController());
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getHeader(isDarkMode),
              addVerticalSpace(15.sp),
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
                          savingsSummaryController.summary.value!.data!.type ==
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
                                          "$currencySymbol${savingsSummaryController.formatter.formatAsMoney(savingsSummaryController.summary.value!.data!.savingsAmount!.toDouble())}",
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
                                          "$currencySymbol${savingsSummaryController.formatter.formatAsMoney(double.parse(savingsSummaryController.createSavingsController.startingAmountController.text.split(",").join()))}",
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
                                          "$currencySymbol${savingsSummaryController.formatter.formatAsMoney(savingsSummaryController.summary.value!.data!.savingsAmount!.toDouble())}",
                                          style: detailStyle(isDarkMode),
                                        )
                                      ],
                                    ),
                                    addVerticalSpace(20.h),
                                  ],
                                ),
                          savingsSummaryController.summary.value!.data!.type ==
                                  "TARGET"
                              ? Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Tenure:",
                                          style: titleStyle(),
                                        ),
                                        Text(
                                          savingsSummaryController
                                                      .summary
                                                      .value!
                                                      .data!
                                                      .interestRate !=
                                                  null
                                              ? savingsSummaryController.summary
                                                      .value!.data!.tenure
                                                      .toString() +
                                                  (savingsSummaryController
                                                              .summary
                                                              .value!
                                                              .data!
                                                              .tenure! >
                                                          1
                                                      ? " days"
                                                      : " day")
                                              : "-",
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
                                          "Interest Rate:",
                                          style: titleStyle(),
                                        ),
                                        Text(
                                          savingsSummaryController
                                                      .summary
                                                      .value!
                                                      .data!
                                                      .interestRate !=
                                                  null
                                              ? savingsSummaryController
                                                      .summary
                                                      .value!
                                                      .data!
                                                      .interestRate!
                                                      .toString() +
                                                  "% per annum"
                                              : "-",
                                          style: detailStyle(isDarkMode),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              : Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Tenure:",
                                          style: titleStyle(),
                                        ),
                                        Text(
                                          savingsSummaryController
                                                      .summary
                                                      .value!
                                                      .data!
                                                      .interestRate !=
                                                  null
                                              ? savingsSummaryController.summary
                                                      .value!.data!.tenure
                                                      .toString() +
                                                  (savingsSummaryController
                                                              .summary
                                                              .value!
                                                              .data!
                                                              .tenure! >
                                                          1
                                                      ? " days"
                                                      : " day")
                                              : "-",
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
                                          "Interest Rate:",
                                          style: titleStyle(),
                                        ),
                                        Text(
                                          savingsSummaryController
                                                      .summary
                                                      .value!
                                                      .data!
                                                      .interestRate !=
                                                  null
                                              ? savingsSummaryController
                                                      .summary
                                                      .value!
                                                      .data!
                                                      .interestRate!
                                                      .toString() +
                                                  "% per annum"
                                              : "-",
                                          style: detailStyle(isDarkMode),
                                        )
                                      ],
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
                                    savingsSummaryController.summary.value!
                                                .data!.expectedInterestAmount !=
                                            null
                                        ? "$currencySymbol${savingsSummaryController.formatter.formatAsMoney(savingsSummaryController.summary.value!.data!.expectedInterestAmount!.toDouble())}"
                                        : "-",
                                    style: detailStyle(isDarkMode),
                                  )
                                ],
                              ),
                              addVerticalSpace(20.h),
                            ],
                          ),
                          savingsSummaryController.summary.value!.data!.type ==
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
                                          savingsSummaryController
                                              .createSavingsController
                                              .frequency
                                              .value,
                                          style: detailStyle(isDarkMode),
                                        )
                                      ],
                                    ),
                                    addVerticalSpace(20.h),
                                  ],
                                )
                              : SizedBox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Payment Type:",
                                style: titleStyle(),
                              ),
                              Text(
                                savingsSummaryController
                                    .createSavingsController.paymentType.value,
                                style: detailStyle(isDarkMode),
                              )
                            ],
                          ),
                          addVerticalSpace(20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Withdrawal Date:",
                                style: titleStyle(),
                              ),
                              Text(
                                savingsSummaryController
                                            .summary.value!.data!.endDate !=
                                        null
                                    ? DateFormat('dd-MM-yyyy').format(localDate(
                                        savingsSummaryController
                                            .summary.value!.data!.endDate!))
                                    : "-",
                                style: detailStyle(isDarkMode),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ))),
              addVerticalSpace(26.h),
              Row(
                children: [
                  Obx((() => Checkbox(
                      activeColor: AppColors.primaryColor,
                      value: savingsSummaryController.isChecked.value,
                      onChanged: (val) {
                        savingsSummaryController.isChecked.value = val ?? false;
                      }))),
                  Expanded(
                      child: Text(
                          "By checking this box, I agree that I have read and understood the terms and conditions and consent to the indemnity agreement.",
                          style: TextStyle(
                              fontFamily: "Mont",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: isDarkMode
                                  ? AppColors.white
                                  : AppColors.black)))
                ],
              ),
              addVerticalSpace(34.h),
              DecisionButton(
                  isDarkMode: isDarkMode,
                  buttonText: "Start Saving",
                  onTap: () {
                    savingsSummaryController.validateSavings();
                  })
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
