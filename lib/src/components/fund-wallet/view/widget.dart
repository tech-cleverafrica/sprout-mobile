import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_svgs.dart';
import '../../../utils/helper_widgets.dart';

class FundWalletCard extends StatelessWidget {
  const FundWalletCard(
      {Key? key,
      required this.isDarkMode,
      required this.flag,
      required this.currency,
      required this.title,
      required this.symbol,
      required this.naira,
      required this.kobo,
      required this.bank,
      required this.accountNumber,
      required this.onTap})
      : super(key: key);

  final bool isDarkMode;
  final String flag;
  final String currency;
  final String title;
  final String symbol;
  final String naira;
  final String kobo;
  final String bank;
  final String accountNumber;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          color: isDarkMode ? AppColors.balanceCardDark : AppColors.greyBg,
          borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 15, bottom: 15, right: 15, left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      child: SvgPicture.asset(
                        flag,
                        height: 30,
                        width: 30,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    addHorizontalSpace(
                      5.w,
                    ),
                    Text(
                      currency,
                      style: TextStyle(
                          fontFamily: "DMSans",
                          fontSize: 14.sp,
                          color: isDarkMode ? AppColors.white : AppColors.black,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontFamily: "DMSans",
                      fontSize: 12.sp,
                      color: isDarkMode ? AppColors.white : AppColors.black,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
            addVerticalSpace(5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      height: 70,
                      child: Row(
                        children: [
                          Text(
                            symbol,
                            style: TextStyle(
                                fontFamily: "DMSans",
                                fontSize: 20.sp,
                                color: isDarkMode
                                    ? AppColors.white
                                    : AppColors.black,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            naira,
                            style: TextStyle(
                                fontFamily: "DMSans",
                                fontSize: 36.sp,
                                color: isDarkMode
                                    ? AppColors.white
                                    : AppColors.black,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            ".",
                            style: TextStyle(
                                fontFamily: "DMSans",
                                fontSize: 26.sp,
                                color: isDarkMode
                                    ? AppColors.white
                                    : AppColors.black,
                                fontWeight: FontWeight.w700),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                              kobo,
                              style: TextStyle(
                                  fontFamily: "DMSans",
                                  fontSize: 20.sp,
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            addVerticalSpace(8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: true,
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
                            fontWeight: FontWeight.w400,
                            color: isDarkMode
                                ? AppColors.greyText
                                : AppColors.deepGrey),
                      )
                    ],
                  ),
                ),
                addHorizontalSpace(12.w),
                Visibility(
                  visible: true,
                  child: SvgPicture.asset(
                    AppSvg.copy,
                    height: 20,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FundingCard extends StatelessWidget {
  const FundingCard({
    Key? key,
    required this.isDarkMode,
    required this.title,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final bool isDarkMode;
  final String title;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        height: 68,
        width: double.infinity,
        padding: EdgeInsets.only(left: 15, top: 16, right: 16, bottom: 7),
        decoration: BoxDecoration(
            color: isDarkMode
                ? AppColors.hoverBlack.withOpacity(0.9)
                : AppColors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: isDarkMode
                    ? AppColors.transparent
                    : Colors.grey.withAlpha(300),
                spreadRadius: 2,
                blurRadius: isDarkMode ? 2 : 10,
              ),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: isDarkMode ? AppColors.white : AppColors.black,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 5),
            Text(
              text,
              style: TextStyle(
                color: isDarkMode ? AppColors.white : AppColors.black,
                fontSize: 9.sp,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
