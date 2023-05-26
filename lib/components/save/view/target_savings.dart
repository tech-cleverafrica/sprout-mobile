import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/components/save/controller/create_savings_controller.dart';
import 'package:sprout_mobile/public/widgets/custom_text_form_field.dart';
import 'package:sprout_mobile/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/utils/app_colors.dart';
import 'package:sprout_mobile/utils/helper_widgets.dart';

// ignore: must_be_immutable
class TargetSavingsScreen extends StatelessWidget {
  TargetSavingsScreen({super.key});

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
                createSavingsController.validateTargetSavings();
              }),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getHeader(isDarkMode),
                addVerticalSpace(15.h),
                CustomTextFormField(
                  controller: createSavingsController.savingsNameController,
                  label: "Name your Savings",
                  hintText: "Enter Savings Name",
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                  validator: (value) {
                    if (value!.length == 0)
                      return "Savings name is required";
                    else if (value.length < 2)
                      return "Savings name is too short";
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                ),
                CustomTextFormField(
                  controller: createSavingsController.targetAmountController,
                  label: "What is your Target Amount?",
                  hintText: "Enter Target Amount",
                  textInputType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                  validator: (value) {
                    if (value!.length == 0)
                      return "Target amount is required";
                    else if (double.parse(value.split(",").join("")) == 0) {
                      return "Invalid target amount";
                    } else if (double.parse(value.split(",").join("")) < 1000) {
                      return "Target amount should be minimum of NGN 1,000";
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  controller: createSavingsController.startingAmountController,
                  label: "How much do you want to save (Recurring amount)?",
                  hintText: "Enter Amount",
                  textInputType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                  validator: (value) {
                    if (value!.length == 0)
                      return "Recurring amount is required";
                    else if (double.parse(value.split(",").join("")) == 0) {
                      return "Invalid recurring amount";
                    } else if (double.parse(value.split(",").join("")) < 100) {
                      return "Recurring amount should be minimum of NGN 100";
                    }
                    return null;
                  },
                ),
                GestureDetector(
                    onTap: () {
                      createSavingsController.showFrequencyList(
                          context, isDarkMode);
                    },
                    child: Obx((() => CustomTextFormField(
                        controller: createSavingsController.frequencyController,
                        label: "How often do you want to save?",
                        hintText: createSavingsController.frequency.value == ''
                            ? "Select Frequency"
                            : createSavingsController.frequency.value,
                        enabled: false,
                        fillColor: isDarkMode
                            ? AppColors.inputBackgroundColor
                            : AppColors.grey,
                        hintTextStyle:
                            createSavingsController.frequency.value == ''
                                ? null
                                : TextStyle(
                                    color: isDarkMode
                                        ? AppColors.white
                                        : AppColors.black,
                                    fontWeight: FontWeight.w600))))),
                GestureDetector(
                    onTap: () {
                      createSavingsController.showPaymentTypeList(
                          context, isDarkMode);
                    },
                    child: Obx((() =>
                        CustomTextFormField(
                            controller:
                                createSavingsController.paymentTypeController,
                            label: "Payment Type",
                            hintText:
                                createSavingsController.paymentType.value == ''
                                    ? "Select Payment Type"
                                    : createSavingsController.paymentType.value,
                            enabled: false,
                            fillColor: isDarkMode
                                ? AppColors.inputBackgroundColor
                                : AppColors.grey,
                            hintTextStyle:
                                createSavingsController.paymentType.value == ''
                                    ? null
                                    : TextStyle(
                                        color: isDarkMode
                                            ? AppColors.white
                                            : AppColors.black,
                                        fontWeight: FontWeight.w600))))),
                Obx((() => createSavingsController.paymentType.value == "CARD"
                    ? GestureDetector(
                        onTap: () {
                          createSavingsController.showCardList(
                              context, isDarkMode);
                        },
                        child: Obx((() => CustomTextFormField(
                            controller: createSavingsController.cardController,
                            label: "Select Card",
                            hintText: createSavingsController.card.value == null
                                ? "Select Card"
                                : createSavingsController.card.value!.pan! +
                                    " - " +
                                    createSavingsController
                                        .card.value!.provider!,
                            enabled: false,
                            fillColor: isDarkMode
                                ? AppColors.inputBackgroundColor
                                : AppColors.grey,
                            hintTextStyle:
                                createSavingsController.card.value == null
                                    ? null
                                    : TextStyle(
                                        color: isDarkMode
                                            ? AppColors.white
                                            : AppColors.black,
                                        fontWeight: FontWeight.w600)))))
                    : SizedBox())),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
