import 'dart:ui';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';

import '../../../utils/app_images.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          addVerticalSpace(20.h),
          getHeader(isDarkMode),
          addVerticalSpace(20.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Text(
                  "Hi",
                  style: TextStyle(
                    color: isDarkMode ? AppColors.white : AppColors.black,
                    fontFamily: "DMSans",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                addHorizontalSpace(5.w),
                Text(
                  "Mubarak,",
                  style: theme.textTheme.headline2,
                )
              ],
            ),
          ),
          addVerticalSpace(20.h),
          getDisplaySwitch(isDarkMode),
          addVerticalSpace(10.h),
          SizedBox(
            height: 160.h,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24),
              scrollDirection: Axis.horizontal,
              children: [
                BalanceCard(
                  isDarkMode: isDarkMode,
                  flag: AppSvg.nigeria,
                  currency: "Naira",
                  title: "Available Balance",
                  symbol: "N",
                  balance: "19,260.00",
                  bank: "Providus Bank",
                  accountNumber: "0087642335",
                  buttontext: "Fund Account",
                  buttonColor: AppColors.primaryColor,
                  copyVisible: true,
                  iconVisible: true,
                  bankVisible: true,
                  buttonVisible: true,
                ),
                addHorizontalSpace(10.w),
                BalanceCard(
                  isDarkMode: isDarkMode,
                  flag: AppSvg.nigeria,
                  currency: "Naira",
                  title: "Savings Balance",
                  symbol: "N",
                  balance: "19,260.00",
                  bank: "Providus Bank",
                  accountNumber: "0087642335",
                  buttontext: "Details",
                  buttonColor: AppColors.black,
                  copyVisible: false,
                  iconVisible: false,
                  bankVisible: false,
                  buttonVisible: true,
                ),
                addHorizontalSpace(10.w),
                BalanceCard(
                  isDarkMode: isDarkMode,
                  flag: AppSvg.usa,
                  currency: "USD",
                  title: "Account Balance",
                  symbol: 'N',
                  balance: "120.00 ",
                  bank: "Providus Bank",
                  accountNumber: "0087642335",
                  buttontext: "Details",
                  buttonColor: AppColors.black,
                  copyVisible: false,
                  iconVisible: false,
                  bankVisible: false,
                  buttonVisible: false,
                )
              ],
            ),
          ),
          addVerticalSpace(15.h),
          getItems(isDarkMode),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            height: 132.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 24),
              children: [
                Container(
                  width: 210.w,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Complete Account Setup",
                          style: TextStyle(
                              fontFamily: "DMSans",
                              fontSize: 12.sp,
                              color: AppColors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        addVerticalSpace(50.h),
                        Container(
                          height: 37.h,
                          width: 127.w,
                          decoration: BoxDecoration(
                              color: isDarkMode
                                  ? AppColors.black
                                  : AppColors.white,
                              borderRadius: BorderRadius.circular(10)),
                          alignment: Alignment.topRight,
                          child: Center(
                              child: Text(
                            "Complete",
                            style: theme.textTheme.headline3,
                          )),
                        )
                      ],
                    ),
                  ),
                ),
                addHorizontalSpace(10.w),
                Container(
                  width: 210.w,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Complete Account Setup",
                          style: TextStyle(
                              fontFamily: "DMSans",
                              fontSize: 12.sp,
                              color: AppColors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        addVerticalSpace(50.h),
                        Container(
                          height: 37.h,
                          width: 127.w,
                          decoration: BoxDecoration(
                              color: isDarkMode
                                  ? AppColors.black
                                  : AppColors.white,
                              borderRadius: BorderRadius.circular(10)),
                          alignment: Alignment.topRight,
                          child: Center(
                              child: Text(
                            "Complete",
                            style: theme.textTheme.headline3,
                          )),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          addVerticalSpace(20.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent Transactions",
                  style: TextStyle(
                      fontFamily: "DMSans",
                      fontSize: 12.sp,
                      color: isDarkMode
                          ? AppColors.inputLabelColor
                          : AppColors.greyText,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "Sell All",
                  style: TextStyle(
                      fontFamily: "DMSans",
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                      fontSize: 12.sp,
                      color: isDarkMode
                          ? AppColors.inputLabelColor
                          : AppColors.greyText,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          addVerticalSpace(24.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                          ),
                          addHorizontalSpace(5.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Fund Transfer",
                                style: theme.textTheme.headline3,
                              ),
                              addVerticalSpace(5.h),
                              Container(
                                width: 180.w,
                                child: Text(
                                  "Transfer Ref - TSWTAYSSUISPPLNDVD L - ",
                                  style: TextStyle(
                                      fontFamily: "DMSans",
                                      fontSize: 10.sp,
                                      color: isDarkMode
                                          ? AppColors.inputLabelColor
                                          : AppColors.greyText,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              addVerticalSpace(5.h),
                              Container(
                                width: 180.w,
                                child: Text(
                                  "From - TSWTAYSSUISPPLNDsdffadhjjkjhvfdhdVD L - ",
                                  style: TextStyle(
                                      fontFamily: "DMSans",
                                      fontSize: 10.sp,
                                      color: isDarkMode
                                          ? AppColors.inputLabelColor
                                          : AppColors.greyText,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              addVerticalSpace(5.h),
                              Container(
                                width: 180.w,
                                child: Text(
                                  "24 July, 2022. 10:40pm ",
                                  style: TextStyle(
                                      fontFamily: "DMSans",
                                      fontSize: 10.sp,
                                      color: isDarkMode
                                          ? AppColors.inputLabelColor
                                          : AppColors.greyText,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Text(
                        "N20,000",
                        style: TextStyle(
                            fontFamily: "DMSans",
                            color: AppColors.mainGreen,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      thickness: 2,
                    ),
                  )
                ],
              ),
            ),
          )
        ])),
      ),
    );
  }

  getHeader(bool isDarkMode) {
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
                  "HM",
                  style: TextStyle(
                      fontFamily: "DMSans",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode
                          ? AppColors.white
                          : AppColors.primaryColor),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Image.asset(
                AppImages.question,
                height: 20,
                color: isDarkMode ? AppColors.white : AppColors.black,
              ),
              addHorizontalSpace(10.w),
              SvgPicture.asset(
                AppSvg.notification,
                color: isDarkMode ? AppColors.white : AppColors.black,
              ),
            ],
          )
        ],
      ),
    );
  }

  getDisplaySwitch(bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: isDarkMode ? AppColors.greyDot : AppColors.grey),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 8, bottom: 8, right: 10, left: 10),
                child: Text(
                  "Account",
                  style: TextStyle(
                      fontFamily: "DmSans",
                      fontSize: 14.sp,
                      color:
                          isDarkMode ? AppColors.white : AppColors.primaryColor,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 8, right: 10, left: 10),
                  child: Text(
                    "Invoice",
                    style: TextStyle(
                        fontFamily: "DmSans",
                        fontSize: 14.sp,
                        color: isDarkMode ? AppColors.grey : AppColors.greyText,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          )
        ],
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
          color: isDark ? AppColors.greyDot : AppColors.grey,
          title: "Send",
          svg: AppSvg.send,
        ),
        itemOptions(
          isDark: isDark,
          color: isDark ? AppColors.greyDot : AppColors.grey,
          title: "Payments",
          svg: AppSvg.swap,
        ),
        itemOptions(
          isDark: isDark,
          color: isDark ? AppColors.greyDot : AppColors.grey,
          title: "Pay Bills",
          svg: AppSvg.bill,
        ),
        itemOptions(
          isDark: isDark,
          color: isDark ? AppColors.greyDot : AppColors.grey,
          title: "Buy Airtimes",
          svg: AppSvg.airtime,
        )
      ],
    ),
  );
}

