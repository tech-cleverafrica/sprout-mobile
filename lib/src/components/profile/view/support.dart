import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';

import '../../../public/widgets/custom_button.dart';
import '../../../utils/app_svgs.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

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
                thickness: 0.4,
                color: isDarkMode ? AppColors.white : AppColors.black,
              ),
              addVerticalSpace(10.h),
              InkWell(
                onTap: () {
                  showPopUp(context, isDarkMode, theme);
                },
                child: Row(
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
              ),
              addVerticalSpace(10.h),
              Divider(
                thickness: 0.4,
                color: isDarkMode ? AppColors.white : AppColors.black,
              )
            ],
          ),
        ),
      ),
    );
  }

  showPopUp(context, isDarkMode, theme) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: ((context) {
          return Dialog(
            backgroundColor: isDarkMode ? AppColors.greyDot : AppColors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              height: 230.h,
              width: 200.w,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Cancel",
                          style: theme.textTheme.headline6,
                        ),
                        InkWell(
                            onTap: () => Get.back(),
                            child: SvgPicture.asset(AppSvg.cancel))
                      ],
                    ),
                    addVerticalSpace(10.h),
                    Text("Call Customer Support"),
                    addVerticalSpace(10.h),
                    Text(
                      "+234-9070866545",
                      style: theme.textTheme.headline2,
                    ),
                    addVerticalSpace(15.h),
                    CustomButton(
                      title: "Call now",
                      onTap: () {},
                    )
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
