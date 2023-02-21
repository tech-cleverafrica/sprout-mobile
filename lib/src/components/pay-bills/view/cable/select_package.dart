import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/pay-bills/view/bills_summary.dart';
import 'package:sprout_mobile/src/public/widgets/custom_dropdown_button_field.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';

import '../../../../public/widgets/custom_button.dart';
import '../../../../public/widgets/custom_text_form_field.dart';

class SelectPackageScreen extends StatelessWidget {
  const SelectPackageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
            child: DecisionButton(
              isDarkMode: isDarkMode,
              buttonText: "Continue",
              onTap: () {
                Get.to(() => BillSummaryPage());
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getHeader(isDarkMode),
                  addVerticalSpace(15.h),
                  CustomDropdownButtonFormField(
                    items: [],
                    label: "Select Package",
                    // hintText: "Your Email",
                    fillColor: isDarkMode
                        ? AppColors.inputBackgroundColor
                        : AppColors.grey,
                  ),
                  CustomDropdownButtonFormField(
                    items: [],
                    label: "Smartcard Number",
                    // hintText: "Your Email",
                    fillColor: isDarkMode
                        ? AppColors.inputBackgroundColor
                        : AppColors.grey,
                  ),
                  CustomTextFormField(
                    label: "Automated Amount",
                    // hintText: "Your Email",
                    fillColor: isDarkMode
                        ? AppColors.inputBackgroundColor
                        : AppColors.grey,
                  ),
                  CustomDropdownButtonFormField(
                    items: [],
                    label: "Schedule This Payment",
                    // hintText: "Your Email",
                    fillColor: isDarkMode
                        ? AppColors.inputBackgroundColor
                        : AppColors.grey,
                  ),
                  addVerticalSpace(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Save this purchase",
                            style: TextStyle(
                                fontFamily: "DMSans",
                                fontSize: 13.sp,
                                color: isDarkMode
                                    ? AppColors.white
                                    : AppColors.black,
                                fontWeight: FontWeight.w700),
                          ),
                          addVerticalSpace(9.h),
                          Text(
                            "We will add it to your quick airtime purchase",
                            style: TextStyle(
                                fontFamily: "DMSans",
                                fontSize: 10.sp,
                                color: isDarkMode
                                    ? AppColors.semi_white.withOpacity(0.5)
                                    : AppColors.greyText,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      CupertinoSwitch(
                          activeColor: AppColors.primaryColor,
                          value: true,
                          onChanged: (value) {})
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
