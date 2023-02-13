import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';

class Themes {
  final lightTheme = ThemeData.light().copyWith(
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.white,
      textTheme: TextTheme(
        // TextStyle? headline2,
        // TextStyle? headline3,
        // TextStyle? headline4,
        // TextStyle? headline5,
        // TextStyle? headline6,
        // TextStyle? subtitle1,
        // TextStyle? subtitle2,
        // TextStyle? bodyText1,

        headline1: TextStyle(
          color: AppColors.black,
          fontFamily: "DMSans",
          fontSize: 24.sp,
          fontWeight: FontWeight.w700,
        ),
        subtitle1: TextStyle(
            fontFamily: "DMSans",
            fontSize: 20.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.black),
        bodyText2: TextStyle(
            fontFamily: "DMSans",
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.greyText),
      ));

  final darkTheme = ThemeData.dark().copyWith(
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.black,
      textTheme: TextTheme(
        headline1: TextStyle(
          color: AppColors.white,
          fontFamily: "DMSans",
          fontSize: 24.sp,
          fontWeight: FontWeight.w700,
        ),
        subtitle1: TextStyle(
            fontFamily: "DMSans",
            fontSize: 20.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.black),
        bodyText2: TextStyle(
            fontFamily: "DMSans",
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.white),
      ));
}
