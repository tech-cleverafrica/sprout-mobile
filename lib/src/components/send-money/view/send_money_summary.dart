import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sprout_mobile/src/utils/global_function.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

import '../../../public/screens/pin_confirmation.dart';
import '../../../public/widgets/custom_button.dart';
import '../../../public/widgets/general_widgets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/helper_widgets.dart';

class SendMoneySummaryScreen extends StatelessWidget {
  String? source, name, number;
  double? amount;
  SendMoneySummaryScreen(
      {super.key,
      required this.source,
      required this.name,
      required this.number,
      required this.amount});

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getHeader(isDarkMode),
              addVerticalSpace(15.h),
              Container(
                decoration: BoxDecoration(
                    color: isDarkMode ? AppColors.greyDot : AppColors.greyBg,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Account Source:",
                            style: titleStyle(),
                          ),
                          Text(
                            source!,
                            style: detailStyle(isDarkMode),
                          )
                        ],
                      ),
                      addVerticalSpace(20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Account Name:",
                            style: titleStyle(),
                          ),
                          Text(
                            name!,
                            style: detailStyle(isDarkMode),
                          )
                        ],
                      ),
                      addVerticalSpace(20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Account Number:",
                            style: titleStyle(),
                          ),
                          Text(
                            number!,
                            style: detailStyle(isDarkMode),
                          )
                        ],
                      ),
                      addVerticalSpace(20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Amount:",
                            style: titleStyle(),
                          ),
                          Text(
                            amount.toString(),
                            style: detailStyle(isDarkMode),
                          )
                        ],
                      ),
                      addVerticalSpace(20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Date",
                            style: titleStyle(),
                          ),
                          Text(
                            "${DateFormat.yMMMMd().format(now)} at ${DateFormat.jm().format(now)}",
                            style: detailStyle(isDarkMode),
                          )
                        ],
                      ),
                      addVerticalSpace(20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Charges:",
                            style: titleStyle(),
                          ),
                          Text(
                            currencySymbol + "20.00",
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: "Outfit",
                                fontWeight: FontWeight.w700,
                                color: AppColors.errorRed),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              addVerticalSpace(16.h),
              Text(
                  "Please ensure the details entered are correct before proceeding with this transfer as Clever Digital Ltd will not be responsible for recall of funds transferred in error. Thank You.",
                  style: TextStyle(
                    fontFamily: "DMSans",
                    color: isDarkMode
                        ? AppColors.mainGreen
                        : AppColors.primaryColor,
                  )),
              addVerticalSpace(36.h),
              DecisionButton(
                isDarkMode: isDarkMode,
                buttonText: "Send Money",
                onTap: () {
                  push(page: PinPage(process: "transfer"));
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  TextStyle titleStyle() {
    return TextStyle(
        fontFamily: "DMSans",
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.inputLabelColor);
  }

  TextStyle detailStyle(isDark) {
    return TextStyle(
        fontFamily: "DMSans",
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
        color: isDark ? AppColors.mainGreen : AppColors.primaryColor);
  }
}
