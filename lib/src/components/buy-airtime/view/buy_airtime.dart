import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/buy-airtime/controller/airtime_controller.dart';
import 'package:sprout_mobile/src/components/buy-airtime/view/airtime_payment_pin_confirmation.dart';
import 'package:sprout_mobile/src/public/widgets/custom_button.dart';
import 'package:sprout_mobile/src/public/widgets/custom_loader.dart';
import 'package:sprout_mobile/src/public/widgets/custom_text_form_field.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';
import 'package:sprout_mobile/src/utils/global_function.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';
import 'package:badges/badges.dart' as badges;

// ignore: must_be_immutable
class BuyAirtimeScreen extends StatelessWidget {
  BuyAirtimeScreen({super.key});

  late AirtimeController airtimeController;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    airtimeController = Get.put(AirtimeController());
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Obx((() => airtimeController.package.value != null
            ? Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 24, right: 24),
                child: Row(
                  children: [
                    Container(
                      width: 246.w,
                      child: CustomButton(
                        title: "Buy Airtime",
                        onTap: () {
                          airtimeController.validateAirtime().then((value) => {
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
                          style: TextStyle(
                              fontFamily: "Mont", color: AppColors.white),
                        ),
                      ),
                    ))
                  ],
                ),
              )
            : SizedBox())),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getHeader(isDarkMode),
                addVerticalSpace(15.h),
                // InkWell(
                //   onTap: () {
                //     Get.to(() => SelectNetworkScreen());
                //   },
                //   child: Container(
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(10),
                //         color:
                //             isDarkMode ? AppColors.blackBg : AppColors.greyBg),
                //     child: Padding(
                //       padding: const EdgeInsets.symmetric(
                //           horizontal: 11, vertical: 10),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Text(
                //                 "Send to my phone number",
                //                 style: TextStyle(
                //                     color: isDarkMode
                //                         ? AppColors.white
                //                         : AppColors.greyText,
                //                     fontWeight: FontWeight.w500,
                //                     fontSize: 12.sp),
                //               ),
                //               addVerticalSpace(10.h),
                //               Row(
                //                 children: [
                //                   SvgPicture.asset(
                //                     AppSvg.airtel,
                //                     height: 30.h,
                //                     width: 30.w,
                //                   ),
                //                   addHorizontalSpace(12.w),
                //                   Text(
                //                     "+234-7082136463",
                //                     style: TextStyle(
                //                         color: isDarkMode
                //                             ? AppColors.white
                //                             : AppColors.black,
                //                         fontWeight: FontWeight.w700,
                //                         fontSize: 12.sp),
                //                   )
                //                 ],
                //               )
                //             ],
                //           ),
                //           IconButton(
                //               onPressed: () {}, icon: Icon(Icons.arrow_forward))
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                // addVerticalSpace(16.h),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: isDarkMode ? AppColors.blackBg : AppColors.greyBg),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      children: [
                        Obx((() => airtimeController.loading.value
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  buildBillsShimmer(),
                                  buildBillsShimmer(),
                                  buildBillsShimmer(),
                                  buildBillsShimmer()
                                ],
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  for (var group in airtimeController.billers)
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                          color:
                                              airtimeController.biller.value !=
                                                          null &&
                                                      airtimeController.biller
                                                              .value?.slug ==
                                                          group.slug
                                                  ? AppColors.greyText
                                                  : AppColors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: InkWell(
                                          onTap: () => {
                                                airtimeController
                                                    .canShowPackages
                                                    .value = false,
                                                airtimeController
                                                    .package.value = null,
                                                airtimeController.biller.value =
                                                    group,
                                                airtimeController.getPackages()
                                              },
                                          child: Container(
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                  group.slug == "MTN_NIGERIA"
                                                      ? AppSvg.mtn
                                                      : group.slug ==
                                                              "AIRTEL_NIGERIA"
                                                          ? AppSvg.airtel
                                                          : group.slug ==
                                                                  "GLO_NIGERIA"
                                                              ? AppSvg.glo
                                                              : AppSvg.nmobile,
                                                  height: 40.h,
                                                  width: 40.w,
                                                ),
                                                addVerticalSpace(10.h),
                                                Text(
                                                  group.slug == "MTN_NIGERIA"
                                                      ? "Mtn"
                                                      : group.slug ==
                                                              "AIRTEL_NIGERIA"
                                                          ? "Airtel"
                                                          : group.slug ==
                                                                  "GLO_NIGERIA"
                                                              ? "Glo"
                                                              : "9mobile",
                                                  style: TextStyle(
                                                      fontFamily: "Mont",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 10.sp,
                                                      color: isDarkMode
                                                          ? AppColors.semi_white
                                                              .withOpacity(0.6)
                                                          : AppColors.black),
                                                )
                                              ],
                                            ),
                                          )),
                                    ),
                                ],
                              ))),
                      ],
                    ),
                  ),
                ),
                Obx((() => airtimeController.canShowPackages.value
                    ? Container(
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          addVerticalSpace(10.h),
                          GestureDetector(
                            onTap: () => airtimeController.showPackages(
                                context, isDarkMode),
                            child: Obx(
                              () => CustomTextFormField(
                                  label: "Select Package",
                                  hintText:
                                      airtimeController.package.value?.name ??
                                          "Select Package",
                                  required: true,
                                  enabled: false,
                                  fillColor: isDarkMode
                                      ? AppColors.inputBackgroundColor
                                      : AppColors.grey,
                                  hintTextStyle:
                                      airtimeController.package.value == null
                                          ? null
                                          : TextStyle(
                                              color: isDarkMode
                                                  ? AppColors.white
                                                  : AppColors.black,
                                              fontWeight: FontWeight.w600)),
                            ),
                          ),
                          airtimeController.package.value != null
                              ? CustomTextFormField(
                                  controller:
                                      airtimeController.amountController.value,
                                  label: "Amount ($currencySymbol)",
                                  hintText: "Enter Amount",
                                  required: true,
                                  enabled:
                                      airtimeController.package.value!.amount ==
                                          null,
                                  textInputType: TextInputType.phone,
                                  fillColor: isDarkMode
                                      ? AppColors.inputBackgroundColor
                                      : AppColors.grey,
                                  textInputAction: TextInputAction.next,
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
                                            value.split(",").join()) >
                                        double.parse(airtimeController
                                            .userBalance
                                            .toString()
                                            .split(",")
                                            .join())) {
                                      return "Amount is greater than wallet balance";
                                    } else if (double.parse(
                                            value.split(",").join("")) >
                                        100000) {
                                      return "Maximum amount is 100,000";
                                    }
                                    return null;
                                  },
                                )
                              : SizedBox(),
                          airtimeController.package.value != null
                              ? Text(
                                  "Wallet Balance: " +
                                      "$currencySymbol${airtimeController.formatter.formatAsMoney(airtimeController.userBalance!)}",
                                  style: TextStyle(
                                      fontFamily: "Mont",
                                      fontWeight: FontWeight.w700,
                                      color: isDarkMode
                                          ? AppColors.semi_white
                                              .withOpacity(0.7)
                                          : AppColors.black,
                                      fontSize: 12.sp),
                                )
                              : SizedBox(),
                          addVerticalSpace(20.h),
                          airtimeController.package.value != null
                              ? Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: isDarkMode
                                          ? AppColors.blackBg
                                          : AppColors.greyBg),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20, bottom: 20),
                                    child: Column(
                                      children: [
                                        addVerticalSpace(20.h),
                                        Container(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            'Quick Actions',
                                            style: TextStyle(
                                                color: isDarkMode
                                                    ? AppColors.inputLabelColor
                                                    : AppColors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 10.sp),
                                          ),
                                        ),
                                        addVerticalSpace(20.h),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              AmountCard(
                                                isDarkMode: isDarkMode,
                                                amount: "₦10,000",
                                                value: 100000.0,
                                              ),
                                              AmountCard(
                                                isDarkMode: isDarkMode,
                                                amount: "₦15,000",
                                                value: 150000.0,
                                              ),
                                              AmountCard(
                                                isDarkMode: isDarkMode,
                                                amount: "₦20,000",
                                                value: 200000.0,
                                              )
                                            ],
                                          ),
                                        ),
                                        addVerticalSpace(20.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            AmountCard(
                                              isDarkMode: isDarkMode,
                                              amount: "₦1,000",
                                              value: 10000.0,
                                            ),
                                            AmountCard(
                                              isDarkMode: isDarkMode,
                                              amount: "₦1,500",
                                              value: 15000.0,
                                            ),
                                            AmountCard(
                                              isDarkMode: isDarkMode,
                                              amount: "₦3,000",
                                              value: 30000.0,
                                            ),
                                            AmountCard(
                                              isDarkMode: isDarkMode,
                                              amount: "₦5,000",
                                              value: 50000.0,
                                            )
                                          ],
                                        ),
                                        addVerticalSpace(20.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            AmountCard(
                                              isDarkMode: isDarkMode,
                                              amount: "₦100",
                                              value: 1000.0,
                                            ),
                                            AmountCard(
                                              isDarkMode: isDarkMode,
                                              amount: "₦200",
                                              value: 2000.0,
                                            ),
                                            AmountCard(
                                              isDarkMode: isDarkMode,
                                              amount: "₦300",
                                              value: 3000.0,
                                            ),
                                            AmountCard(
                                              isDarkMode: isDarkMode,
                                              amount: "₦500",
                                              value: 5000.0,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          airtimeController.package.value != null
                              ? addVerticalSpace(10.h)
                              : SizedBox(),
                          airtimeController.package.value != null
                              ? CustomTextFormField(
                                  controller:
                                      airtimeController.phoneNumberController,
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
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^[0-9]*$'))
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
                              : SizedBox(),
                        ],
                      ))
                    : SizedBox()))
                // addVerticalSpace(16.h),
                // Text(
                //   "Send airtime to",
                //   style: TextStyle(
                //       fontFamily: "Mont",
                //       fontWeight: FontWeight.w500,
                //       color: isDarkMode ? AppColors.white : AppColors.black,
                //       fontSize: 10.sp),
                // ),
                // addVerticalSpace(5.h),
                // getRecentContacts(isDarkMode)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class AmountCard extends StatelessWidget {
  AmountCard(
      {Key? key,
      required this.isDarkMode,
      required this.amount,
      required this.value})
      : super(key: key);

  final bool isDarkMode;
  final String amount;
  final double value;

  late AirtimeController airtimeController;

  @override
  Widget build(BuildContext context) {
    airtimeController = Get.put(AirtimeController());
    return InkWell(
      onTap: () =>
          {airtimeController.amountController.value!.text = value.toString()},
      child: Container(
        decoration: BoxDecoration(
            color: isDarkMode ? AppColors.black : AppColors.white,
            borderRadius: BorderRadius.circular(60)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            amount,
            style: TextStyle(
                fontFamily: "Mont",
                color: isDarkMode ? AppColors.greyText : AppColors.black,
                fontSize: 12,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}

getRecentContacts(isDarkMode) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isDarkMode ? AppColors.greyDot : AppColors.greyBg),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Contacts",
                style: TextStyle(
                    color: isDarkMode
                        ? AppColors.inputLabelColor
                        : AppColors.greyText,
                    fontSize: 12.sp,
                    fontFamily: "Mont",
                    fontWeight: FontWeight.w400),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_horiz,
                      color: isDarkMode
                          ? AppColors.inputLabelColor
                          : AppColors.grey))
            ],
          ),
          addVerticalSpace(5.h),
          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ContactCard(
                  text: "DJ",
                  background: AppColors.primaryColor,
                ),
                ContactCard(
                  text: "MI",
                  background: AppColors.errorRed,
                ),
                ContactCard(
                  text: "AA",
                  background: Colors.purple,
                ),
                ContactCard(
                  text: "AJ",
                  background: Colors.orange,
                ),
                ContactCard(
                  text: "HM",
                  background: Colors.green,
                ),
                ContactCard(
                  text: "GT",
                  background: AppColors.primaryColor,
                ),
                ContactCard(
                  text: "GT",
                  background: AppColors.primaryColor,
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}

class ContactCard extends StatelessWidget {
  ContactCard({
    Key? key,
    required this.text,
    required this.background,
  }) : super(key: key);
  final String text;
  final Color background;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: badges.Badge(
        position: badges.BadgePosition.bottomEnd(bottom: 12, end: -10),
        badgeStyle: badges.BadgeStyle(badgeColor: Colors.green),
        badgeContent: Container(
            height: 10,
            width: 10,
            child: Center(
              child: Icon(
                Icons.arrow_forward,
                size: 9,
                color: isDarkMode ? AppColors.black : AppColors.white,
              ),
            )),
        child: Container(
          decoration: BoxDecoration(shape: BoxShape.circle, color: background),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                    fontFamily: "Mont",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? AppColors.white : AppColors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
