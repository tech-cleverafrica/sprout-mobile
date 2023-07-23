import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sprout_mobile/components/send-money/view/send_money_pin_confirmation.dart';
import 'package:sprout_mobile/config/Config.dart';
import 'package:sprout_mobile/utils/global_function.dart';
import 'package:sprout_mobile/utils/nav_function.dart';

import '../../../public/widgets/general_widgets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/helper_widgets.dart';

// ignore: must_be_immutable
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
                            currencySymbol + TRANSFER_CHARGE,
                            style: detailStyle(isDarkMode),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              addVerticalSpace(16.h),
              Text(
                  "Please ensure the details entered are correct before proceeding with this transfer as $APP_COMPANY_NAME will not be responsible for recall of funds transferred in error. Thank You.",
                  style: TextStyle(
                    fontFamily: "Mont",
                    color: isDarkMode
                        ? AppColors.mainGreen
                        : AppColors.primaryColor,
                  )),
              addVerticalSpace(36.h),
              DecisionButton(
                isDarkMode: isDarkMode,
                buttonText: "Send Money",
                onTap: () {
                  push(page: SendMoneyPinPage());
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
        fontFamily: "Mont",
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.inputLabelColor);
  }

  TextStyle detailStyle(isDark) {
    return TextStyle(
        fontFamily: "Mont",
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: isDark ? AppColors.white : Color(0xFF0D0D0D));
  }
}
