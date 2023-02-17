import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/send-money/view/send_money_summary.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';

import '../../../public/widgets/custom_button.dart';
import '../../../public/widgets/custom_text_form_field.dart';

class TransactionDetailsScreen extends StatelessWidget {
  const TransactionDetailsScreen({super.key});

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
              CustomTextFormField(
                label: "Enter Amount",
                // hintText: "Your Email",
                fillColor: isDarkMode
                    ? AppColors.inputBackgroundColor
                    : AppColors.grey,
              ),
              CustomTextFormField(
                label: "Purpose",
                // hintText: "Your Email",
                fillColor: isDarkMode
                    ? AppColors.inputBackgroundColor
                    : AppColors.grey,
              ),
              CustomTextFormField(
                label: "Schedule this payment",
                // hintText: "Your Email",
                fillColor: isDarkMode
                    ? AppColors.inputBackgroundColor
                    : AppColors.grey,
              ),
              addVerticalSpace(300.h),
              Row(
                children: [
                  Container(
                    width: 190.w,
                    child: CustomButton(
                        title: "Continue",
                        onTap: () {
                          Get.to(() => SendMoneySummaryScreen());
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
}
