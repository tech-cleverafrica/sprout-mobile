import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';

import '../../../../public/widgets/custom_text_form_field.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/global_function.dart';
import '../../controller/send_money_controller.dart';

// ignore: must_be_immutable
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
                sendMoneyController.validateFields();
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
                          hintText:
                              sendMoneyController.beneficiaryName.value == ""
                                  ? "Select Beneficiary"
                                  : sendMoneyController.beneficiaryName.value,
                          required: true,
                          enabled: false,
                          fillColor: isDarkMode
                              ? AppColors.inputBackgroundColor
                              : AppColors.grey,
                          hintTextStyle:
                              sendMoneyController.beneficiaryName.value == ""
                                  ? null
                                  : TextStyle(
                                      color: isDarkMode
                                          ? AppColors.white
                                          : AppColors.black,
                                      fontWeight: FontWeight.w600)),
                    ),
                  ),
                  Obx((() => sendMoneyController.showFields.value
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                sendMoneyController.showBankList(
                                    context, isDarkMode);
                              },
                              child: CustomTextFormField(
                                  controller:
                                      sendMoneyController.bankController,
                                  label: "Select Bank",
                                  hintText: sendMoneyController
                                              .beneficiaryBank.value ==
                                          ""
                                      ? "Select Bank"
                                      : sendMoneyController
                                          .beneficiaryBank.value,
                                  required: true,
                                  enabled: false,
                                  fillColor: isDarkMode
                                      ? AppColors.inputBackgroundColor
                                      : AppColors.grey,
                                  hintTextStyle: sendMoneyController
                                                  .beneficiaryBank.value ==
                                              "" &&
                                          sendMoneyController
                                              .isNewTransfer.value
                                      ? null
                                      : TextStyle(
                                          color: isDarkMode
                                              ? AppColors.white
                                              : AppColors.black,
                                          fontWeight: FontWeight.w600)),
                            ),
                            CustomTextFormField(
                              controller:
                                  sendMoneyController.accountNumberController,
                              required: true,
                              label: "Account Number",
                              hintText: "Enter Account Number",
                              enabled:
                                  !sendMoneyController.isValidating.value ||
                                      sendMoneyController.isNewTransfer.value,
                              onChanged: ((value) {
                                if (sendMoneyController.accountNumberController
                                            .text.length >=
                                        10 &&
                                    sendMoneyController.canResolve.value) {
                                  sendMoneyController.validateBank();
                                } else {
                                  sendMoneyController.canResolve.value = true;
                                }
                              }),
                              fillColor: isDarkMode
                                  ? AppColors.inputBackgroundColor
                                  : AppColors.grey,
                            ),
                            sendMoneyController.beneficiaryName.value != "" &&
                                    sendMoneyController.showBeneficiary.value
                                ? Container(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      sendMoneyController.beneficiaryName.value,
                                      style: TextStyle(
                                          fontFamily: "DMSans",
                                          fontSize: 13.sp,
                                          color: isDarkMode
                                              ? AppColors.white
                                              : AppColors.black,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  )
                                : SizedBox(),
                            sendMoneyController.beneficiaryName.value != "" &&
                                    sendMoneyController.showBeneficiary.value
                                ? addVerticalSpace(10)
                                : SizedBox(),
                            Obx(
                              () => Visibility(
                                visible: sendMoneyController.showSaver.value,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
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
                                                  ? AppColors.semi_white
                                                      .withOpacity(0.5)
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
                            sendMoneyController.save.value
                                ? CustomTextFormField(
                                    controller:
                                        sendMoneyController.nicknameController,
                                    label: "Nickname",
                                    hintText: "Enter Nickname",
                                    required: true,
                                    fillColor: isDarkMode
                                        ? AppColors.inputBackgroundColor
                                        : AppColors.grey,
                                    textInputAction: TextInputAction.next,
                                    textInputType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.length == 0 &&
                                          sendMoneyController.save.value)
                                        return "Nickname is required";
                                      return null;
                                    },
                                  )
                                : SizedBox(),
                            CustomTextFormField(
                              controller: sendMoneyController.amountController,
                              enabled: !sendMoneyController.isValidating.value,
                              label: "Amount",
                              required: true,
                              textInputType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                              fillColor: isDarkMode
                                  ? AppColors.inputBackgroundColor
                                  : AppColors.grey,
                              validator: (value) {
                                if (value!.length == 0)
                                  return "Amount is required";
                                else if (double.parse(
                                        value.split(",").join("")) ==
                                    0) {
                                  return "Invalid amount";
                                } else if (double.parse(
                                        value.split(",").join("")) <
                                    1) {
                                  return "Invalid amount";
                                } else if (double.parse(
                                        value.split(",").join("")) >
                                    450000) {
                                  return "Maximum amount is 450,000";
                                }
                                return null;
                              },
                            ),
                            Text(
                                "$currencySymbol${sendMoneyController.formatter.formatAsMoney(sendMoneyController.userBalance!)}",
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 15.sp,
                                    fontFamily: "Outfit",
                                    fontWeight: FontWeight.w700)),
                            addVerticalSpace(5),
                            CustomTextFormField(
                              controller: sendMoneyController.purposeController,
                              label: "Purpose",
                              required: true,
                              fillColor: isDarkMode
                                  ? AppColors.inputBackgroundColor
                                  : AppColors.grey,
                            ),
                          ],
                        )
                      : SizedBox())),
                ],
              ),
            ),
          )),
    );
  }
}
