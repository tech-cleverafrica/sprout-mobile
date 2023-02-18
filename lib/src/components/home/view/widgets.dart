import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/home/controller/home_controller.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_svgs.dart';
import '../../../utils/helper_widgets.dart';
import '../../borow/borrow.dart';
import '../../buy-airtime/view/buy-airtime.dart';
import '../../pay-bills/view/pay_bills.dart';
import '../../send-money/view/send_money.dart';

getHomeHeader(bool isDarkMode) {
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
                    color:
                        isDarkMode ? AppColors.white : AppColors.primaryColor),
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

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    Key? key,
    required this.theme,
    required this.isDarkMode,
    required this.text,
  }) : super(key: key);

  final ThemeData theme;
  final bool isDarkMode;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
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
                          text,
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
          onTap: () {
            Get.to(() => SendMoney());
          },
        ),
        itemOptions(
          isDark: isDark,
          color: isDark ? AppColors.greyDot : AppColors.grey,
          title: "Payments",
          svg: AppSvg.swap,
          onTap: () {
            Get.to(() => BorrowScren());
          },
        ),
        itemOptions(
          isDark: isDark,
          color: isDark ? AppColors.greyDot : AppColors.grey,
          title: "Pay Bills",
          svg: AppSvg.bill,
          onTap: () {
            Get.to(() => PayBillsScreen());
          },
        ),
        itemOptions(
          isDark: isDark,
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

class itemOptions extends StatelessWidget {
  itemOptions(
      {Key? key,
      required this.color,
      required this.svg,
      required this.title,
      required this.onTap,
      required this.isDark})
      : super(key: key);
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
            ),
            addVerticalSpace(0.h),
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: "DMSans",
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
