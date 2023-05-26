import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sprout_mobile/utils/app_colors.dart';

class Themes {
  final lightTheme = ThemeData.light().copyWith(
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.white,
      textTheme: TextTheme(
        headline1: TextStyle(
          color: AppColors.black,
          fontFamily: "Mont",
          fontSize: 24.sp,
          fontWeight: FontWeight.w700,
        ),
        headline2: TextStyle(
          color: AppColors.black,
          fontFamily: "Mont",
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
        ),
        headline3: TextStyle(
          color: AppColors.black,
          fontFamily: "Mont",
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
        ),
        headline6: TextStyle(
          color: AppColors.black,
          fontFamily: "Mont",
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
        ),
        subtitle1: TextStyle(
            fontFamily: "Mont",
            fontSize: 20.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.black),
        subtitle2: TextStyle(
            fontFamily: "Mont",
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.greyText),
        bodyText2: TextStyle(
            fontFamily: "Mont",
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.greyText),
        bodyText1: TextStyle(
          color: AppColors.greyText,
          fontFamily: "Mont",
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
        ),
      ));

  final darkTheme = ThemeData.dark().copyWith(
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.black,
      textTheme: TextTheme(
        headline1: TextStyle(
          color: AppColors.white,
          fontFamily: "Mont",
          fontSize: 24.sp,
          fontWeight: FontWeight.w700,
        ),
        headline2: TextStyle(
          color: AppColors.white,
          fontFamily: "Mont",
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
        ),
        headline3: TextStyle(
          color: AppColors.white,
          fontFamily: "Mont",
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
        ),
        headline6: TextStyle(
          color: AppColors.white,
          fontFamily: "Mont",
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
        ),
        bodyText1: TextStyle(
          color: AppColors.white,
          fontFamily: "Mont",
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
        ),
        subtitle1: TextStyle(
            fontFamily: "Mont",
            fontSize: 20.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.white),
        subtitle2: TextStyle(
            fontFamily: "Mont",
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.white),
        bodyText2: TextStyle(
            fontFamily: "Mont",
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.grey),
      ));
}
