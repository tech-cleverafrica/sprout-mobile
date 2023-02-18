import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';

import '../../../utils/app_svgs.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getHeader(isDarkMode),
              addVerticalSpace(15.h),
              Row(
                children: [
                  SvgPicture.asset(AppSvg.faqs),
                  Text(
                    "FAQs",
                    style: TextStyle(
                        fontFamily: "DMSans",
                        fontSize: 14.sp,
                        color: isDarkMode ? AppColors.white : AppColors.black,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              addVerticalSpace(10.h),
              Divider(
                color: isDarkMode ? AppColors.white : AppColors.white,
              ),
              addVerticalSpace(10.h),
              Row(
                children: [
                  SvgPicture.asset(AppSvg.ccs),
                  Text(
                    "Contact Customer Support",
                    style: TextStyle(
                        fontFamily: "DMSans",
                        fontSize: 14.sp,
                        color: isDarkMode ? AppColors.white : AppColors.black,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              addVerticalSpace(10.h),
              Divider(
                color: isDarkMode ? AppColors.white : AppColors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
