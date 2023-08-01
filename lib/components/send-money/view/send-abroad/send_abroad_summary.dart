import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sprout_mobile/components/send-money/view/send-abroad/send_abroad_pin_confirmation.dart';
import 'package:sprout_mobile/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/utils/app_colors.dart';
import 'package:sprout_mobile/utils/helper_widgets.dart';
import 'package:sprout_mobile/utils/nav_function.dart';

// ignore: must_be_immutable
class SendAbroadSummaryScreen extends StatelessWidget {
  String? source, name, number;
  double? amount;
  SendAbroadSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              Text(
                "Summary",
                style: TextStyle(
                    fontFamily: "Mont",
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? AppColors.white : Color(0xFF0D0D0D)),
              ),
              addVerticalSpace(6.h),
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
                            "You're sending:",
                            style: titleStyle(),
                          ),
                          Text(
                            "100,000 NGN",
                            style: detailStyle(isDarkMode),
                          )
                        ],
                      ),
                      addVerticalSpace(20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Exchange rate:",
                            style: titleStyle(),
                          ),
                          Text(
                            "800 USD",
                            style: detailStyle(isDarkMode),
                          )
                        ],
                      ),
                      addVerticalSpace(20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Our fees:",
                            style: titleStyle(),
                          ),
                          Text(
                            "0.00",
                            style: detailStyle(isDarkMode),
                          )
                        ],
                      ),
                      addVerticalSpace(20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Beneficiary will receive:",
                            style: titleStyle(),
                          ),
                          Text(
                            "120 USD",
                            style: detailStyle(isDarkMode),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              addVerticalSpace(15.h),
              Text(
                "Beneficiary details",
                style: TextStyle(
                    fontFamily: "Mont",
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? AppColors.white : Color(0xFF0D0D0D)),
              ),
              addVerticalSpace(6.h),
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
                            "Beneficiary name:",
                            style: titleStyle(),
                          ),
                          Text(
                            "Peter Obi",
                            style: detailStyle(isDarkMode),
                          )
                        ],
                      ),
                      addVerticalSpace(20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "IBAN/Account number:",
                            style: titleStyle(),
                          ),
                          Text(
                            "2222222222",
                            style: detailStyle(isDarkMode),
                          )
                        ],
                      ),
                      addVerticalSpace(20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "SWIFT/BIC Code:",
                            style: titleStyle(),
                          ),
                          Text(
                            "014466",
                            style: detailStyle(isDarkMode),
                          )
                        ],
                      ),
                      addVerticalSpace(20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Bank name:",
                            style: titleStyle(),
                          ),
                          Text(
                            "Monzo",
                            style: detailStyle(isDarkMode),
                          )
                        ],
                      ),
                      addVerticalSpace(20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Category:",
                            style: titleStyle(),
                          ),
                          Text(
                            "Individual",
                            style: detailStyle(isDarkMode),
                          )
                        ],
                      ),
                      addVerticalSpace(20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Country:",
                            style: titleStyle(),
                          ),
                          Text(
                            "United Kingdom (UK)",
                            style: detailStyle(isDarkMode),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              addVerticalSpace(36.h),
              DecisionButton(
                isDarkMode: isDarkMode,
                buttonText: "Send Money",
                onTap: () {
                  push(page: SendAbroadPinPage());
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
