import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';

import '../../../utils/app_colors.dart';

class SecuritySettings extends StatelessWidget {
  SecuritySettings({super.key});

  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
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
                  SvgPicture.asset(AppSvg.change_pin),
                  Text(
                    "Change PIN",
                    style: TextStyle(
                        fontFamily: "DMSans",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              Divider(
                color: isDarkMode ? AppColors.white : AppColors.white,
              ),
              addVerticalSpace(10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(AppSvg.face_id),
                      Text(
                        "Enable Face ID",
                        style: TextStyle(
                            fontFamily: "DMSans",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  CupertinoSwitch(
                      activeColor: AppColors.primaryColor,
                      thumbColor: AppColors.white,
                      value: isTapped,
                      onChanged: (val) {
                        isTapped = !isTapped;
                      })
                ],
              ),
              Divider(
                color: isDarkMode ? AppColors.white : AppColors.white,
              ),
              addVerticalSpace(10.h),
              Row(
                children: [
                  SvgPicture.asset(AppSvg.change_password),
                  Text(
                    "Change Login Password",
                    style: TextStyle(
                        fontFamily: "DMSans",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
