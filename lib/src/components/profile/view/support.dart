import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/help/view/complaint.dart';
import 'package:sprout_mobile/src/components/profile/controller/profile_controller.dart';
import 'package:sprout_mobile/src/public/screens/contact_us.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

import '../../../utils/app_svgs.dart';

// ignore: must_be_immutable
class SupportScreen extends StatelessWidget {
  SupportScreen({super.key});

  late ProfileController profileController;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    profileController = Get.put(ProfileController());
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getHeader(isDarkMode),
              addVerticalSpace(15.h),
              // Row(
              //   children: [
              //     SvgPicture.asset(AppSvg.faqs),
              //     Text(
              //       "FAQs",
              //       style: TextStyle(
              //           fontFamily: "Mont",
              //           fontSize: 14.sp,
              //           color: isDarkMode ? AppColors.white : AppColors.black,
              //           fontWeight: FontWeight.w500),
              //     )
              //   ],
              // ),
              // Divider(
              //   thickness: 0.3,
              //   color: isDarkMode
              //       ? AppColors.semi_white.withOpacity(0.3)
              //       : AppColors.inputLabelColor.withOpacity(0.6),
              // ),
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
                          fontFamily: "Mont",
                          fontSize: 14.sp,
                          color: isDarkMode ? AppColors.white : AppColors.black,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              Divider(
                thickness: 0.3,
                color: isDarkMode
                    ? AppColors.semi_white.withOpacity(0.3)
                    : AppColors.inputLabelColor.withOpacity(0.6),
              ),
              InkWell(
                onTap: () {
                  push(page: ComplaintScreen());
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppSvg.log,
                    ),
                    Text(
                      "Log a complaint",
                      style: TextStyle(
                          fontFamily: "Mont",
                          fontSize: 14.sp,
                          color: isDarkMode ? AppColors.white : AppColors.black,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              Divider(
                thickness: 0.3,
                color: isDarkMode
                    ? AppColors.semi_white.withOpacity(0.3)
                    : AppColors.inputLabelColor.withOpacity(0.6),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showPopUp(context, isDarkMode, theme) {
    showDialog(
      context: (context),
      builder: (BuildContext context) => ContactUs(
        heading: "Contact Customer Support",
        title: "0817-9435-965",
        phone: "+2348179435965",
      ),
    );
  }
}
