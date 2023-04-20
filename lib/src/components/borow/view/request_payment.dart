import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/public/widgets/custom_dropdown_button_field.dart';
import 'package:sprout_mobile/src/public/widgets/custom_text_form_field.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/global_function.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_formatter.dart';

// ignore: must_be_immutable
class RequestPayment extends StatelessWidget {
  RequestPayment({super.key});
  final AppFormatter formatter = Get.put(AppFormatter());
  late MoneyMaskedTextController amountController =
      new MoneyMaskedTextController();
  String? cardType;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    amountController = formatter.getMoneyController();
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getHeader(isDarkMode),
                addVerticalSpace(40.h),
                Text(
                  "Enter Amount ($currencySymbol)",
                  style: TextStyle(
                      fontFamily: "Mont",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? AppColors.white : AppColors.black),
                ),
                Container(
                  child: TextFormField(
                    controller: amountController,
                    enabled: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Mont",
                        fontSize: 40.sp,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode ? AppColors.white : AppColors.black),
                    keyboardType: TextInputType.number,
                    onChanged: (val) {},
                    onSaved: (val) {},
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      //prefixText: "NGN",
                    ),
                  ),
                ),
                addVerticalSpace(20.h),
                CustomTextFormField(
                  label: "Name",
                  hintText: "Enter Payment Name",
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                ),
                CustomTextFormField(
                  maxLines: 4,
                  maxLength: 250,
                  label: "Description",
                  hintText: "Enter Payment Description",
                  maxLengthEnforced: true,
                  validator: (value) {
                    if (value!.length == 0)
                      return "Description is required";
                    else if (value.length < 6)
                      return "Description is too short";
                    return null;
                  },
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                ),
                addVerticalSpace(83.h),
                DecisionButton(
                  isDarkMode: isDarkMode,
                  buttonText: "Continue",
                  onTap: () {
                    // Get.to(() => TransactionDetailsScreen());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