class itemOptions extends StatelessWidget {
  itemOptions(
      {Key? key,
      required this.color,
      required this.svg,
      required this.title,
      required this.isDark})
      : super(key: key);
  final Color color;
  final String svg;
  final String title;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Container(
              height: 100,
              width: 70,
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: SvgPicture.asset(svg,
                    height: 20,
                    width: 20,
                    color: isDark ? AppColors.white : AppColors.black),
              ),
            ),
            addVerticalSpace(10.h),
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
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
      required this.balance,
      required this.bank,
      required this.buttontext,
      required this.buttonColor,
      required this.accountNumber,
      required this.bankVisible,
      required this.iconVisible,
      required this.copyVisible,
      required this.buttonVisible})
      : super(key: key);

  final bool isDarkMode;
  final String flag;
  final String currency;
  final String title;
  final String symbol;
  final String balance;
  final String bank;
  final String buttontext;
  final String accountNumber;
  final Color buttonColor;
  final bool iconVisible;
  final bool bankVisible;
  final bool copyVisible;
  final bool buttonVisible;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 210.w,
      decoration: BoxDecoration(
          color: isDarkMode ? AppColors.balanceCardDark : AppColors.greyBg,
          borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      child: SvgPicture.asset(flag),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    addHorizontalSpace(
                      5.w,
                    ),
                    Text(currency)
                  ],
                ),
                Text(title)
              ],
            ),
            addVerticalSpace(15.h),
            Row(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          symbol,
                          style: TextStyle(
                              fontFamily: "DMSans",
                              fontSize: 8.sp,
                              color: isDarkMode
                                  ? AppColors.white
                                  : AppColors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          balance,
                          style: TextStyle(
                              fontFamily: "DMSans",
                              fontSize: 27.sp,
                              color: isDarkMode
                                  ? AppColors.white
                                  : AppColors.black,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    addHorizontalSpace(70.w),
                    Container(
                      alignment: Alignment.topRight,
                      decoration: BoxDecoration(
                          color: isDarkMode ? AppColors.black : AppColors.white,
                          borderRadius: BorderRadius.circular(7)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(CommunityMaterialIcons.eye_off_outline,
                            size: 18,
                            color:
                                isDarkMode ? AppColors.white : AppColors.black),
                      ),
                    )
                  ],
                )
              ],
            ),
            addVerticalSpace(20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: buttonVisible,
                  child: Container(
                    width: 80.w,
                    height: 32.h,
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
                              size: 18,
                            ),
                          ),
                          addHorizontalSpace(5.w),
                          Text(
                            buttontext,
                            style: TextStyle(
                                fontFamily: "DMSans",
                                color: AppColors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700),
                          )
                        ]),
                  ),
                ),
                Visibility(
                  visible: bankVisible,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bank,
                        style: TextStyle(
                            fontFamily: "DMSans",
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w700,
                            color:
                                isDarkMode ? AppColors.white : AppColors.black),
                      ),
                      Text(
                        accountNumber,
                        style: TextStyle(
                            fontFamily: "DMSans",
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w700,
                            color: isDarkMode
                                ? AppColors.greyText
                                : AppColors.greyText),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: copyVisible,
                  child: SvgPicture.asset(
                    AppSvg.copy,
                    height: 30,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
