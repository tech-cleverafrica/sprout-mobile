import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_images.dart';
import '../../utils/app_svgs.dart';
import '../../utils/helper_widgets.dart';
import '../widgets/custom_button.dart';

class ApprovalScreen extends StatelessWidget {
  const ApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.mainGreen,
              AppColors.black,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          image: DecorationImage(
              image: AssetImage("assets/images/rough_background.png"),
              fit: BoxFit.cover)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              addVerticalSpace(60.h),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              Text(
                "Successful",
                style: TextStyle(
                    color: AppColors.white,
                    fontFamily: "DMSans",
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700),
              ),
              //     addHorizontalSpace(70.w),
              //     InkWell(
              //       onTap: () {},
              //       child: Container(
              //         height: 28,
              //         width: 28,
              //         decoration: BoxDecoration(
              //             shape: BoxShape.circle,
              //             border: Border.all(
              //               color: AppColors.white,
              //               width: 1.5,
              //             )),
              //         child: Center(
              //             child: Icon(
              //           Icons.more_horiz,
              //           color: AppColors.white,
              //         )),
              //       ),
              //     )
              //   ],
              // ),
              addVerticalSpace(26.h),
              Container(
                  height: 112.h,
                  width: 112.w,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFD9D9D9).withOpacity(0.4)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SvgPicture.asset(
                      AppSvg.mark,
                      color: AppColors.white,
                    ),
                  )),
              addVerticalSpace(20.h),
              Container(
                  width: 150.w,
                  child: Text(
                    "Approved",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "DMSans",
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white),
                  )),
              addVerticalSpace(150.h),

              Row(
                children: [
                  Container(
                    width: 246.w,
                    child: CustomButton(title: "Back To Home", onTap: () {}),
                  ),
                  addHorizontalSpace(8.w),
                  Expanded(
                      child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: AppColors.inputBackgroundColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(child: SvgPicture.asset(AppSvg.share)),
                  ))
                ],
              ),
              addVerticalSpace(20.h),
              Image.asset(AppImages.sprout_dark),
            ],
          ),
        ),
      ),
    );
  }
}
