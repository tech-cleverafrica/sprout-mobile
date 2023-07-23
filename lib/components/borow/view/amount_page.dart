import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/public/widgets/custom_dropdown_button_field.dart';
import 'package:sprout_mobile/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/utils/helper_widgets.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_formatter.dart';

// ignore: must_be_immutable
class AmountScreen extends StatelessWidget {
  AmountScreen({super.key});
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
                addVerticalSpace(50.h),
                Text(
                  "Enter Amount",
                  style: TextStyle(
                      fontFamily: "Mont",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? AppColors.greyText : AppColors.grey),
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
                        prefix: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Text("NGN"),
                        ),
                        prefixStyle: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          fontFeatures: [
                            FontFeature.superscripts(),
                          ],
                          color: isDarkMode ? AppColors.white : AppColors.black,
                          fontFamily: "Mont",
                        )),
                  ),
                ),
                addVerticalSpace(30.h),
                Text("Select Card Type"),
                CustomDropdownButtonFormField(
                  //  label: "Select Card Type",
                  onSaved: (value) {
                    cardType = value;
                  },
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                  items: ["Visa", "MasterCard", "Verve"],
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
