import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sprout_mobile/components/pay-bills/controller/payment_controller.dart';
import 'package:sprout_mobile/components/pay-bills/view/bills_payment_pin_confirmation.dart';
import 'package:sprout_mobile/config/Config.dart';
import 'package:sprout_mobile/public/widgets/general_widgets.dart';

import '../../../public/widgets/custom_button.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/helper_widgets.dart';

// ignore: must_be_immutable
class BillSummaryPage extends StatelessWidget {
  BillSummaryPage({super.key});

  late PaymentController paymentController;
  var oCcy = new NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    paymentController = Get.put(PaymentController());
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getHeader(isDarkMode),
              addVerticalSpace(15.h),
              Container(
                decoration: BoxDecoration(
                    color: isDarkMode ? AppColors.greyDot : AppColors.greyBg,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Amount:",
                            style: titleStyle(),
                          ),
                          Text(
                            "₦ " +
                                paymentController.packagesController
                                    .amountController.value!.text,
                            style: detailStyle(isDarkMode),
                          )
                        ],
                      ),
                      addVerticalSpace(25.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            paymentController.billersController.group ==
                                    "AIRTIME_AND_DATA"
                                ? "Bundle:"
                                : "Package:",
                            style: titleStyle(),
                          ),
                          Text(
                            paymentController
                                    .packagesController.package.value!.name ??
                                "",
                            style: detailStyle(isDarkMode),
                          )
                        ],
                      ),
                      addVerticalSpace(25.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            paymentController.billersController.group ==
                                        'DISCO' ||
                                    paymentController.billersController.group ==
                                        'ELECTRIC_DISCO'
                                ? 'Meter Number:'
                                : paymentController.billersController.group ==
                                            'PAID_TV' ||
                                        paymentController
                                                .billersController.group ==
                                            'PAY_TV'
                                    ? 'Smartcard Number:'
                                    : paymentController
                                                .billersController.group ==
                                            'AIRTIME_AND_DATA'
                                        ? 'Phone Number:'
                                        : paymentController
                                                    .billersController.group ==
                                                'BETTING_AND_LOTTERY'
                                            ? 'User ID:'
                                            : paymentController
                                                        .billersController
                                                        .group ==
                                                    'TRANSPORT_AND_TOLL_PAYMENT'
                                                ? 'Card Number:'
                                                : "Phone Number:",
                            style: titleStyle(),
                          ),
                          Text(
                            paymentController
                                .packagesController.digitController.text,
                            style: detailStyle(isDarkMode),
                          )
                        ],
                      ),
                      paymentController.packagesController.phoneNumberController
                              .text.isNotEmpty
                          ? Column(
                              children: [
                                addVerticalSpace(25.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Phone Number:",
                                      style: titleStyle(),
                                    ),
                                    Text(
                                      paymentController.packagesController
                                          .phoneNumberController.text,
                                      style: detailStyle(isDarkMode),
                                    )
                                  ],
                                ),
                              ],
                            )
                          : SizedBox(),
                      paymentController.packagesController
                                  .beneficiaryNameController.text.isNotEmpty ||
                              (paymentController.customer.value != true &&
                                  paymentController.customer.value["customer"]
                                          ['customerName'] !=
                                      null)
                          ? Column(
                              children: [
                                addVerticalSpace(25.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Customer Name:",
                                      style: titleStyle(),
                                    ),
                                    Text(
                                      paymentController.customer.value != true
                                          ? paymentController.customer
                                              .value["customer"]['customerName']
                                          : paymentController.packagesController
                                              .beneficiaryNameController.text,
                                      style: detailStyle(isDarkMode),
                                    )
                                  ],
                                ),
                              ],
                            )
                          : SizedBox(),
                      paymentController.billersController.group ==
                                  "BETTING_AND_LOTTERY" ||
                              paymentController.packagesController.package
                                          .value!.slug ==
                                      "IPNX" &&
                                  (paymentController.customer.value != true &&
                                      paymentController.customer.value["fee"] !=
                                          null)
                          ? Column(
                              children: [
                                addVerticalSpace(25.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Fee:",
                                      style: titleStyle(),
                                    ),
                                    Text(
                                      "₦ " +
                                          oCcy
                                              .format(double.parse(
                                                  paymentController
                                                      .customer.value["fee"]
                                                      .toString()))
                                              .toString(),
                                      style: detailStyle(isDarkMode),
                                    )
                                  ],
                                ),
                              ],
                            )
                          : SizedBox()
                    ],
                  ),
                ),
              ),
              addVerticalSpace(16.h),
              Text(
                  "Please ensure the details entered are correct before proceeding with this transfer as $APP_COMPANY_NAME will not be responsible for recall of funds transferred in error. Thank You.",
                  style: TextStyle(
                    fontFamily: "Mont",
                    color: isDarkMode
                        ? AppColors.mainGreen
                        : AppColors.primaryColor,
                  )),
              addVerticalSpace(36.h),
              Row(
                children: [
                  Container(
                    width: 246.w,
                    child: CustomButton(
                        title: "Authorize Payment",
                        onTap: () {
                          Get.to(() => BillsPaymentPinPage());
                        }),
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
                        style: TextStyle(
                            fontFamily: "Mont", color: AppColors.white),
                      ),
                    ),
                  ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle titleStyle() {
    return TextStyle(
        fontFamily: "Mont",
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.inputLabelColor);
  }

  TextStyle detailStyle(isDark) {
    return TextStyle(
        fontFamily: "Mont",
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: isDark ? AppColors.white : Color(0xFF0D0D0D));
  }
}
