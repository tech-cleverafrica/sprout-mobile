import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/send-money/view/send_money_summary.dart';
import 'package:sprout_mobile/src/public/widgets/custom_dropdown_button_field.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';

import '../../../../public/widgets/custom_text_form_field.dart';
import '../../../../utils/app_colors.dart';
import '../../controller/send_money_controller.dart';

class SendToBank extends StatelessWidget {
  SendToBank({super.key});

  late SendMoneyController sendMoneyController;

  @override
  Widget build(BuildContext context) {
    sendMoneyController = Get.put(SendMoneyController());
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
            child: DecisionButton(
              isDarkMode: isDarkMode,
              buttonText: "Continue",
              onTap: () {
                Get.to(() => SendMoneySummaryScreen());
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
                  GestureDetector(
                    onTap: () => sendMoneyController.showBeneficiaryList(
                        context, isDarkMode),
                    child: Obx(
                      () => CustomTextFormField(
                        label: "Select Beneficiary",
                        hintText: sendMoneyController.beneficiaryName.value,
                        enabled: false,
                        fillColor: isDarkMode
                            ? AppColors.inputBackgroundColor
                            : AppColors.grey,
                      ),
                    ),
                  ),
                  Obx(
                    () => CustomTextFormField(
                      controller: sendMoneyController.bankController,
                      label: "Select Bank",
                      hintText: sendMoneyController.beneficiaryBank.value,
                      fillColor: isDarkMode
                          ? AppColors.inputBackgroundColor
                          : AppColors.grey,
                    ),
                  ),
                  Obx(
                    () => CustomTextFormField(
                      controller: sendMoneyController.accountNumberController,
                      label: "Account Number",
                      hintText:
                          sendMoneyController.beneficiaryAccountNumber.value,
                      fillColor: isDarkMode
                          ? AppColors.inputBackgroundColor
                          : AppColors.grey,
                    ),
                  ),
                  Visibility(
                    child: Container(
                      alignment: Alignment.topRight,
                      child: Obx(
                        () => Text(
                          sendMoneyController.beneficiaryName.value,
                          style: TextStyle(
                              fontFamily: "DMSans",
                              fontSize: 13.sp,
                              color: isDarkMode
                                  ? AppColors.white
                                  : AppColors.black,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => Visibility(
                      visible: sendMoneyController.showSaver.value,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                "Save as beneficiary",
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
                                "We will save this Account for next time",
                                style: TextStyle(
                                    fontFamily: "DMSans",
                                    fontSize: 10.sp,
                                    color: isDarkMode
                                        ? AppColors.semi_white.withOpacity(0.5)
                                        : AppColors.black,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                          Obx(
                            () => CupertinoSwitch(
                                activeColor: AppColors.primaryColor,
                                value: sendMoneyController.save.value,
                                onChanged: (value) {
                                  sendMoneyController.toggleSaver();
                                }),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextFormField(
                    controller: sendMoneyController.amountController,
                    label: "Enter Amount",
                    fillColor: isDarkMode
                        ? AppColors.inputBackgroundColor
                        : AppColors.grey,
                  ),
                  CustomTextFormField(
                    controller: sendMoneyController.purposeController,
                    label: "Purpose",
                    fillColor: isDarkMode
                        ? AppColors.inputBackgroundColor
                        : AppColors.grey,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
