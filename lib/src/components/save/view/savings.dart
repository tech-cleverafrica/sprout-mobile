import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sprout_mobile/src/public/widgets/custom_button.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/app_images.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';

import '../../../utils/app_colors.dart';

class SavingsScreen extends StatelessWidget {
  const SavingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getHeader(isDarkMode),
              addVerticalSpace(15.h),
              getDisplaySwitch(isDarkMode),
              addVerticalSpace(20.h),
              Container(
                width: double.infinity,
                height: 284.h,
                decoration: BoxDecoration(
                    color: AppColors.deepOrange,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage(AppImages.padlock),
                        fit: BoxFit.cover)),
                child: Column(
                  children: [
                    addVerticalSpace(50.h),
                    Container(
                        width: 200.w,
                        child: Text(
                          "Save with Sprout",
                          style: TextStyle(
                              fontFamily: "DMSans",
                              fontSize: 44.sp,
                              letterSpacing: 1,
                              color: AppColors.white,
                              fontWeight: FontWeight.w900),
                        )),
                    addVerticalSpace(10.h),
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(AppImages.overlay),
                              fit: BoxFit.cover)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 110.w,
                              child: Text(
                                "Lorem ipsum dolor sit amet consectetur. Placerat lorem neque risus.",
                                style: TextStyle(
                                    fontFamily: "DMSans",
                                    fontSize: 12.sp,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                                width: 100.w,
                                child: CustomButton(
                                  title: "Get Started",
                                  color: AppColors.black,
                                ))
                          ],
                        ),
                      ),
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getDisplaySwitch(bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: isDarkMode ? AppColors.greyDot : AppColors.grey),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 8, bottom: 8, right: 10, left: 10),
                child: Text(
                  "Account",
                  style: TextStyle(
                      fontFamily: "DmSans",
                      fontSize: 14.sp,
                      color:
                          isDarkMode ? AppColors.white : AppColors.primaryColor,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 8, right: 10, left: 10),
                  child: Text(
                    "Invoice",
                    style: TextStyle(
                        fontFamily: "DmSans",
                        fontSize: 14.sp,
                        color: isDarkMode ? AppColors.grey : AppColors.greyText,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
