import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/send-money/view/transaction_details.dart';
import 'package:sprout_mobile/src/public/widgets/custom_text_form_field.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';

import '../../../../public/widgets/custom_button.dart';
import '../../../../public/widgets/general_widgets.dart';
import '../../../../utils/helper_widgets.dart';

class SendToSprout extends StatelessWidget {
  const SendToSprout({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getHeader(isDarkMode),
              addVerticalSpace(15.h),
              CustomTextFormField(
                label: "Select Sprout Beneficiary",
                // hintText: "Your Email",
                fillColor: isDarkMode
                    ? AppColors.inputBackgroundColor
                    : AppColors.grey,
              ),
              CustomTextFormField(
                label: "Username/Account Number",
                // hintText: "Your Email",
                fillColor: isDarkMode
                    ? AppColors.inputBackgroundColor
                    : AppColors.grey,
              ),
              Container(
                alignment: Alignment.topRight,
                child: Text(
                  "Jossy Davids",
                  style: TextStyle(
                      fontFamily: "DMSans",
                      fontSize: 13.sp,
                      color: isDarkMode ? AppColors.white : AppColors.black,
                      fontWeight: FontWeight.w700),
                ),
              ),
              addVerticalSpace(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Save as beneficiary",
                        style: TextStyle(
                            fontFamily: "DMSans",
                            fontSize: 13.sp,
                            color:
                                isDarkMode ? AppColors.white : AppColors.black,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "We will save this Account for next time",
                        style: TextStyle(
                            fontFamily: "DMSans",
                            fontSize: 10.sp,
                            color: isDarkMode
                                ? AppColors.white
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
              addVerticalSpace(250.h),
              Row(
                children: [
                  Container(
                    width: 190.w,
                    child: CustomButton(
                      title: "Continue",
                      onTap: () {
                        Get.to(() => TransactionDetailsScreen());
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
            ],
          ),
        ),
      )),
    );
  }
}
