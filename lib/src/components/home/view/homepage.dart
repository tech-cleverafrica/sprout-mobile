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
              )
            ],
          )
        ],
      ),
    );
  }
}
