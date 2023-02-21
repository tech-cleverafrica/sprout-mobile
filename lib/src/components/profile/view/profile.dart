import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/profile/view/security_settings.dart';
import 'package:sprout_mobile/src/components/profile/view/support.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/app_images.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';

import '../../../theme/theme_service.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getHeader(isDarkMode),
                addVerticalSpace(15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          child: Image.asset(
                            AppImages.profile_holder,
                          ),
                        ),
                        addHorizontalSpace(15.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Enahoro Uanseoje",
                              style: TextStyle(
                                  fontFamily: "DMSans",
                                  fontSize: 18.sp,
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              'davejossy9@gmail.com',
                              style: TextStyle(
                                  fontFamily: "DMSans",
                                  fontSize: 13.sp,
                                  color: isDarkMode
                                      ? AppColors.greyText
                                      : AppColors.greyText,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        )
                      ],
                    ),
                    SvgPicture.asset(
                      AppSvg.pendown,
                      color: AppColors.primaryColor,
                    )
                  ],
                ),
                addVerticalSpace(12.h),
                Divider(
                  thickness: 0.3,
                  color: isDarkMode
                      ? AppColors.semi_white.withOpacity(0.3)
                      : AppColors.inputLabelColor.withOpacity(0.6),
                ),
                addVerticalSpace(20.h),
                Row(
                  children: [
                    Text(
                      "Client ID:",
                      style: TextStyle(
                          fontFamily: "DMSans",
                          fontSize: 13.sp,
                          color: isDarkMode
                              ? AppColors.greyText
                              : AppColors.greyText,
                          fontWeight: FontWeight.w400),
                    ),
                    addHorizontalSpace(5.w),
                    Text(
                      "2345453",
                      style: TextStyle(
                          fontFamily: "DMSans",
                          fontSize: 13.sp,
                          color: isDarkMode
                              ? AppColors.greyText
                              : AppColors.greyText,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                addVerticalSpace(5.h),
                Row(
                  children: [
                    Text(
                      "0763652122",
                      style: TextStyle(
                          fontFamily: "DMSans",
                          fontSize: 13.sp,
                          color: isDarkMode
                              ? AppColors.greyText
                              : AppColors.greyText,
                          fontWeight: FontWeight.w400),
                    ),
                    addHorizontalSpace(5.w),
                    Text(
                      "Providus Bank",
                      style: TextStyle(
                          fontFamily: "DMSans",
                          fontSize: 13.sp,
                          color: isDarkMode
                              ? AppColors.greyText
                              : AppColors.greyText,
                          fontWeight: FontWeight.w700),
                    ),
                    addHorizontalSpace(15.w),
                    SvgPicture.asset(
                      AppSvg.copy,
                      color: AppColors.mainGreen,
                    )
                  ],
                ),
                addVerticalSpace(16.h),
                Divider(
                  thickness: 0.3,
                  color: isDarkMode
                      ? AppColors.semi_white.withOpacity(0.3)
                      : AppColors.inputLabelColor.withOpacity(0.6),
                ),
                addVerticalSpace(24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Switch to light mode",
                      style: TextStyle(
                          fontFamily: "DMSans",
                          fontSize: 13.sp,
                          color: isDarkMode
                              ? AppColors.semi_white.withOpacity(0.8)
                              : AppColors.greyText,
                          fontWeight: FontWeight.w700),
                    ),
                    CupertinoSwitch(
                        activeColor: AppColors.primaryColor,
                        thumbColor: AppColors.white,
                        value: isTapped,
                        onChanged: (val) {
                          ThemeService().changeThemeMode();
                          isTapped = !isTapped;
                        })
                  ],
                ),
                addVerticalSpace(20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(AppSvg.security),
                        addHorizontalSpace(10.w),
                        Text(
                          "Security settings",
                          style: TextStyle(
                              color: isDarkMode
                                  ? AppColors.white
                                  : AppColors.greyDot,
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp),
                        )
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          Get.to(() => SecuritySettings());
                        },
                        icon: Icon(Icons.arrow_forward_ios))
                  ],
                ),
                addVerticalSpace(15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(AppSvg.download_statement),
                        addHorizontalSpace(10.w),
                        Text(
                          "Download statement",
                          style: TextStyle(
                              color: isDarkMode
                                  ? AppColors.white
                                  : AppColors.greyDot,
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp),
                        )
                      ],
                    ),
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.arrow_forward_ios))
                  ],
                ),
                addVerticalSpace(15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(AppSvg.support),
                        addHorizontalSpace(10.w),
                        Text(
                          "Support",
                          style: TextStyle(
                              color: isDarkMode
                                  ? AppColors.white
                                  : AppColors.greyDot,
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp),
                        )
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          Get.to(() => SupportScreen());
                        },
                        icon: Icon(Icons.arrow_forward_ios))
                  ],
                ),
                addVerticalSpace(15.h),
                Row(
                  children: [
                    SvgPicture.asset(AppSvg.privacy),
                    addHorizontalSpace(10.w),
                    Text(
                      "Privacy Policy",
                      style: TextStyle(
                          color:
                              isDarkMode ? AppColors.white : AppColors.greyDot,
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp),
                    )
                  ],
                ),
                addVerticalSpace(60.h),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppSvg.logout,
                        color: isDarkMode ? AppColors.white : AppColors.greyDot,
                      ),
                      addHorizontalSpace(10.w),
                      Text(
                        "Log out",
                        style: TextStyle(
                            color: isDarkMode
                                ? AppColors.white
                                : AppColors.greyDot,
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp),
                      )
                    ],
                  ),
                ),
                addVerticalSpace(60.h),
                Center(
                  child: Text(
                    "V.S.1.0.0",
                    style: TextStyle(
                        fontFamily: "DMSans",
                        fontSize: 13.sp,
                        color:
                            isDarkMode ? AppColors.white : AppColors.greyText,
                        fontWeight: FontWeight.w700),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
