import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/components/save/controller/create_savings_controller.dart';
import 'package:sprout_mobile/public/widgets/custom_text_form_field.dart';
import 'package:sprout_mobile/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/utils/app_colors.dart';
import 'package:sprout_mobile/utils/helper_widgets.dart';

// ignore: must_be_immutable
class LockedFundsScreen extends StatelessWidget {
  LockedFundsScreen({super.key});

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
                createSavingsController.validateLockedFunds();
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
                  controller: createSavingsController.savingsAmountController,
                  label: "How much do you want to save?",
                  hintText: "Enter Amount",
                  textInputType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                  validator: (value) {
                    if (value!.length == 0)
                      return "Savings amount is required";
                    else if (double.parse(value.split(",").join("")) == 0) {
                      return "Invalid savings amount";
                    } else if (double.parse(value.split(",").join("")) < 5000) {
                      return "Savings amount should be minimum of NGN 5,000";
                    }
                    return null;
                  },
                ),
                GestureDetector(
                    onTap: () {
                      createSavingsController.showTenureList(
                          context, isDarkMode);
                    },
                    child: Obx((() => CustomTextFormField(
                        controller: createSavingsController.tenureController,
                        label: "How long do you want to save for?",
                        hintText: createSavingsController.tenure.value == null
                            ? "Select Tenure"
                            : createSavingsController.tenure.value!.tenure
                                    .toString() +
                                " days",
                        enabled: false,
                        fillColor: isDarkMode
                            ? AppColors.inputBackgroundColor
                            : AppColors.grey,
                        hintTextStyle:
                            createSavingsController.tenure.value == null
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
