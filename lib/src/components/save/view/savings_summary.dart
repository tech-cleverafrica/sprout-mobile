import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/public/screens/successful_transaction.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';

import '../../../utils/app_colors.dart';

class SavingsSummaryScreen extends StatelessWidget {
  const SavingsSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              addVerticalSpace(15.sp),
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
                            "Amount:",
                            style: titleStyle(),
                          ),
                          Text(
                            "N21,000",
                            style: detailStyle(isDarkMode),
                          )
                        ],
                      ),
                      addVerticalSpace(20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Interest Rate:",
                            style: titleStyle(),
                          ),
                          Text(
                            "N53.4",
                            style: detailStyle(isDarkMode),
                          )
                        ],
                      ),
                      addVerticalSpace(20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Maturity Period:",
                            style: titleStyle(),
                          ),
                          Text(
                            "1 Month",
                            style: detailStyle(isDarkMode),
                          )
                        ],
                      ),
                      addVerticalSpace(20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Payment Type:",
                            style: titleStyle(),
                          ),
                          Text(
                            "Wallet",
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
                            "22/08/2023",
                            style: detailStyle(isDarkMode),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              addVerticalSpace(26.h),
              Row(
                children: [
                  Checkbox(value: false, onChanged: (val) {}),
                  Expanded(
                      child: Text(
                          "By checking this box, I agree that I have read and understod the terms and conditions set forth in. Read more",
                          style: TextStyle(
                              fontFamily: "DMSans",
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
                    Get.to(() => SuccessfultransactionScreen());
                  })
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
        fontWeight: FontWeight.w400,
        color: AppColors.inputLabelColor);
  }

  TextStyle detailStyle(isDark) {
    return TextStyle(
        fontFamily: "DMSans",
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: isDark ? AppColors.white : Color(0xFF0D0D0D));
  }
}
