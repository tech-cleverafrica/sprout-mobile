import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/complete-account-setup/view/document_upload.dart';

import 'package:sprout_mobile/src/utils/helper_widgets.dart';

import '../../../public/widgets/general_widgets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_svgs.dart';

class CompleteAccountSetupOptions extends StatelessWidget {
  const CompleteAccountSetupOptions({super.key});

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
              addVerticalSpace(29.h),
              InkWell(
                onTap: () {},
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(AppSvg.kin),
                          addHorizontalSpace(10.w),
                          Text(
                            "Next of Kin",
                            style: TextStyle(
                                fontFamily: "DMSans",
                                fontSize: 14.sp,
                                color: isDarkMode
                                    ? AppColors.white
                                    : AppColors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Divider(
                          thickness: 0.4,
                          color: isDarkMode
                              ? AppColors.semi_white.withOpacity(0.3)
                              : AppColors.black.withOpacity(0.3)),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(AppSvg.business),
                          addHorizontalSpace(10.w),
                          Text(
                            "Business Details",
                            style: TextStyle(
                                fontFamily: "DMSans",
                                fontSize: 14.sp,
                                color: isDarkMode
                                    ? AppColors.white
                                    : AppColors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Divider(
                          thickness: 0.4,
                          color: isDarkMode
                              ? AppColors.semi_white.withOpacity(0.3)
                              : AppColors.black.withOpacity(0.3)),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => DocumentUpload());
                },
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(AppSvg.upload_doc),
                          addHorizontalSpace(10.w),
                          Text(
                            "Upload Documents",
                            style: TextStyle(
                                fontFamily: "DMSans",
                                fontSize: 14.sp,
                                color: isDarkMode
                                    ? AppColors.white
                                    : AppColors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Divider(
                          thickness: 0.4,
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
    );
  }
}
