import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/save/controller/create_savings_controller.dart';
import 'package:sprout_mobile/src/components/save/view/savings_summary.dart';
import 'package:sprout_mobile/src/public/widgets/custom_text_form_field.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';

// ignore: must_be_immutable
class NewSavingsScreen extends StatelessWidget {
  NewSavingsScreen({super.key});

  late CreateSavingsController createSavingsController;

  @override
  Widget build(BuildContext context) {
    createSavingsController = Get.put(CreateSavingsController());
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(left: 24, right: 24, bottom: 24),
          child: DecisionButton(
              isDarkMode: isDarkMode,
              buttonText: "Continue",
              onTap: () {
                Get.to(() => SavingsSummaryScreen());
              }),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getHeader(isDarkMode),
                addVerticalSpace(15.h),
                CustomTextFormField(
                  label: "Name your Savings",
                  hintText: "Enter Savings Name",
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                ),
                CustomTextFormField(
                  label: "What is your Target Amount?",
                  hintText: "Enter Target Amount",
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                ),
                CustomTextFormField(
                  label: "How much do you want to save?",
                  hintText: "Enter Amount",
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                ),
                CustomTextFormField(
                  label: "How often do you want to save?",
                  hintText: "Select Frequency",
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                ),
                CustomTextFormField(
                  label: "Date of withdrawal",
                  hintText: "YYYY / MM / DAY",
                  enabled: false,
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                ),
                CustomTextFormField(
                  label: "Payment Type",
                  hintText: "Select Payment Type",
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
