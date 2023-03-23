import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/buy-airtime/controller/airtime_packages_controller.dart';
import 'package:sprout_mobile/src/components/buy-airtime/view/airtime_payment_pin_confirmation.dart';
import 'package:sprout_mobile/src/public/widgets/custom_text_form_field.dart';

import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/global_function.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';

import '../../../public/widgets/custom_button.dart';
import '../../../utils/app_colors.dart';

// ignore: must_be_immutable
class SelectNetworkScreen extends StatelessWidget {
  SelectNetworkScreen({super.key});

  late AirtimePackagesController airtimePackagesController;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    airtimePackagesController = Get.put(AirtimePackagesController());
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 60, left: 24, right: 24),
          child: Row(
            children: [
              Container(
                width: 246.w,
                child: CustomButton(
                  title: "Buy Airtime",
                  onTap: () {
                    airtimePackagesController
                        .validateAirtime()
                        .then((value) => {
                              if (value != null)
                                {
                                  Get.to(() => AirtimePaymentPinPage(),
                                      arguments: value)
                                }
                            });
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
                    style:
                        TextStyle(fontFamily: "DMSans", color: AppColors.white),
                  ),
                ),
              ))
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getHeader(isDarkMode),
                addVerticalSpace(15.h),
                GestureDetector(
                  onTap: () => airtimePackagesController.showPackages(
                      context, isDarkMode),
                  child: Obx(
                    () => CustomTextFormField(
                        label: "Select Package",
                        hintText:
                            airtimePackagesController.package.value?.name ??
                                "Select Package",
                        required: true,
                        enabled: false,
                        fillColor: isDarkMode
                            ? AppColors.inputBackgroundColor
                            : AppColors.grey,
                        hintTextStyle:
                            airtimePackagesController.package.value == null
                                ? null
                                : TextStyle(
                                    color: isDarkMode
                                        ? AppColors.white
                                        : AppColors.black,
                                    fontWeight: FontWeight.w600)),
                  ),
                ),
                Obx((() => airtimePackagesController.package.value != null
                    ? CustomTextFormField(
                        controller:
                            airtimePackagesController.amountController.value,
                        label: "Amount",
                        hintText: "Enter Amount",
                        required: true,
                        enabled:
                            airtimePackagesController.package.value!.amount ==
                                null,
                        textInputType: TextInputType.phone,
                        fillColor: isDarkMode
                            ? AppColors.inputBackgroundColor
                            : AppColors.grey,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.length == 0)
                            return "Amount is required";
                          else if (double.parse(value.split(",").join("")) ==
                              0) {
                            return "Invalid amount";
                          } else if (double.parse(value.split(",").join("")) <
                              1) {
                            return "Invalid amount";
                          } else if (double.parse(value.split(",").join("")) >
                              200000) {
                            return "Maximum amount is 200,000";
                          }
                          return null;
                        },
                        onChanged: ((value) => {
                              if (double.parse(value.split(",").join("")) < 1 ||
                                  double.parse(value.split(",").join("")) >
                                      200000)
                                {
                                  airtimePackagesController.showField.value =
                                      false,
                                }
                              else
                                {
                                  airtimePackagesController.showField.value =
                                      true,
                                }
                            }),
                      )
                    : SizedBox())),
                Obx((() => airtimePackagesController.showField.value
                    ? CustomTextFormField(
                        controller:
                            airtimePackagesController.phoneNumberController,
                        label: "Phone Number",
                        hintText: "Enter Phone Number",
                        required: true,
                        maxLength: 11,
                        showCounterText: false,
                        maxLengthEnforced: true,
                        fillColor: isDarkMode
                            ? AppColors.inputBackgroundColor
                            : AppColors.grey,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*$'))
                        ],
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.phone,
                        validator: (value) {
                          if (value!.length == 0)
                            return "Phone number is required";
                          else if (value.length < 11)
                            return "Phone number should be 11 digits";
                          return null;
                        })
                    : SizedBox())),
                Obx((() => airtimePackagesController.showField.value
                    ? Text(
                        "Wallet Balance: " +
                            "$currencySymbol${airtimePackagesController.formatter.formatAsMoney(airtimePackagesController.userBalance!)}",
                        style: TextStyle(
                            fontFamily: "Mont",
                            fontWeight: FontWeight.w700,
                            color: isDarkMode
                                ? AppColors.semi_white.withOpacity(0.7)
                                : AppColors.black,
                            fontSize: 12.sp),
                      )
                    : SizedBox())),
                // addVerticalSpace(26.h),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           "Save this purchase",
                //           style: TextStyle(
                //               fontFamily: "DMSans",
                //               fontSize: 13.sp,
                //               color: isDarkMode
                //                   ? AppColors.white
                //                   : AppColors.black,
                //               fontWeight: FontWeight.w700),
                //         ),
                //         addVerticalSpace(9.h),
                //         Text(
                //           "We will add it to your quick airtime purchase",
                //           style: TextStyle(
                //               fontFamily: "DMSans",
                //               fontSize: 10.sp,
                //               color: isDarkMode
                //                   ? AppColors.greyText
                //                   : AppColors.black,
                //               fontWeight: FontWeight.w400),
                //         )
                //       ],
                //     ),
                //     CupertinoSwitch(
                //         activeColor: AppColors.primaryColor,
                //         value: true,
                //         onChanged: (value) {})
                //   ],
                // ),
                // addVerticalSpace(20.h),
                // Text(
                //   "Send airtime to",
                //   style: TextStyle(
                //       fontFamily: "DMSans",
                //       fontWeight: FontWeight.w500,
                //       color: isDarkMode ? AppColors.white : AppColors.black,
                //       fontSize: 12.sp),
                // ),
                // addVerticalSpace(10.h),
                // getRecentContacts(isDarkMode)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
