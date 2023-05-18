import 'dart:io';

import 'package:badges/badges.dart' as badges;
import 'package:clipboard/clipboard.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sprout_mobile/src/components/notification/view/notification.dart';
import 'package:sprout_mobile/src/public/widgets/custom_toast_notification.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_svgs.dart';
import '../../../utils/helper_widgets.dart';
import '../../borow/view/borrow.dart';
import '../../buy-airtime/view/buy_airtime.dart';
import '../../pay-bills/view/pay_bills.dart';
import '../../send-money/view/send_money.dart';

var oCcy = new NumberFormat("#,##0.00", "en_US");

DateTime localDate(String date) {
  return DateTime.parse(date).toLocal();
}

getHomeHeader(bool isDarkMode, abbreviation, int size) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDarkMode
                  ? AppColors.greyDot
                  : Color.fromRGBO(61, 2, 230, 0.1)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                abbreviation,
                style: TextStyle(
                    fontFamily: "Mont",
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color:
                        isDarkMode ? AppColors.white : AppColors.primaryColor),
              ),
            ),
          ),
        ),
        Row(
          children: [
            // InkWell(
            //   onTap: () => Get.to(() => ComplaintScreen()),
            //   child: SvgPicture.asset(
            //     AppSvg.upload,
            //     height: 18,
            //     width: 20,
            //     color: isDarkMode ? AppColors.white : AppColors.black,
            //   ),
            // ),
            // addHorizontalSpace(24.w),
            InkWell(
                onTap: () => Get.to(() => NotificationScreen()),
                child: size == 0
                    ? Icon(
                        Icons.notifications,
                        color: isDarkMode ? AppColors.white : AppColors.black,
                      )
                    : badges.Badge(
                        child: Icon(
                          Icons.notifications,
                          color: isDarkMode ? AppColors.white : AppColors.black,
                        ),
                        badgeContent: SizedBox(
                            width: 18,
                            height: 10, //badge size
                            child: Center(
                              //aligh badge content to center
                              child: Text(size.toString(),
                                  style: TextStyle(
                                      color: Colors.white, //badge font color
                                      fontSize: 7.sp //badge font size
                                      )),
                            )),
                      )),
          ],
        )
      ],
    ),
  );
}

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    Key? key,
    required this.theme,
    required this.isDarkMode,
    required this.transactionType,
    this.transactionAmount,
    this.createdAt,
    this.balance,
    this.tfFee,
    this.commission,
    this.incoming,
    this.narration,
  }) : super(key: key);

  final ThemeData theme;
  final bool isDarkMode;
  final String transactionType;
  final num? transactionAmount;
  final String? createdAt;
  final num? balance;
  final num? tfFee;
  final commission;
  final bool? incoming;
  final String? narration;

  @override
  Widget build(BuildContext context) {
    String? tType;
    switch (transactionType) {
      case "FUNDS_TRANSFER":
        tType = "Funds Transfer";
        break;
      case "BILLS_PAYMENT":
        tType = "Bills";
        break;
      case "CASH_OUT":
        tType = "POS Withdrawal";
        break;
      case "WALLET_TOP_UP":
        tType = "Wallet Top Up";
        break;
      case "AIRTIME_VTU":
        tType = "Airtime Purchase";
        break;
      case "DEBIT":
        tType = "Debit";
        break;
      default:
        tType = "Funds Transfer";
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      transactionType == "BILLS_PAYMENT"
                          ? AppSvg.bill
                          : transactionType == "AIRTIME_VTU"
                              ? AppSvg.airtime
                              : transactionType == "CASH_OUT" ||
                                      transactionType == "WALLET_TOP_UP"
                                  ? AppSvg.swap
                                  : AppSvg.send,
                      color: incoming! ? AppColors.mainGreen : AppColors.red,
                      height: 18,
                      width: 18,
                    ),
                    addHorizontalSpace(5.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tType,
                          style: TextStyle(
                              fontFamily: "Mont",
                              fontSize: 10.sp,
                              color: isDarkMode
                                  ? AppColors.white
                                  : AppColors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        addVerticalSpace(5.h),
                        Container(
                          width: MediaQuery.of(context).size.width * .5,
                          child: Text(
                            DateFormat('h:mma\t.\tdd-MM-yyyy')
                                .format(localDate(createdAt!)),
                            style: TextStyle(
                                fontFamily: "Mont",
                                fontSize: 9.sp,
                                color: AppColors.inputLabelColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        addVerticalSpace(10.h),
                        Container(
                          width: MediaQuery.of(context).size.width * .5,
                          child: Text(
                            narration?.split("_").join(" ") ?? "",
                            style: TextStyle(
                                fontFamily: "Mont",
                                fontSize: 9.sp,
                                color: AppColors.greyText,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "₦ " +
                          (transactionAmount != null
                              ? oCcy
                                  .format(double.parse(
                                      transactionAmount!.toStringAsFixed(2)))
                                  .toString()
                              : "0.00"),
                      style: TextStyle(
                          fontFamily: "Mont",
                          fontSize: 9.sp,
                          color:
                              incoming! ? AppColors.mainGreen : AppColors.red,
                          fontWeight: FontWeight.w500),
                    ),
                    addVerticalSpace(5.h),
                    Text(
                      "Fee: ₦ " +
                          (tfFee != null
                              ? oCcy
                                  .format(
                                      double.parse(tfFee!.toStringAsFixed(2)))
                                  .toString()
                              : "0.00"),
                      style: TextStyle(
                          fontFamily: "Mont",
                          fontSize: 9.sp,
                          color: AppColors.inputLabelColor,
                          fontWeight: FontWeight.w500),
                    ),
                    addVerticalSpace(5.h),
                    Text(
                      "Balance: ₦ " +
                          (balance != null
                              ? oCcy
                                  .format(
                                      double.parse(balance!.toStringAsFixed(2)))
                                  .toString()
                              : "0.00"),
                      style: TextStyle(
                          fontFamily: "Mont",
                          fontSize: 9.sp,
                          color: AppColors.inputLabelColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Divider(
                thickness: .4,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SavingsCard extends StatelessWidget {
  const SavingsCard({
    Key? key,
    required this.theme,
    required this.isDarkMode,
    this.name,
    this.amount,
    this.savingsType,
    this.interestAccrued,
    this.startDate,
    this.maturityDate,
  }) : super(key: key);

  final ThemeData theme;
  final String? name;
  final bool isDarkMode;
  final num? amount;
  final String? savingsType;
  final num? interestAccrued;
  final String? startDate;
  final String? maturityDate;

  @override
  Widget build(BuildContext context) {
    var f = NumberFormat('#,##0.00########', 'en_Us');
    String? sType;
    switch (savingsType) {
      case "TARGET":
        sType = "Target Savings";
        break;
      case "LOCKED":
        sType = "Locked Funds";
        break;
      default:
        sType = "Target Savings";
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      AppSvg.send,
                      color: AppColors.mainGreen,
                      height: 18,
                      width: 18,
                    ),
                    addHorizontalSpace(5.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name!,
                          style: TextStyle(
                              fontFamily: "Mont",
                              fontSize: 10.sp,
                              color: isDarkMode
                                  ? AppColors.white
                                  : AppColors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        addVerticalSpace(5.h),
                        Container(
                          width: MediaQuery.of(context).size.width * .5,
                          child: Text(
                            "Start Date: " +
                                DateFormat('dd-MM-yyyy')
                                    .format(localDate(startDate!)),
                            style: TextStyle(
                                fontFamily: "Mont",
                                fontSize: 9.sp,
                                color: AppColors.inputLabelColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        addVerticalSpace(5.h),
                        Container(
                          width: MediaQuery.of(context).size.width * .5,
                          child: Text(
                            "Maturity Date: " +
                                (maturityDate == null
                                    ? "-"
                                    : DateFormat('dd-MM-yyyy')
                                        .format(localDate(maturityDate!))),
                            style: TextStyle(
                                fontFamily: "Mont",
                                fontSize: 9.sp,
                                color: AppColors.inputLabelColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "₦ " +
                          (amount != null
                              ? f
                                  .format(double.parse(amount!.toString()))
                                  .toString()
                              : "0.00"),
                      style: TextStyle(
                          fontFamily: "Mont",
                          fontSize: 14.sp,
                          color: AppColors.mainGreen,
                          fontWeight: FontWeight.w500),
                    ),
                    addVerticalSpace(5.h),
                    Text(
                      "Type: " + sType,
                      style: TextStyle(
                          fontFamily: "Mont",
                          fontSize: 9.sp,
                          color: AppColors.inputLabelColor,
                          fontWeight: FontWeight.w500),
                    ),
                    addVerticalSpace(5.h),
                    Text(
                      "Interest Accrued: ₦ " +
                          (interestAccrued != null
                              ? f
                                  .format(
                                      double.parse(interestAccrued.toString()))
                                  .toString()
                              : "0.00"),
                      style: TextStyle(
                          fontFamily: "Mont",
                          fontSize: 9.sp,
                          color: AppColors.inputLabelColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Divider(
                thickness: .4,
              ),
            )
          ],
        ),
      ),
    );
  }
}

getItems(isDark) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        itemOptions(
          isDark: isDark,
          iconColor: AppColors.mainGreen,
          color: isDark ? AppColors.greyDot : AppColors.grey,
          title: "Send",
          svg: AppSvg.send,
          onTap: () {
            Get.to(() => SendMoney());
          },
        ),
        itemOptions(
          isDark: isDark,
          iconColor: AppColors.primaryColor,
          color: isDark ? AppColors.greyDot : AppColors.grey,
          title: "Payments",
          svg: AppSvg.swap,
          onTap: () {
            Get.to(() => BorrowScren());
          },
        ),
        itemOptions(
          isDark: isDark,
          iconColor: AppColors.orangeWarning,
          color: isDark ? AppColors.greyDot : AppColors.grey,
          title: "Pay Bills",
          svg: AppSvg.bill,
          onTap: () {
            Get.to(() => PayBillsScreen());
          },
        ),
        itemOptions(
          isDark: isDark,
          iconColor: AppColors.red,
          color: isDark ? AppColors.greyDot : AppColors.grey,
          title: "Buy Airtime",
          svg: AppSvg.airtime,
          onTap: () {
            Get.to(() => BuyAirtimeScreen());
          },
        )
      ],
    ),
  );
}

// ignore: camel_case_types
class itemOptions extends StatelessWidget {
  itemOptions(
      {Key? key,
      required this.iconColor,
      required this.color,
      required this.svg,
      required this.title,
      required this.onTap,
      required this.isDark})
      : super(key: key);
  final Color iconColor;
  final Color color;
  final String svg;
  final String title;
  final bool isDark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            InkWell(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(shape: BoxShape.circle, color: color),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: SvgPicture.asset(svg,
                      height: 20.h, width: 20.w, color: iconColor),
                  // color: isDark ? AppColors.white : AppColors.black),
                ),
              ),
            ),
            addVerticalSpace(4.h),
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: "Mont",
                  fontSize: 10.sp,
                  color: isDark ? AppColors.white : AppColors.black),
            )
          ],
        ),
      ],
    );
  }
}

class BalanceCard extends StatelessWidget {
  const BalanceCard(
      {Key? key,
      required this.isDarkMode,
      required this.flag,
      required this.currency,
      required this.title,
      required this.symbol,
      required this.naira,
      required this.kobo,
      required this.bank,
      required this.buttontext,
      required this.buttonColor,
      required this.accountNumber,
      required this.bankVisible,
      required this.iconVisible,
      required this.copyVisible,
      required this.buttonVisible,
      required this.showAmount,
      required this.onTap,
      required this.setVisibility,
      this.isApproved = true,
      this.inReview = false})
      : super(key: key);

  final bool isDarkMode;
  final String flag;
  final String currency;
  final String title;
  final String symbol;
  final String naira;
  final String kobo;
  final String bank;
  final String buttontext;
  final String accountNumber;
  final Color buttonColor;
  final bool iconVisible;
  final bool bankVisible;
  final bool copyVisible;
  final bool buttonVisible;
  final bool showAmount;
  final VoidCallback onTap;
  final VoidCallback setVisibility;
  final bool isApproved;
  final bool inReview;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.89,
      // width: 279.w,
      decoration: BoxDecoration(
          color: isDarkMode ? AppColors.balanceCardDark : AppColors.card,
          borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 0, right: 15, left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Row(
                //   children: [
                //     ClipRRect(
                //       child: SvgPicture.asset(
                //         flag,
                //         height: 30,
                //         width: 30,
                //       ),
                //       borderRadius: BorderRadius.circular(30),
                //     ),
                //     addHorizontalSpace(
                //       5.w,
                //     ),
                //     Text(
                //       currency,
                //       style: TextStyle(
                //           fontFamily: "Mont",
                //           fontSize: 14.sp,
                //           color: isDarkMode ? AppColors.white : AppColors.black,
                //           fontWeight: FontWeight.w400),
                //     )
                //   ],
                // ),
                Text(
                  title,
                  style: TextStyle(
                      fontFamily: "Mont",
                      fontSize: 12.sp,
                      color: isDarkMode ? AppColors.white : AppColors.black,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
            addVerticalSpace(5.h),
            Row(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 60,
                      child: showAmount
                          ? Row(
                              children: [
                                Text(
                                  symbol,
                                  style: TextStyle(
                                      fontFamily: "Mont",
                                      fontSize: 14.sp,
                                      color: isDarkMode
                                          ? AppColors.white
                                          : AppColors.black,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  naira,
                                  style: TextStyle(
                                      fontFamily: "Mont",
                                      fontSize: 32.sp,
                                      color: isDarkMode
                                          ? AppColors.white
                                          : AppColors.black,
                                      fontWeight: FontWeight.w700),
                                ),
                                kobo != ""
                                    ? Text(
                                        ".",
                                        style: TextStyle(
                                            fontFamily: "Mont",
                                            fontSize: 32.sp,
                                            color: isDarkMode
                                                ? AppColors.white
                                                : AppColors.black,
                                            fontWeight: FontWeight.w700),
                                      )
                                    : Text(""),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    kobo,
                                    style: TextStyle(
                                        fontFamily: "Mont",
                                        fontSize: 16.sp,
                                        color: isDarkMode
                                            ? AppColors.white
                                            : AppColors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            )
                          : Row(
                              children: [
                                Text(
                                  "******",
                                  style: TextStyle(
                                      fontFamily: "Mont",
                                      fontSize: 26.sp,
                                      color: isDarkMode
                                          ? AppColors.white
                                          : AppColors.black,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                    ),
                    addHorizontalSpace(16.w),
                    InkWell(
                        onTap: setVisibility,
                        child: Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Container(
                            height: 20.h,
                            width: 20.w,
                            alignment: Alignment.topRight,
                            decoration: BoxDecoration(
                                color: isDarkMode
                                    ? AppColors.black
                                    : AppColors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Icon(
                                    showAmount
                                        ? CommunityMaterialIcons.eye_off_outline
                                        : CommunityMaterialIcons.eye_outline,
                                    size: 12,
                                    color: isDarkMode
                                        ? AppColors.white
                                        : AppColors.black),
                              ),
                            ),
                          ),
                        ))
                  ],
                )
              ],
            ),
            isApproved && !inReview ? addVerticalSpace(8.h) : SizedBox(),
            isApproved && !inReview
                ? Row(
                    mainAxisAlignment: bankVisible
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.start,
                    children: [
                      Visibility(
                          visible: bankVisible,
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    bank,
                                    style: TextStyle(
                                        fontFamily: "Mont",
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w700,
                                        color: isDarkMode
                                            ? AppColors.white
                                            : AppColors.black),
                                  ),
                                  Text(
                                    accountNumber,
                                    style: TextStyle(
                                        fontFamily: "Mont",
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w400,
                                        color: isDarkMode
                                            ? AppColors.greyText
                                            : AppColors.deepGrey),
                                  )
                                ],
                              ),
                              addHorizontalSpace(10.w),
                              GestureDetector(
                                  onTap: () => Platform.isIOS
                                      ? Clipboard.setData(ClipboardData(
                                              text: accountNumber))
                                          .then((value) => {
                                                CustomToastNotification.show(
                                                    "Account number has been copied successfully",
                                                    type: ToastType.success),
                                              })
                                      : FlutterClipboard.copy(accountNumber)
                                          .then((value) => {
                                                CustomToastNotification.show(
                                                    "Account number has been copied successfully",
                                                    type: ToastType.success),
                                              }),
                                  child: Container(
                                    color: Colors.transparent,
                                    alignment: Alignment.center,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            AppSvg.copy,
                                            height: 16,
                                          ),
                                        ]),
                                  )),
                            ],
                          )),
                      InkWell(
                          onTap: onTap,
                          child: Visibility(
                            visible: buttonVisible,
                            child: Container(
                              width: 95.w,
                              height: 24.h,
                              decoration: BoxDecoration(
                                  color: buttonColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Visibility(
                                      visible: iconVisible,
                                      child: Icon(
                                        Icons.add,
                                        color: AppColors.white,
                                        size: 14,
                                      ),
                                    ),
                                    addHorizontalSpace(5.w),
                                    Text(
                                      buttontext,
                                      style: TextStyle(
                                          fontFamily: "Mont",
                                          color: AppColors.white,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w700),
                                    )
                                  ]),
                            ),
                          )),
                    ],
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
// class BalanceCard extends StatelessWidget {
//   const BalanceCard(
//       {Key? key,
//       required this.isDarkMode,
//       required this.flag,
//       required this.currency,
//       required this.title,
//       required this.symbol,
//       required this.naira,
//       required this.kobo,
//       required this.bank,
//       required this.buttontext,
//       required this.buttonColor,
//       required this.accountNumber,
//       required this.bankVisible,
//       required this.iconVisible,
//       required this.copyVisible,
//       required this.buttonVisible,
//       required this.showAmount,
//       required this.onTap,
//       required this.setVisibility})
//       : super(key: key);

