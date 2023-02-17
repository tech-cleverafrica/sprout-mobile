import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/buy-airtime/view/buy-airtime.dart';
import 'package:sprout_mobile/src/public/screens/pin_confirmation.dart';
import 'package:sprout_mobile/src/public/widgets/custom_dropdown_button_field.dart';
import 'package:sprout_mobile/src/public/widgets/custom_text_form_field.dart';

import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';

import '../../../public/widgets/custom_button.dart';
import '../../../utils/app_colors.dart';

class SelectNetworkScreen extends StatelessWidget {
  const SelectNetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getHeader(isDarkMode),
                addVerticalSpace(15.h),
                CustomDropdownButtonFormField(
                  label: "Select Network",
                  // hintText: "Your Email",
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                  items: [],
                ),
                CustomTextFormField(
                  label: "Phone number",
                  // hintText: "Your Email",
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                ),
                CustomTextFormField(
                  label: "Amount",
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
                        Text(
                          "We will add it to your quick airtime purchase",
                          style: TextStyle(
                              fontFamily: "DMSans",
                              fontSize: 10.sp,
                              color: isDarkMode
                                  ? AppColors.greyText
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
                addVerticalSpace(20.h),
                Row(
                  children: [
                    Container(
                      width: 190.w,
                      child: CustomButton(
                        title: "Buy Airtime",
                        onTap: () {
                          Get.to(() => PinPage());
                        },
                      ),
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
                Text(
                  "Wallet Balance: N23,452.00",
                  style: TextStyle(
                      fontFamily: "DMSans",
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? AppColors.white : AppColors.black,
                      fontSize: 12.sp),
                ),
                addVerticalSpace(20.h),
                Text(
                  "Send airtime to",
                  style: TextStyle(
                      fontFamily: "DMSans",
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? AppColors.white : AppColors.black,
                      fontSize: 12.sp),
                ),
                addVerticalSpace(10.h),
                getRecentContacts(isDarkMode)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
