import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/components/send-money/controller/send_abroad_controller.dart';
import 'package:sprout_mobile/config/Config.dart';
import 'package:sprout_mobile/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/utils/app_svgs.dart';
import 'package:sprout_mobile/utils/helper_widgets.dart';

import '../../../../public/widgets/custom_text_form_field.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/global_function.dart';

// ignore: must_be_immutable
class SendAbroad extends StatelessWidget {
  SendAbroad({super.key});

  late SendAbroadController sendAbroadController;

  @override
  Widget build(BuildContext context) {
    sendAbroadController = Get.put(SendAbroadController());
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
            child: DecisionButton(
              isDarkMode: isDarkMode,
              buttonText: "Continue",
              onTap: () {
                sendAbroadController.validateFields();
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getHeader(isDarkMode),
                  addVerticalSpace(15.h),
                  GestureDetector(
                    onTap: () => {
                      sendAbroadController.showCategoryList(context, isDarkMode)
                    },
                    child: Obx(
                      () => CustomTextFormField(
                          label: "Select Category",
                          hintText: sendAbroadController.category.value == ""
                              ? "Select Category"
                              : sendAbroadController.category.value,
                          required: true,
                          enabled: false,
                          fillColor: isDarkMode
                              ? AppColors.inputBackgroundColor
                              : AppColors.grey,
                          hintTextStyle:
                              sendAbroadController.category.value == ""
                                  ? null
                                  : TextStyle(
                                      color: isDarkMode
                                          ? AppColors.white
                                          : AppColors.black,
                                      fontWeight: FontWeight.w600)),
                    ),
                  ),
                  CustomTextFormField(
                    controller: sendAbroadController.amountToSendController,
                    label: "You're sending",
                    required: true,
                    textInputType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    fillColor: isDarkMode
                        ? AppColors.inputBackgroundColor
                        : AppColors.grey,
                    validator: (value) {
                      if (value!.length == 0)
                        return "Amount is required";
                      else if (double.parse(value.split(",").join("")) == 0) {
                        return "Invalid amount";
                      } else if (double.parse(value.split(",").join("")) <
                          MINIMUM_TRANSFER_AMOUNT) {
                        return "Amount too small";
                      } else if (double.parse(value.split(",").join()) >
                          double.parse(sendAbroadController.userBalance
                              .toString()
                              .split(",")
                              .join())) {
                        return "Amount is greater than wallet balance";
                      } else if (double.parse(value.split(",").join("")) >
                          MAXIMUM_TRANSFER_AMOUNT) {
                        return "Maximum amount is $MAXIMUM_TRANSFER_AMOUNT_STRING";
                      }
                      return null;
                    },
                    suffixIcon: Container(
                      width: 75,
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  color: isDarkMode
                                      ? AppColors.lightGrey
                                      : AppColors.balanceCardBorderLight))),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ClipRRect(
                              child: SvgPicture.asset(
                                AppSvg.nigeria,
                                height: 20,
                                width: 20,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            addHorizontalSpace(6.w),
                            Text(
                              "NGN",
                              style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            addHorizontalSpace(10.w)
                          ]),
                    ),
                    hasSuffixIcon: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Your Balance: ",
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 12.sp,
                            fontFamily: "Mont",
                          )),
                      Text(
                          "$currencySymbol${sendAbroadController.formatter.formatAsMoney(sendAbroadController.userBalance!)}",
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 12.sp,
                            fontFamily: "Mont",
                            fontWeight: FontWeight.w700,
                          ))
                    ],
                  ),
                  addVerticalSpace(5),
                  GestureDetector(
                    onTap: () => {
                      sendAbroadController.showDestinationList(
                          context, isDarkMode)
                    },
                    child: Obx(
                      () => CustomTextFormField(
                          label: "Select Destination",
                          hintText: sendAbroadController.destination.value == ""
                              ? "Select Destination"
                              : sendAbroadController.destination.value,
                          required: true,
                          enabled: false,
                          fillColor: isDarkMode
                              ? AppColors.inputBackgroundColor
                              : AppColors.grey,
                          hintTextStyle:
                              sendAbroadController.destination.value == ""
                                  ? null
                                  : TextStyle(
                                      color: isDarkMode
                                          ? AppColors.white
                                          : AppColors.black,
                                      fontWeight: FontWeight.w600)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Rate: ",
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 12.sp,
                            fontFamily: "Mont",
                          )),
                      Text("1 USD = 800 NGN",
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 12.sp,
                            fontFamily: "Mont",
                            fontWeight: FontWeight.w700,
                          ))
                    ],
                  ),
                  addVerticalSpace(5),
                  Obx((() => CustomTextFormField(
                        controller:
                            sendAbroadController.amountToReceiveController,
                        label: "Beneficiary gets",
                        required: true,
                        textInputType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        fillColor: isDarkMode
                            ? AppColors.inputBackgroundColor
                            : AppColors.grey,
                        validator: (value) {
                          if (value!.length == 0)
                            return "Amount is required";
                          else if (double.parse(value.split(",").join("")) ==
                              0) {
                            return "Invalid amount";
                          } else if (double.parse(value.split(",").join("")) <
                              MINIMUM_TRANSFER_AMOUNT) {
                            return "Amount too small";
                          } else if (double.parse(value.split(",").join()) >
                              double.parse(sendAbroadController.userBalance
                                  .toString()
                                  .split(",")
                                  .join())) {
                            return "Amount is greater than wallet balance";
                          } else if (double.parse(value.split(",").join("")) >
                              MAXIMUM_TRANSFER_AMOUNT) {
                            return "Maximum amount is $MAXIMUM_TRANSFER_AMOUNT_STRING";
                          }
                          return null;
                        },
                        suffixIcon: GestureDetector(
                            onTap: () => {
                                  sendAbroadController.showCurrencyList(
                                      context, isDarkMode)
                                },
                            child: Container(
                              width: 100,
                              decoration: BoxDecoration(
                                  border: Border(
                                      left: BorderSide(
                                          color: isDarkMode
                                              ? AppColors.lightGrey
                                              : AppColors
                                                  .balanceCardBorderLight))),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ClipRRect(
                                      child: SvgPicture.asset(
                                        sendAbroadController.currency.value ==
                                                "USD"
                                            ? AppSvg.usa
                                            : sendAbroadController
                                                        .currency.value ==
                                                    "GBP"
                                                ? AppSvg.gbp
                                                : AppSvg.eur,
                                        height: 20,
                                        width: 20,
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    addHorizontalSpace(6.w),
                                    Text(
                                      sendAbroadController.currency.value,
                                      style: TextStyle(
                                          color: isDarkMode
                                              ? AppColors.white
                                              : AppColors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    addHorizontalSpace(5.w),
                                    SvgPicture.asset(
                                      isDarkMode
                                          ? AppSvg.arrow_down_white
                                          : AppSvg.arrow_down_black,
                                      height: 16,
                                      // width: 20,
                                    ),
                                    addHorizontalSpace(10.w)
                                  ]),
                            )),
                        hasSuffixIcon: true,
                      ))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Speed: ",
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 12.sp,
                            fontFamily: "Mont",
                          )),
                      Text("1 - 3 business days",
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 12.sp,
                            fontFamily: "Mont",
                            fontWeight: FontWeight.w700,
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