//   final bool isDarkMode;
//   final String flag;
//   final String currency;
//   final String title;
//   final String symbol;
//   final String naira;
//   final String kobo;
//   final String bank;
//   final String buttontext;
//   final String accountNumber;
//   final Color buttonColor;
//   final bool iconVisible;
//   final bool bankVisible;
//   final bool copyVisible;
//   final bool buttonVisible;
//   final bool showAmount;
//   final VoidCallback onTap;
//   final VoidCallback setVisibility;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 289.w,
//       decoration: BoxDecoration(
//           color: isDarkMode ? AppColors.balanceCardDark : AppColors.greyBg,
//           borderRadius: BorderRadius.circular(14)),
//       child: Padding(
//         padding: const EdgeInsets.only(top: 15, bottom: 0, right: 15, left: 15),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     ClipRRect(
//                       child: SvgPicture.asset(
//                         flag,
//                         height: 30,
//                         width: 30,
//                       ),
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     addHorizontalSpace(
//                       5.w,
//                     ),
//                     Text(
//                       currency,
//                       style: TextStyle(
//                           fontFamily: "Mont",
//                           fontSize: 14.sp,
//                           color: isDarkMode ? AppColors.white : AppColors.black,
//                           fontWeight: FontWeight.w400),
//                     )
//                   ],
//                 ),
//                 Text(
//                   title,
//                   style: TextStyle(
//                       fontFamily: "Mont",
//                       fontSize: 12.sp,
//                       color: isDarkMode ? AppColors.white : AppColors.black,
//                       fontWeight: FontWeight.w500),
//                 )
//               ],
//             ),
//             addVerticalSpace(5.h),
//             Row(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       height: 60,
//                       child: showAmount
//                           ? Row(
//                               children: [
//                                 Text(
//                                   symbol,
//                                   style: TextStyle(
//                                       fontFamily: "Mont",
//                                       fontSize: 14.sp,
//                                       color: isDarkMode
//                                           ? AppColors.white
//                                           : AppColors.black,
//                                       fontWeight: FontWeight.w700),
//                                 ),
//                                 Text(
//                                   naira,
//                                   style: TextStyle(
//                                       fontFamily: "Mont",
//                                       fontSize: 26.sp,
//                                       color: isDarkMode
//                                           ? AppColors.white
//                                           : AppColors.black,
//                                       fontWeight: FontWeight.w700),
//                                 ),
//                                 kobo != ""
//                                     ? Text(
//                                         ".",
//                                         style: TextStyle(
//                                             fontFamily: "Mont",
//                                             fontSize: 26.sp,
//                                             color: isDarkMode
//                                                 ? AppColors.white
//                                                 : AppColors.black,
//                                             fontWeight: FontWeight.w700),
//                                       )
//                                     : Text(""),
//                                 Container(
//                                   margin: EdgeInsets.only(top: 5),
//                                   child: Text(
//                                     kobo,
//                                     style: TextStyle(
//                                         fontFamily: "Mont",
//                                         fontSize: 16.sp,
//                                         color: isDarkMode
//                                             ? AppColors.white
//                                             : AppColors.black,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                 )
//                               ],
//                             )
//                           : Row(
//                               children: [
//                                 Text(
//                                   "******",
//                                   style: TextStyle(
//                                       fontFamily: "Mont",
//                                       fontSize: 26.sp,
//                                       color: isDarkMode
//                                           ? AppColors.white
//                                           : AppColors.black,
//                                       fontWeight: FontWeight.w700),
//                                 ),
//                               ],
//                             ),
//                     ),
//                     addHorizontalSpace(24.w),
//                     InkWell(
//                       onTap: setVisibility,
//                       child: Container(
//                         height: 36.h,
//                         width: 36.w,
//                         alignment: Alignment.topRight,
//                         decoration: BoxDecoration(
//                             color:
//                                 isDarkMode ? AppColors.black : AppColors.white,
//                             borderRadius: BorderRadius.circular(10)),
//                         child: Center(
//                           child: Padding(
//                             padding: const EdgeInsets.all(0.0),
//                             child: Icon(
//                                 showAmount
//                                     ? CommunityMaterialIcons.eye_off_outline
//                                     : CommunityMaterialIcons.eye_outline,
//                                 size: 18,
//                                 color: isDarkMode
//                                     ? AppColors.white
//                                     : AppColors.black),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 )
//               ],
//             ),
//             addVerticalSpace(8.h),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 InkWell(
//                     onTap: onTap,
//                     child: Visibility(
//                       visible: buttonVisible,
//                       child: Container(
//                         width: 122.w,
//                         height: 32.h,
//                         decoration: BoxDecoration(
//                             color: buttonColor,
//                             borderRadius: BorderRadius.circular(5)),
//                         child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Visibility(
//                                 visible: iconVisible,
//                                 child: Icon(
//                                   Icons.add,
//                                   color: AppColors.white,
//                                   size: 18,
//                                 ),
//                               ),
//                               addHorizontalSpace(5.w),
//                               Text(
//                                 buttontext,
//                                 style: TextStyle(
//                                     fontFamily: "Mont",
//                                     color: AppColors.white,
//                                     fontSize: 12.sp,
//                                     fontWeight: FontWeight.w700),
//                               )
//                             ]),
//                       ),
//                     )),
//                 Visibility(
//                   visible: bankVisible,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         bank,
//                         style: TextStyle(
//                             fontFamily: "Mont",
//                             fontSize: 11.sp,
//                             fontWeight: FontWeight.w700,
//                             color:
//                                 isDarkMode ? AppColors.white : AppColors.black),
//                       ),
//                       Text(
//                         accountNumber,
//                         style: TextStyle(
//                             fontFamily: "Mont",
//                             fontSize: 11.sp,
//                             fontWeight: FontWeight.w400,
//                             color: isDarkMode
//                                 ? AppColors.greyText
//                                 : AppColors.deepGrey),
//                       )
//                     ],
//                   ),
//                 ),
//                 GestureDetector(
//                     onTap: () => Platform.isIOS
//                         ? Clipboard.setData(ClipboardData(text: accountNumber))
//                             .then((value) => {
//                                   CustomToastNotification.show(
//                                       "Account number has been copied successfully",
//                                       type: ToastType.success),
//                                 })
//                         : FlutterClipboard.copy(accountNumber).then((value) => {
//                               CustomToastNotification.show(
//                                   "Account number has been copied successfully",
//                                   type: ToastType.success),
//                             }),
//                     child: Container(
//                       color: Colors.transparent,
//                       alignment: Alignment.center,
//                       child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             SvgPicture.asset(
//                               AppSvg.copy,
//                               height: 16,
//                             ),
//                           ]),
//                     )),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
