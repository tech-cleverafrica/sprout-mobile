import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';

import '../../../public/screens/pin_confirmation.dart';
import '../../../public/widgets/custom_button.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/helper_widgets.dart';

class BillSummaryPage extends StatelessWidget {
  const BillSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
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
                            "Transaction charge:",
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
                            "Package",
                            style: titleStyle(),
                          ),
                          Text(
                            "GOTV/COMPACT/MONT",
                            style: detailStyle(isDarkMode),
                          )
                        ],
                      ),
                      addVerticalSpace(20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Smartcard Numbre",
                            style: titleStyle(),
                          ),
                          Text(
                            "00897857485968958",
                            style: detailStyle(isDarkMode),
                          )
                        ],
                      ),
                      addVerticalSpace(20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Customer name:",
                            style: titleStyle(),
                          ),
                          Text(
                            "John Doe",
                            style: detailStyle(isDarkMode),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              addVerticalSpace(36.h),
              Row(
                children: [
                  Container(
                    width: 246.w,
                    child: CustomButton(
                        title: "Send Money",
                        onTap: () {
                          Get.to(() => PinPage());
                        }),
                  ),
                  addHorizontalSpace(8.w),
                  Expanded(
                      child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: isDarkMode
                            ? AppColors.inputBackgroundColor
                            : AppColors.black,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "Go Back",
                        style: TextStyle(
                            fontFamily: "DMSans", color: AppColors.white),
                      ),
                    ),
                  ))
                ],
              ),
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
