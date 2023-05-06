import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/borow/view/nfc_page.dart';
import 'package:sprout_mobile/src/components/borow/view/payment_link.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/helper_widgets.dart';

class BorrowScren extends StatelessWidget {
  const BorrowScren({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getHeader(isDarkMode),
                addVerticalSpace(29.h),
                InkWell(
                  onTap: () {
                    Get.to(() => NFCScreen());
                  },
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(AppSvg.pay),
                            addHorizontalSpace(10.w),
                            Text(
                              "Tap to pay",
                              style: TextStyle(
                                  fontFamily: "Mont",
                                  fontSize: 14.sp,
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Divider(
                            thickness: 0.1,
                            color: isDarkMode
                                ? AppColors.semi_white.withOpacity(0.3)
                                : AppColors.black.withOpacity(0.3)),
                      ],
                    ),
                  ),
                ),
                addVerticalSpace(10.h),
                InkWell(
                  onTap: () {
                    Get.to(() => PaymentLinkScreen());
                    // Get.to(() => RequestPayment());
                  },
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(AppSvg.request),
                            addHorizontalSpace(10.w),
                            Text(
                              "Create Payment Link",
                              style: TextStyle(
                                  fontFamily: "Mont",
                                  fontSize: 14.sp,
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Divider(
                            thickness: 0.1,
                            color: isDarkMode
                                ? AppColors.semi_white.withOpacity(0.3)
                                : AppColors.black.withOpacity(0.3)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
