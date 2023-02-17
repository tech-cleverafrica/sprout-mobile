import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

import '../../utils/app_formatter.dart';

class NFCScreen extends StatelessWidget {
  NFCScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getHeader(isDarkMode),
              addVerticalSpace(50.h),
              Container(
                alignment: Alignment.center,
                width: 150.w,
                child: Text(
                    "Please tap your card on the NFC feature behind the phone",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "DMSans",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color:
                            isDarkMode ? AppColors.greyText : AppColors.black)),
              ),
              addVerticalSpace(40.h),
              Container(
                height: 222.h,
                width: 222.w,
                decoration: BoxDecoration(
                    color: isDarkMode
                        ? AppColors.greyDot.withOpacity(0.5)
                        : AppColors.grey.withOpacity(0.3),
                    shape: BoxShape.circle),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: isDarkMode
                            ? AppColors.greyDot.withOpacity(0.7)
                            : AppColors.grey.withOpacity(0.5),
                        shape: BoxShape.circle),
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: isDarkMode
                                ? AppColors.greyDot.withOpacity(0.9)
                                : AppColors.grey.withOpacity(0.7),
                            shape: BoxShape.circle),
                        child: Center(
                          child: SvgPicture.asset(AppSvg.nfc),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
