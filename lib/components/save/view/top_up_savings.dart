import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/components/save/controller/top_up_savings_controller.dart';
import 'package:sprout_mobile/public/widgets/custom_text_form_field.dart';
import 'package:sprout_mobile/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/utils/app_colors.dart';
import 'package:sprout_mobile/utils/helper_widgets.dart';

// ignore: must_be_immutable
class TopUpSavingsScreen extends StatelessWidget {
  TopUpSavingsScreen({super.key});

  late TopUpSavingsController topUpSavingsController;

  @override
  Widget build(BuildContext context) {
    topUpSavingsController = Get.put(TopUpSavingsController());
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(left: 24, right: 24, bottom: 24),
          child: DecisionButton(
              isDarkMode: isDarkMode,
              buttonText: "Top Up",
              onTap: () {
                topUpSavingsController.validateTopUp();
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
                  controller: topUpSavingsController.savingsNameController,
                  label: "Savings Name",
                  hintText: "Enter Savings Name",
                  enabled: false,
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
                  controller: topUpSavingsController.topUpAmountController,
                  label: "How much do you want to top up with?",
                  hintText: "Enter Top Up Amount",
                  // enabled: topUpSavingsController.savingsDetailsController
                  //         .savings.value!.currentAmount! >=
                  //     topUpSavingsController
                  //         .savingsDetailsController.savings.value!.startAmount!,
                  textInputType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                  validator: (value) {
                    if (value!.length == 0)
                      return "Tup up amount is required";
                    else if (double.parse(value.split(",").join("")) == 0) {
                      return "Invalid top up amount";
                    } else if (double.parse(value.split(",").join("")) < 100) {
                      return "Top up amount should be minimum of NGN 100";
                    }
                    return null;
                  },
                ),
                GestureDetector(
                    onTap: () {
                      topUpSavingsController.showPaymentTypeList(
                          context, isDarkMode);
                    },
                    child: Obx((() => CustomTextFormField(
                        controller:
                            topUpSavingsController.paymentTypeController,
                        label: "Payment Type",
                        hintText: topUpSavingsController.paymentType.value == ''
                            ? "Select Payment Type"
                            : topUpSavingsController.paymentType.value,
                        enabled: false,
                        fillColor: isDarkMode
                            ? AppColors.inputBackgroundColor
                            : AppColors.grey,
                        hintTextStyle:
                            topUpSavingsController.paymentType.value == ''
                                ? null
                                : TextStyle(
                                    color: isDarkMode
                                        ? AppColors.white
                                        : AppColors.black,
                                    fontWeight: FontWeight.w600))))),
                Obx((() => topUpSavingsController.paymentType.value == "CARD"
                    ? GestureDetector(
                        onTap: () {
                          topUpSavingsController.showCardList(
                              context, isDarkMode);
                        },
                        child: Obx((() => CustomTextFormField(
                            controller: topUpSavingsController.cardController,
                            label: "Select Card",
                            hintText: topUpSavingsController.card.value == null
                                ? "Select Card"
                                : topUpSavingsController.card.value!.pan! +
                                    " - " +
                                    topUpSavingsController
                                        .card.value!.provider!,
                            enabled: false,
                            fillColor: isDarkMode
                                ? AppColors.inputBackgroundColor
                                : AppColors.grey,
                            hintTextStyle:
                                topUpSavingsController.card.value == null
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
